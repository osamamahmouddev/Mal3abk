import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/core/services/realtime_service.dart';
import 'package:mal3abk/core/utils/cairo_time.dart';
import 'package:mal3abk/features/booking/data/models/booking_quote_request_body.dart';
import 'package:mal3abk/features/booking/data/models/booking_quote_response_model.dart';
import 'package:mal3abk/features/booking/data/models/create_booking_request_body.dart';
import 'package:mal3abk/features/booking/domain/use_cases/create_booking_use_case.dart';
import 'package:mal3abk/features/booking/domain/use_cases/get_booking_detail_use_case.dart';
import 'package:mal3abk/features/booking/domain/use_cases/get_booking_quote_use_case.dart';
import 'package:mal3abk/features/booking/presentation/cubit/booking_details_cubit.dart';
import 'package:mal3abk/features/explore/data/models/venue_availability_model.dart';
import 'package:mal3abk/features/explore/domain/use_cases/get_venue_availability_use_case.dart';
import 'package:mal3abk/features/explore/presentation/cubit/pitch_booking_cubit.dart';
import 'package:mal3abk/features/explore/presentation/cubit/pitch_booking_state.dart';
import 'package:mocktail/mocktail.dart';

class _MockAvailability extends Mock implements GetVenueAvailabilityUseCase {}

class _MockQuote extends Mock implements GetBookingQuoteUseCase {}

class _MockCreate extends Mock implements CreateBookingUseCase {}

class _MockDetail extends Mock implements GetBookingDetailUseCase {}

/// Live updates pushed by hand, and the venue days asked for recorded.
class _FakeRealtime implements RealtimeService {
  final slots = StreamController<SlotStatusUpdate>.broadcast();
  final bookings = StreamController<BookingStatusUpdate>.broadcast();
  final reconnects = StreamController<void>.broadcast();
  final watched = <String>[];
  final left = <String>[];

  @override
  Stream<SlotStatusUpdate> get slotUpdates => slots.stream;
  @override
  Stream<BookingStatusUpdate> get bookingUpdates => bookings.stream;
  @override
  Stream<void> get reconnected => reconnects.stream;
  @override
  Future<void> watchVenue(String venueId, String date) async =>
      watched.add('$venueId|$date');
  @override
  Future<void> leaveVenue(String venueId, String date) async =>
      left.add('$venueId|$date');
  @override
  Future<void> connect() async {}
  @override
  Future<void> disconnect() async {}
}

const _venue = 'venue-1';
const _pitch = 'pitch-1';
const _nine = '2026-11-20T07:00:00Z';
const _ten = '2026-11-20T08:00:00Z';

SlotModel _slot(String start, int state) => SlotModel(
  startUtc: start,
  endUtc: start.replaceFirst(RegExp(r'T\d\d'), 'T${_hourAfter(start)}'),
  startLocal: '',
  endLocal: '',
  state: state,
  price: 400,
);

String _hourAfter(String start) =>
    (int.parse(start.substring(11, 13)) + 1).toString().padLeft(2, '0');

VenueAvailabilityModel _day({int nine = 0, int ten = 0}) =>
    VenueAvailabilityModel(
      venueId: _venue,
      businessDate: '2026-11-20',
      currency: 'EGP',
      generatedAtUtc: '2026-11-19T10:00:00Z',
      pitches: [
        PitchSlotsModel(
          pitchId: _pitch,
          name: 'Main',
          slotMinutes: 60,
          incrementMinutes: 60,
          slots: [_slot(_nine, nine), _slot(_ten, ten)],
        ),
      ],
    );

SlotStatusUpdate _update(String start, String status, {int second = 1}) =>
    SlotStatusUpdate(
      venueId: _venue,
      pitchId: _pitch,
      startUtc: DateTime.parse(start),
      endUtc: DateTime.parse(start).add(const Duration(hours: 1)),
      status: status,
      changedAtUtc: DateTime.utc(2026, 11, 19, 12, 0, second),
    );

