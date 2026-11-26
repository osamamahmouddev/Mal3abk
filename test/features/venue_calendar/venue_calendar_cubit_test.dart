import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/core/utils/cairo_time.dart';
import 'package:mal3abk/features/venue_calendar/data/models/calendar_slot_model.dart';
import 'package:mal3abk/features/venue_calendar/data/models/manual_booking_request_body.dart';
import 'package:mal3abk/features/venue_calendar/domain/repos/venue_calendar_repo.dart';
import 'package:mal3abk/features/venue_calendar/presentation/calendar_layout.dart';
import 'package:mal3abk/features/venue_calendar/presentation/cubit/venue_calendar_cubit.dart';
import 'package:mal3abk/features/venue_calendar/presentation/cubit/venue_calendar_state.dart';
import 'package:mocktail/mocktail.dart';

class MockVenueCalendarRepo extends Mock implements VenueCalendarRepo {}

CalendarSlotModel slot(
  String id, {
  String status = 'Confirmed',
  bool manual = false,
}) => CalendarSlotModel(
  id: id,
  pitchId: 'p1',
  startUtc: '2026-12-01T18:00:00Z',
  endUtc: '2026-12-01T19:00:00Z',
  status: status,
  isManual: manual,
);

void main() {
  late MockVenueCalendarRepo repo;
  late VenueCalendarCubit cubit;

  setUpAll(() {
    CairoTime.initialize();
    registerFallbackValue(DateTime(2026));
    registerFallbackValue(ManualPaymentStatus.full);
  });

  setUp(() async {
    repo = MockVenueCalendarRepo();
    when(
      () => repo.getSchedules(any()),
    ).thenAnswer((_) async => const ApiResult.success([]));
    when(
      () => repo.getCalendar(
        any(),
        fromUtc: any(named: 'fromUtc'),
        toUtc: any(named: 'toUtc'),
        pitchId: any(named: 'pitchId'),
      ),
    ).thenAnswer((_) async => ApiResult.success([slot('s1')]));
    cubit = VenueCalendarCubit(
      venueCalendarRepo: repo,
      refreshInterval: Duration.zero,
    );
    await cubit.start('v1', firstPitchId: 'p1');
  });

  tearDown(() => cubit.close());

  test('loads the day, keeps the first pitch for the week view', () {
    expect(cubit.state.slots.single.id, 's1');
    expect(cubit.state.weekPitchId, 'p1');
    expect(cubit.state.isLoading, isFalse);
  });

  test('views and steps ask for the right range', () async {
    cubit.setView(VenueCalendarView.week);
    await Future<void>.delayed(Duration.zero);
    final week = verify(
      () => repo.getCalendar(
        'v1',
        fromUtc: captureAny(named: 'fromUtc'),
        toUtc: captureAny(named: 'toUtc'),
        pitchId: 'p1',
      ),
    ).captured;
    final from = week[week.length - 2] as DateTime;
    final to = week.last as DateTime;
    expect(to.difference(from).inDays, 8);

    final before = cubit.state.date;
    cubit.step(forward: true);
    expect(
      cubit.state.date,
      DateTime(before.year, before.month, before.day + 7),
    );
    final afterWeek = cubit.state.date;
    cubit.setView(VenueCalendarView.month);
    cubit.step(forward: false);
    expect(
      cubit.state.date.month,
      DateTime(afterWeek.year, afterWeek.month - 1).month,
    );
    cubit.goToday();
    expect(cubit.state.date, CairoTime.today());
    cubit.openDay(DateTime(2026, 12, 1));
    expect(cubit.state.view, VenueCalendarView.day);
  });

  test('picking hours and taken slots', () {
    cubit.togglePicking();
    expect(cubit.state.picking, isTrue);
    final column = CalendarColumn(
      key: 'p1',
      label: 'P',
      date: DateTime(2026, 12, 1),
      pitchId: 'p1',
    );
    final hour = CalendarLayout.hourOf(column, 20);
    cubit.toggleHour(hour);
    expect(cubit.state.pickedHours.keys, [hour.key]);
    cubit.toggleHour(hour);
    expect(cubit.state.pickedHours, isEmpty);

    final hours = [
      CalendarLayout.hourOf(column, 20),
      CalendarLayout.hourOf(column, 21),
    ];
    cubit.toggleAll(hours);
    expect(cubit.state.pickedHours.length, 2);
    cubit.toggleAll(hours);
    expect(cubit.state.pickedHours, isEmpty);

    expect(
      cubit.toggleTaken(slot('app')),
      isFalse,
      reason: 'app bookings are freed from bookings',
    );
    expect(cubit.toggleTaken(slot('m1', manual: true)), isTrue);
    expect(cubit.toggleTaken(slot('b1', status: 'Blocked')), isTrue);
    expect(cubit.state.pickedTaken, {'m1': false, 'b1': true});

    cubit.clearPicks(stopPicking: true);
    expect(cubit.state.picking, isFalse);
    expect(cubit.state.pickedTaken, isEmpty);
  });

  test(
    'bulk book, release, block, unblock, confirm and cancel reload on success',
    () async {
      when(
        () => repo.bulkBook(
          any(),
          hours: any(named: 'hours'),
          status: any(named: 'status'),
          customerName: any(named: 'customerName'),
          customerPhone: any(named: 'customerPhone'),
          pricePerHour: any(named: 'pricePerHour'),
        ),
      ).thenAnswer(
        (_) async =>
            const ApiResult.success(BulkOutcome(succeeded: 1, failed: 0)),
      );
      when(
        () => repo.release(
          any(),
          bookingIds: any(named: 'bookingIds'),
          blockedSlotIds: any(named: 'blockedSlotIds'),
        ),
      ).thenAnswer(
        (_) async =>
            const ApiResult.success(BulkOutcome(succeeded: 2, failed: 0)),
      );
      when(
        () => repo.blockSlot(
          any(),
          pitchId: any(named: 'pitchId'),
          startUtc: any(named: 'startUtc'),
          endUtc: any(named: 'endUtc'),
          reason: any(named: 'reason'),
        ),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.unblockSlot(any(), any()),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.confirmManual(any(), any()),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.cancelBooking(any(), any(), any()),
      ).thenAnswer((_) async => const ApiResult.success(null));

      cubit.togglePicking();
      final column = CalendarColumn(
        key: 'p1',
        label: 'P',
        date: DateTime(2026, 12, 1),
        pitchId: 'p1',
      );
      cubit.toggleHour(CalendarLayout.hourOf(column, 20));
      expect(
        await cubit.bookPicked(status: ManualPaymentStatus.full),
        isA<Success<BulkOutcome>>(),
      );
      expect(
        cubit.state.pickedHours,
        isEmpty,
        reason: 'picks clear after a success',
      );

      cubit.toggleTaken(slot('m1', manual: true));
      cubit.toggleTaken(slot('b1', status: 'Blocked'));
      await cubit.releasePicked();
      verify(
        () => repo.release('v1', bookingIds: ['m1'], blockedSlotIds: ['b1']),
      ).called(1);

      final start = DateTime.utc(2026, 12, 1, 18);
      await cubit.blockSlot(
        pitchId: 'p1',
        startUtc: start,
        hours: 3,
        reason: 'fix',
      );
      verify(
        () => repo.blockSlot(
          'v1',
          pitchId: 'p1',
          startUtc: start,
          endUtc: start.add(const Duration(hours: 3)),
          reason: 'fix',
        ),
      ).called(1);
      await cubit.unblock('b1');
      await cubit.confirmManual('m1');
      await cubit.cancelManual('m1', 'sorry');
      verify(() => repo.cancelBooking('v1', 'm1', 'sorry')).called(1);
      expect(cubit.state.busy, isFalse);
    },
  );

  test('a failed change keeps the picks and reports the error', () async {
    when(() => repo.unblockSlot(any(), any())).thenAnswer(
      (_) async =>
          const ApiResult.failure(AppApiFailure(message: 'errors.forbidden')),
    );
    cubit.togglePicking();
    cubit.toggleTaken(slot('b1', status: 'Blocked'));
    final result = await cubit.unblock('b1');
    expect(result, isA<ApiFailure<void>>());
    expect(cubit.state.pickedTaken, isNotEmpty);
  });

  test('visible hours follow the day schedule and never clip a booking', () {
    final (first, last) = CalendarLayout.visibleHours(
      const [],
      DateTime(2026, 12, 1),
      VenueCalendarView.day,
      const [],
    );
    expect((first, last), (8, 26));
  });
}
