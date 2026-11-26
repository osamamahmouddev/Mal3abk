import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/utils/cairo_time.dart';
import 'package:mal3abk/features/venue_calendar/data/models/calendar_slot_model.dart';
import 'package:mal3abk/features/venue_calendar/data/models/manual_booking_request_body.dart';
import 'package:mal3abk/features/venue_calendar/domain/repos/venue_calendar_repo.dart';
import 'package:mal3abk/features/venue_calendar/presentation/cubit/manual_booking_cubit.dart';
import 'package:mal3abk/features/venue_calendar/presentation/cubit/venue_calendar_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockVenueCalendarRepo extends Mock implements VenueCalendarRepo {}

class FakeManualBody extends Fake implements ManualBookingRequestBody {}

CalendarSlotModel slot({
  String status = 'Confirmed',
  bool manual = false,
  bool tentative = false,
  String start = '2026-12-01T18:00:00Z',
  String end = '2026-12-01T19:00:00Z',
}) => CalendarSlotModel(
  id: 's1',
  pitchId: 'p1',
  startUtc: start,
  endUtc: end,
  status: status,
  isManual: manual,
  isTentative: tentative,
);

void main() {
  setUpAll(() {
    CairoTime.initialize();
    registerFallbackValue(FakeManualBody());
    registerFallbackValue(DateTime(2026));
  });

  group('CalendarSlotModel', () {
    test('kinds follow the web colours', () {
      expect(slot(status: 'Blocked').kind, CalendarSlotKind.blocked);
      expect(slot(tentative: true).kind, CalendarSlotKind.tentative);
      expect(slot(status: 'PendingDeposit').kind, CalendarSlotKind.waiting);
      expect(slot(status: 'UnderReview').kind, CalendarSlotKind.review);
      expect(slot().kind, CalendarSlotKind.confirmed);
    });

    test('only manual bookings can be freed from the calendar', () {
      expect(slot(manual: true).isOpenManual, isTrue);
      expect(slot().isOpenManual, isFalse);
    });
  });

  group('VenueCalendarCubit helpers', () {
    test('weeks start on Saturday', () {
      // 2026-11-26 is a Thursday.
      expect(
        VenueCalendarCubit.weekStart(DateTime(2026, 11, 26)),
        DateTime(2026, 11, 21),
      );
      expect(
        VenueCalendarCubit.weekStart(DateTime(2026, 11, 21)),
        DateTime(2026, 11, 21),
      );
    });
  });

  group('BusinessClock', () {
    test('late night hours belong to the same night', () {
      expect(BusinessClock.toMinutes(8, 0, night: true), 20 * 60);
      expect(BusinessClock.toMinutes(12, 0, night: true), 24 * 60);
      expect(BusinessClock.toMinutes(1, 30, night: true), 25 * 60 + 30);
      expect(BusinessClock.toMinutes(10, 0, night: false), 10 * 60);
      expect(BusinessClock.toMinutes(3, 0, night: false), 15 * 60);
    });

    test('round-trips', () {
      for (final m in [7 * 60, 12 * 60, 15 * 60, 20 * 60, 24 * 60, 26 * 60]) {
        final p = BusinessClock.fromMinutes(m);
        expect(BusinessClock.toMinutes(p.hour12, p.minute, night: p.night), m);
      }
    });
  });

  group('ManualBookingCubit', () {
    late MockVenueCalendarRepo repo;

    setUp(() {
      repo = MockVenueCalendarRepo();
      when(
        () => repo.getCalendar(
          any(),
          fromUtc: any(named: 'fromUtc'),
          toUtc: any(named: 'toUtc'),
          pitchId: any(named: 'pitchId'),
        ),
      ).thenAnswer((_) async => const ApiResult.success([]));
      when(
        () => repo.previewPrice(
          any(),
          pitchId: any(named: 'pitchId'),
          startUtc: any(named: 'startUtc'),
          endUtc: any(named: 'endUtc'),
        ),
      ).thenAnswer((_) async => 400);
    });

    ManualBookingCubit build() => ManualBookingCubit(
      venueCalendarRepo: repo,
      venueId: 'v1',
      pitchId: 'p1',
      date: DateTime(2030, 1, 1),
    );

    test('suggests the price from the rules', () async {
      final cubit = build();
      await cubit.init();
      expect(cubit.state.suggestedPrice, 400);
      await cubit.close();
    });

    test('checks the deposit rules', () async {
      final cubit = build();
      cubit.setPayment(ManualPaymentStatus.deposit);
      await cubit.submit(
        customerName: '',
        customerPhone: '',
        price: '400',
        deposit: '400',
        notes: '',
      );
      expect(
        cubit.state.errors['deposit'],
        'venue.manual.errors.deposit_not_less',
      );
      await cubit.submit(
        customerName: '',
        customerPhone: '123',
        price: '',
        deposit: '100',
        notes: '',
      );
      expect(cubit.state.errors['price'], 'venue.manual.errors.price_missing');
      expect(cubit.state.errors['phone'], 'venue.manual.errors.phone');
      verifyNever(() => repo.createManualBooking(any(), any()));
      await cubit.close();
    });

    test('blocks a time that overlaps a booking', () async {
      when(
        () => repo.getCalendar(
          any(),
          fromUtc: any(named: 'fromUtc'),
          toUtc: any(named: 'toUtc'),
          pitchId: any(named: 'pitchId'),
        ),
      ).thenAnswer((_) async {
        final start = VenueCalendarCubit.dayStartUtc(
          DateTime(2030, 1, 1),
        ).add(const Duration(hours: 20));
        return ApiResult.success([
          slot(
            start: start.toIso8601String(),
            end: start.add(const Duration(hours: 1)).toIso8601String(),
          ),
        ]);
      });
      final cubit = build();
      await cubit.init();
      expect(cubit.conflict, isNotNull);
      await cubit.submit(
        customerName: '',
        customerPhone: '',
        price: '400',
        deposit: '',
        notes: '',
      );
      expect(cubit.state.errors['time'], 'venue.manual.errors.slot_taken');
      await cubit.close();
    });

    test('sends a paid-in-full booking', () async {
      ManualBookingRequestBody? sent;
      when(() => repo.createManualBooking('v1', any())).thenAnswer((inv) async {
        sent = inv.positionalArguments[1] as ManualBookingRequestBody;
        return const ApiResult.success(null);
      });
      final cubit = build();
      await cubit.submit(
        customerName: 'Ali',
        customerPhone: '010 1234 5678',
        price: '400',
        deposit: '',
        notes: '',
      );
      expect(cubit.state.done, isTrue);
      expect(sent?.paymentStatus, ManualPaymentStatus.full.value);
      expect(sent?.depositAmount, isNull);
      expect(sent?.customerPhone, '01012345678');
      await cubit.close();
    });
  });
}