const _quote = BookingQuoteResponseModel(
  quoteToken: 'q',
  expiresAtUtc: '2026-11-19T12:15:00Z',
  currency: 'EGP',
  subtotal: 400,
  discount: 0,
  fees: 0,
  total: 400,
  deposit: 120,
  remainingBalance: 280,
  subjectToConfirmation: true,
  confirmationNote: '',
);

const _taken = AppApiFailure(
  message: 'errors.booking.slot_taken',
  code: 'Booking.SlotOverlap',
  statusCode: 409,
);

void main() {
  late _MockAvailability availability;
  late _MockQuote quote;
  late _MockCreate create;
  late _FakeRealtime realtime;
  late PitchBookingCubit cubit;

  setUpAll(() {
    CairoTime.initialize();
    registerFallbackValue(
      const BookingQuoteRequestBody(pitchId: '', startUtc: '', endUtc: ''),
    );
    registerFallbackValue(
      const CreateBookingRequestBody(
        pitchId: '',
        startUtc: '',
        endUtc: '',
        quoteToken: '',
        expectedPrice: 0,
      ),
    );
  });

  setUp(() {
    availability = _MockAvailability();
    quote = _MockQuote();
    create = _MockCreate();
    realtime = _FakeRealtime();
    when(
      () => availability(any(), any()),
    ).thenAnswer((_) async => ApiResult.success(_day()));
    // The price is not what these tests are about.
    when(() => quote(any())).thenAnswer(
      (_) async => const ApiResult.failure(AppApiFailure(message: 'x')),
    );
    cubit = PitchBookingCubit(
      getVenueAvailabilityUseCase: availability,
      getBookingQuoteUseCase: quote,
      createBookingUseCase: create,
      realtime: realtime,
    );
  });

  tearDown(() => cubit.close());

  PitchBookingLoaded loaded() => cubit.state as PitchBookingLoaded;

  int stateOf(String start) =>
      loaded().currentPitch!.slots.firstWhere((s) => s.startUtc == start).state;

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  group('PitchBookingCubit quotes', () {
    test('a slow price for a slot the player left never lands on the new '
        'one', () async {
      final slow = Completer<ApiResult<BookingQuoteResponseModel>>();
      when(() => quote(any())).thenAnswer((call) {
        final body = call.positionalArguments.first as BookingQuoteRequestBody;
        return body.startUtc == _nine
            ? slow.future
            : Future.value(const ApiResult.success(_quote));
      });

      final first = cubit.loadAvailability(_venue);
      await settle();
      await cubit.selectSlot(loaded().currentPitch!.slots[1]);
      slow.complete(
        const ApiResult.success(
          BookingQuoteResponseModel(
            quoteToken: 'stale',
            expiresAtUtc: '2026-11-19T12:15:00Z',
            currency: 'EGP',
            subtotal: 999,
            discount: 0,
            fees: 0,
            total: 999,
            deposit: 0,
            remainingBalance: 999,
            subjectToConfirmation: true,
            confirmationNote: '',
          ),
        ),
      );
      await first;

      expect(loaded().selectedSlot!.startUtc, _ten);
      expect(loaded().quote!.quoteToken, 'q');
      expect(loaded().isQuoting, isFalse);
    });

    test('opening the review without a price asks for it again', () async {
      await cubit.loadAvailability(_venue);
      expect(loaded().quote, isNull, reason: 'the first quote failed');
      when(
        () => quote(any()),
      ).thenAnswer((_) async => const ApiResult.success(_quote));

      await cubit.ensureQuote();

      expect(loaded().quote, _quote);
    });
  });

  group('PitchBookingCubit live slots', () {
    test('follows the day on screen and switches with it', () async {
      await cubit.loadAvailability(_venue);
      final firstDay = realtime.watched.single;

      await cubit.selectDay(1);

      expect(realtime.watched, hasLength(2));
      expect(realtime.left, [firstDay]);
    });

    test('someone else takes the selected slot: it closes and the player is '
        'warned', () async {
      await cubit.loadAvailability(_venue);
      expect(loaded().selectedSlot!.startUtc, _nine);

      realtime.slots.add(_update(_nine, 'held'));
      await settle();

      expect(stateOf(_nine), 1);
      expect(loaded().selectedSlotTaken, isTrue);
    });

    test('another slot closing changes only that slot', () async {
      await cubit.loadAvailability(_venue);

      realtime.slots.add(_update(_ten, 'booked'));
      await settle();

      expect(stateOf(_ten), 2);
      expect(stateOf(_nine), 0);
      expect(loaded().selectedSlotTaken, isFalse);
    });

    test('a freed slot opens again and the warning clears', () async {
      await cubit.loadAvailability(_venue);
      realtime.slots.add(_update(_nine, 'held'));
      await settle();

      realtime.slots.add(_update(_nine, 'free', second: 2));
      await settle();

      expect(stateOf(_nine), 0);
      expect(loaded().selectedSlotTaken, isFalse);
    });

    test('an update older than the last one is ignored', () async {
      await cubit.loadAvailability(_venue);
      realtime.slots.add(_update(_ten, 'held', second: 5));
      await settle();

      realtime.slots.add(_update(_ten, 'free', second: 3));
      await settle();

      expect(stateOf(_ten), 1);
    });

    test('updates for another venue are ignored', () async {
      await cubit.loadAvailability(_venue);

      realtime.slots.add(
        SlotStatusUpdate(
          venueId: 'other-venue',
          pitchId: _pitch,
          startUtc: DateTime.parse(_nine),
          endUtc: DateTime.parse(_ten),
          status: 'booked',
          changedAtUtc: DateTime.utc(2026, 11, 19, 12),
        ),
      );
      await settle();

      expect(stateOf(_nine), 0);
    });

    test('after a reconnect the day reloads and keeps the selection', () async {
      await cubit.loadAvailability(_venue);
      when(
        () => availability(any(), any()),
      ).thenAnswer((_) async => ApiResult.success(_day(ten: 2)));

      realtime.reconnects.add(null);
      await settle();
      await settle();

      expect(stateOf(_ten), 2, reason: 'missed while offline');
      expect(loaded().selectedSlot!.startUtc, _nine);
      verify(() => availability(_venue, any())).called(2);
    });

    test('losing the race marks the slot taken and reloads the day', () async {
      await cubit.loadAvailability(_venue);
      cubit.emit(loaded().copyWith(quote: _quote));
      when(
        () => create(
          body: any(named: 'body'),
          idempotencyKey: any(named: 'idempotencyKey'),
        ),
      ).thenAnswer((_) async => const ApiResult.failure(_taken));
      when(
        () => availability(any(), any()),
      ).thenAnswer((_) async => ApiResult.success(_day(nine: 1)));

      expect(await cubit.createBookingHold(), isFalse);
      await settle();

      expect(loaded().selectedSlotTaken, isTrue);
      expect(loaded().bookingError, _taken.message);
      expect(stateOf(_nine), 1, reason: 'the day is reloaded as it is now');
    });

    test('my own hold does not warn me about my own slot', () async {
      await cubit.loadAvailability(_venue);
      cubit.emit(loaded().copyWith(isBooking: true));

      realtime.slots.add(_update(_nine, 'held'));
      await settle();

      expect(stateOf(_nine), 1);
      expect(loaded().selectedSlotTaken, isFalse);
    });

    test('closing leaves the venue day', () async {
      await cubit.loadAvailability(_venue);
      final day = realtime.watched.single;

      await cubit.close();

      expect(realtime.left, contains(day));
    });
  });

  group('BookingDetailsCubit live', () {
    test('reloads when its booking changes, not for other bookings', () async {
      final detail = _MockDetail();
      when(() => detail(any())).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'x')),
      );
      final details = BookingDetailsCubit(
        getBookingDetailUseCase: detail,
        realtime: realtime,
      );
      addTearDown(details.close);
      await details.load('booking-1');

      realtime.bookings.add(
        const BookingStatusUpdate(bookingId: 'booking-2', status: 'Confirmed'),
      );
      await settle();
      verify(() => detail('booking-1')).called(1);

      realtime.bookings.add(
        const BookingStatusUpdate(bookingId: 'booking-1', status: 'Confirmed'),
      );
      await settle();
      verify(() => detail('booking-1')).called(1);
    });
  });
}
