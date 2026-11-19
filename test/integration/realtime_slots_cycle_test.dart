@Tags(['integration'])
@Timeout(Duration(minutes: 2))
library;

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/config/env_config.dart';
import 'package:mal3abk/core/services/realtime_service.dart';
import 'package:mal3abk/features/booking/data/apis/booking_api_service.dart';
import 'package:mal3abk/features/booking/data/models/booking_quote_request_body.dart';
import 'package:mal3abk/features/booking/data/models/create_booking_request_body.dart';
import 'package:mal3abk/features/booking/data/repos/booking_repo_impl.dart';
import 'package:mal3abk/features/explore/data/apis/explore_api_service.dart';
import 'package:mal3abk/features/explore/data/models/venue_availability_model.dart';
import 'package:mal3abk/features/explore/data/repos/explore_repo_impl.dart';

import 'support/local_stack.dart';

/// Live slots end to end against the local stack, through the app's own
/// SignalR client: a player watching a venue day hears another player's
/// hold within a second, and two players booking the same slot at the same
/// moment end with exactly one booking.
///
///     flutter test test/integration/realtime_slots_cycle_test.dart
void main() {
  late bool stackUp;
  setUpAll(() async => stackUp = await LocalStack.start());

  BookingRepoImpl bookingsOf(LocalPlayer p) =>
      BookingRepoImpl(bookingApiService: BookingApiService(p.dio), dio: p.dio);

  RealtimeService realtimeOf(LocalPlayer p) =>
      SignalRRealtimeService(dio: p.dio, envConfig: const _LocalEnv());

  /// A free slot at a seeded venue a few days out, with its venue and date.
  Future<(String venueId, String date, PitchSlotsModel, SlotModel)> freeSlot(
    LocalPlayer player,
  ) async {
    final explore = ExploreRepoImpl(
      exploreApiService: ExploreApiService(player.dio),
    );
    final venues = ok(await explore.exploreVenues(), 'explore').items;
    for (var offset = 2; offset < 7; offset++) {
      final day = DateTime.now().toUtc().add(Duration(days: offset));
      final date =
          '${day.year}-${day.month.toString().padLeft(2, '0')}-'
          '${day.day.toString().padLeft(2, '0')}';
      for (final venue in venues) {
        final availability = ok(
          await explore.getVenueAvailability(venue.venueId, date),
          'availability',
        );
        for (final pitch in availability.pitches) {
          for (final slot in pitch.slots) {
            if (slot.isAvailable) return (venue.venueId, date, pitch, slot);
          }
        }
      }
    }
    throw TestFailure('no free slot in the next days');
  }

  Future<Response<dynamic>> book(
    LocalPlayer player,
    PitchSlotsModel pitch,
    SlotModel slot,
  ) async {
    final quote = ok(
      await bookingsOf(player).getQuote(
        BookingQuoteRequestBody(
          pitchId: pitch.pitchId,
          startUtc: slot.startUtc,
          endUtc: slot.endUtc,
        ),
      ),
      '${player.name} quote',
    );
    return player.dio.post<dynamic>(
      '/api/v1/bookings',
      data: CreateBookingRequestBody(
        pitchId: pitch.pitchId,
        startUtc: slot.startUtc,
        endUtc: slot.endUtc,
        quoteToken: quote.quoteToken,
        expectedPrice: quote.total,
      ).toJson(),
      options: Options(
        headers: {
          'Idempotency-Key':
              'live-${player.id}-${DateTime.now().microsecondsSinceEpoch}',
        },
        validateStatus: (_) => true,
      ),
    );
  }

  group('realtime slots', () {
    test(
      'a watcher hears another player hold the slot, within a second',
      () async {
        if (!LocalStack.ready(stackUp)) return;
        final watcher = await LocalStack.newPlayer('Watcher');
        final booker = await LocalStack.newPlayer('Booker');
        final (venueId, date, pitch, slot) = await freeSlot(watcher);

        final live = realtimeOf(watcher);
        addTearDown(live.disconnect);
        final heard = live.slotUpdates
            .where(
              (u) =>
                  u.pitchId == pitch.pitchId &&
                  u.startUtc.isAtSameMomentAs(DateTime.parse(slot.startUtc)),
            )
            .first;
        await live.watchVenue(venueId, date);

        final sentAt = DateTime.now();
        final created = await book(booker, pitch, slot);
        expect(created.statusCode, anyOf(200, 201), reason: '${created.data}');

        final update = await heard.timeout(const Duration(seconds: 5));
        final latency = DateTime.now().difference(sentAt);
        // ignore: avoid_print
        print(
          'slot closed for the watcher ${latency.inMilliseconds} ms after the booking request',
        );
        expect(update.status, 'held');
        expect(update.isFree, isFalse);
        expect(update.venueId, venueId);
        expect(
          latency,
          lessThan(const Duration(seconds: 2)),
          reason:
              'the slot closed for others ${latency.inMilliseconds} ms '
              'after the booking request',
        );
      },
    );

    test('two players booking the same slot at once: one booking, the other '
        'is told the slot is taken (409)', () async {
      if (!LocalStack.ready(stackUp)) return;
      final first = await LocalStack.newPlayer('Racer One');
      final second = await LocalStack.newPlayer('Racer Two');
      final (_, _, pitch, slot) = await freeSlot(first);

      final results = await Future.wait([
        book(first, pitch, slot),
        book(second, pitch, slot),
      ]);
      final codes = results.map((r) => r.statusCode).toList();

      expect(
        codes.where((c) => c == 200 || c == 201),
        hasLength(1),
        reason: 'exactly one booking: $codes',
      );
      final loser = results.firstWhere(
        (r) => r.statusCode != 200 && r.statusCode != 201,
      );
      expect(loser.statusCode, 409, reason: '${loser.data}');
      expect(
        (loser.data as Map)['title'] ?? (loser.data as Map)['errorCode'],
        anyOf('Booking.SlotOverlap', 'Quote.SlotUnavailable'),
      );
    });

    test('a guest without a session gets no connection and no error', () async {
      if (!LocalStack.ready(stackUp)) return;
      final guest = SignalRRealtimeService(
        dio: paced(Dio(BaseOptions(baseUrl: LocalStack.apiUrl))),
        envConfig: const _LocalEnv(),
      );
      // Must not throw: the screens keep working without live updates.
      await guest.watchVenue(
        '00000000-0000-0000-0000-000000000001',
        '2026-01-01',
      );
      await guest.disconnect();
    });
  });
}

class _LocalEnv extends DevEnvConfig {
  const _LocalEnv();

  @override
  String get baseUrl => LocalStack.apiUrl;
}
