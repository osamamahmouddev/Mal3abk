@Tags(['integration'])
library;

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:mal3abk/features/booking/data/apis/booking_api_service.dart';
import 'package:mal3abk/features/booking/data/models/booking_quote_request_body.dart';
import 'package:mal3abk/features/booking/data/models/booking_status.dart';
import 'package:mal3abk/features/booking/data/models/create_booking_request_body.dart';
import 'package:mal3abk/features/booking/data/repos/booking_repo_impl.dart';
import 'package:mal3abk/features/explore/data/apis/explore_api_service.dart';
import 'package:mal3abk/features/explore/data/repos/explore_repo_impl.dart';

import 'support/local_stack.dart';

/// Paying the deposit end to end: a player holds a slot at a venue, uploads
/// the transfer receipt, the venue owner approves or rejects it, and the
/// player's booking and inbox follow. Uses the seeded owner (+201100000001)
/// and their venues.
///
///     flutter test test/integration/booking_payment_cycle_test.dart
void main() {
  late bool stackUp;
  setUpAll(() async => stackUp = await LocalStack.start());

  const ownerPhone = '+201100000001';
  // Inside every venue's advance window, spread so runs rarely collide.
  var dayOffset = 1 + Random().nextInt(4);

  /// The seeded owner, signed in, with the venues they may review for.
  Future<(LocalPlayer, List<String>)> owner() async {
    final owner = await LocalStack.newPlayer('Owner', phone: ownerPhone);
    final perms = await owner.dio.get<Map<String, dynamic>>(
      '/api/v1/me/permissions',
    );
    final venues = (perms.data!['venues'] as List)
        .cast<Map<String, dynamic>>()
        .where(
          (v) => (v['permissions'] as List).any(
            (p) => (p as String).toLowerCase().contains('proof'),
          ),
        )
        .map((v) => v['venueId'] as String)
        .toList();
    return (owner, venues);
  }

  /// A held booking at one of [venueIds] with its receipt submitted.
  Future<(String bookingId, String venueId)> bookAndSubmitProof(
    LocalPlayer player,
    List<String> venueIds,
    BookingRepoImpl bookings,
  ) async {
    final explore = ExploreRepoImpl(
      exploreApiService: ExploreApiService(player.dio),
    );
    for (final venueId in venueIds) {
      dayOffset = dayOffset % 6 + 1;
      final day = DateTime.now().toUtc().add(Duration(days: dayOffset));
      final date =
          '${day.year}-${day.month.toString().padLeft(2, '0')}-'
          '${day.day.toString().padLeft(2, '0')}';
      final availability = ok(
        await explore.getVenueAvailability(venueId, date),
        'availability',
      );
      for (final pitch in availability.pitches) {
        for (final slot in pitch.slots.where((s) => s.isAvailable)) {
          final quote = ok(
            await bookings.getQuote(
              BookingQuoteRequestBody(
                pitchId: pitch.pitchId,
                startUtc: slot.startUtc,
                endUtc: slot.endUtc,
              ),
            ),
            'quote',
          );
          final created = ok(
            await bookings.createBooking(
              body: CreateBookingRequestBody(
                pitchId: pitch.pitchId,
                startUtc: slot.startUtc,
                endUtc: slot.endUtc,
                quoteToken: quote.quoteToken,
                expectedPrice: quote.total,
              ),
              idempotencyKey:
                  'pay-cycle-${DateTime.now().microsecondsSinceEpoch}',
            ),
            'create booking',
          );
          final ticket = ok(
            await bookings.getProofUploadUrl(created.bookingId),
            'upload url',
          );
          ok(
            await bookings.uploadMediaFile(
              uploadUrl: ticket.uploadUrl,
              bytes: _receipt(),
              contentType: 'image/png',
            ),
            'upload receipt',
          );
          ok(
            await bookings.submitProof(
              id: created.bookingId,
              mediaId: ticket.mediaId,
              notes: 'InstaPay',
            ),
            'submit proof',
          );
          return (created.bookingId, venueId);
        }
      }
    }
    throw TestFailure('no free slot at the owner\'s venues');
  }

  Future<Response<dynamic>> review(
    LocalPlayer reviewer,
    String venueId,
    String bookingId, {
    required bool approved,
    String? reason,
  }) => reviewer.dio.post<dynamic>(
    '/api/v1/venue-manager/venues/$venueId/bookings/$bookingId/proof/review',
    data: {'approved': approved, 'rejectionReason': ?reason},
    options: Options(validateStatus: (_) => true),
  );

  group('booking payment cycle', () {
    test('the owner approves the receipt: the booking is confirmed and the '
        'player is told', () async {
      if (!LocalStack.ready(stackUp)) return;
      final (owner_, venues) = await owner();
      if (venues.isEmpty) {
        markTestSkipped('the seeded owner reviews no venue');
        return;
      }
      final player = await LocalStack.newPlayer('Payer');
      final bookings = BookingRepoImpl(
        bookingApiService: BookingApiService(player.dio),
        dio: player.dio,
      );
      final (bookingId, venueId) = await bookAndSubmitProof(
        player,
        venues,
        bookings,
      );
      expect(
        ok(await bookings.getBookingDetail(bookingId), 'detail').status,
        BookingStatus.proofSubmitted,
      );

      final approved = await review(owner_, venueId, bookingId, approved: true);
      expect(approved.statusCode, 200, reason: '${approved.data}');

      expect(
        ok(await bookings.getBookingDetail(bookingId), 'detail').status,
        BookingStatus.confirmed,
      );
      final n = await LocalStack.notificationFor(player, 'booking.confirmed');
      expect(n.deepLink, contains(bookingId));

      // A decided receipt cannot be decided again.
      final twice = await review(owner_, venueId, bookingId, approved: false);
      expect(twice.statusCode, isNot(200));
    }, timeout: const Timeout(Duration(minutes: 3)));

    test('the owner rejects the receipt: the player is told why', () async {
      if (!LocalStack.ready(stackUp)) return;
      final (owner_, venues) = await owner();
      if (venues.isEmpty) {
        markTestSkipped('the seeded owner reviews no venue');
        return;
      }
      final player = await LocalStack.newPlayer('Rejected Payer');
      final bookings = BookingRepoImpl(
        bookingApiService: BookingApiService(player.dio),
        dio: player.dio,
      );
      final (bookingId, venueId) = await bookAndSubmitProof(
        player,
        venues,
        bookings,
      );

      final rejected = await review(
        owner_,
        venueId,
        bookingId,
        approved: false,
        reason: 'Amount does not match',
      );
      expect(rejected.statusCode, 200, reason: '${rejected.data}');
      final detail = ok(await bookings.getBookingDetail(bookingId), 'detail');
      expect(detail.status, isNot(BookingStatus.confirmed));
      await LocalStack.notificationFor(player, 'booking.rejected');
    }, timeout: const Timeout(Duration(minutes: 3)));

    test('only staff of that venue can review its receipts', () async {
      if (!LocalStack.ready(stackUp)) return;
      final (_, venues) = await owner();
      if (venues.isEmpty) {
        markTestSkipped('the seeded owner reviews no venue');
        return;
      }
      final player = await LocalStack.newPlayer('Self Approver');
      final bookings = BookingRepoImpl(
        bookingApiService: BookingApiService(player.dio),
        dio: player.dio,
      );
      final (bookingId, venueId) = await bookAndSubmitProof(
        player,
        venues,
        bookings,
      );

      // The player cannot approve their own payment.
      final self = await review(player, venueId, bookingId, approved: true);
      expect(self.statusCode, anyOf(401, 403, 404));
      expect(
        ok(await bookings.getBookingDetail(bookingId), 'detail').status,
        BookingStatus.proofSubmitted,
      );
    }, timeout: const Timeout(Duration(minutes: 3)));
  });
}

/// A different image every run: the API rejects a receipt it has seen.
List<int> _receipt() {
  final random = Random();
  final image = img.Image(width: 64, height: 64);
  for (final pixel in image) {
    pixel
      ..r = random.nextInt(256)
      ..g = random.nextInt(256)
      ..b = random.nextInt(256);
  }
  return img.encodePng(image);
}
