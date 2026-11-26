import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/core/utils/cairo_time.dart';
import 'package:mal3abk/features/venue_bookings/data/models/venue_booking_detail_model.dart';
import 'package:mal3abk/features/venue_bookings/data/models/venue_booking_item_model.dart';
import 'package:mal3abk/features/venue_bookings/data/models/venue_bookings_query.dart';
import 'package:mal3abk/features/venue_bookings/domain/repos/venue_bookings_repo.dart';
import 'package:mal3abk/features/venue_bookings/presentation/cubit/venue_booking_detail_cubit.dart';
import 'package:mal3abk/features/venue_bookings/presentation/cubit/venue_booking_detail_state.dart';
import 'package:mal3abk/features/venue_bookings/presentation/cubit/venue_bookings_cubit.dart';
import 'package:mal3abk/features/venue_bookings/presentation/cubit/venue_bookings_state.dart';
import 'package:mocktail/mocktail.dart';

class MockVenueBookingsRepo extends Mock implements VenueBookingsRepo {}

VenueBookingItemModel item(String id) => VenueBookingItemModel(
  id: id,
  reference: 'MB-$id',
  pitchId: 'p1',
  startUtc: '2026-11-26T18:00:00Z',
  endUtc: '2026-11-26T19:00:00Z',
  status: 2,
);

const detail = VenueBookingDetailModel(
  id: 'b1',
  reference: 'MB-1',
  pitchId: 'p1',
  startUtc: '2026-11-26T18:00:00Z',
  endUtc: '2026-11-26T19:00:00Z',
  status: 2,
  isManual: true,
);

void main() {
  setUpAll(() {
    CairoTime.initialize();
    registerFallbackValue(const VenueBookingsQuery());
  });

  group('VenueBookingsQuery', () {
    test('tabs map to the web statuses', () {
      expect(VenueBookingsQuery.statusesOf(VenueBookingsTab.pending), [
        2,
        3,
        4,
      ]);
      expect(VenueBookingsQuery.statusesOf(VenueBookingsTab.confirmed), [5, 9]);
      expect(VenueBookingsQuery.statusesOf(VenueBookingsTab.closed), [
        6,
        7,
        8,
        10,
      ]);
      expect(VenueBookingsQuery.statusesOf(VenueBookingsTab.all), isEmpty);
    });

    test('a day range covers whole Cairo days', () {
      const query = VenueBookingsQuery(range: VenueBookingsRange.today);
      final (start, end) = query.utcWindow!;
      final s = DateTime.parse(start);
      final e = DateTime.parse(end);
      expect(
        e.difference(s),
        const Duration(hours: 23, minutes: 59, seconds: 59),
      );
      expect(CairoTime.fromUtc(s).hour, 0);
      expect(const VenueBookingsQuery().utcWindow, isNull);
    });
  });

  group('VenueBookingsCubit', () {
    late MockVenueBookingsRepo repo;

    setUp(() {
      repo = MockVenueBookingsRepo();
      when(
        () => repo.getBookings(
          any(),
          any(),
          tab: any(named: 'tab'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenAnswer((inv) async {
        final page = inv.namedArguments[#page] as int? ?? 1;
        final size = inv.namedArguments[#pageSize] as int? ?? 20;
        if (size == 1) {
          return const ApiResult.success(VenueBookingPageModel(totalCount: 3));
        }
        return ApiResult.success(
          VenueBookingPageModel(
            items: page == 1 ? [item('1'), item('2')] : [item('3')],
            totalCount: 3,
            page: page,
          ),
        );
      });
    });

    test('loads the first page, tab counts, then more', () async {
      final cubit = VenueBookingsCubit(
        venueBookingsRepo: repo,
        searchDebounce: Duration.zero,
      );
      await cubit.start('v1');
      var state = cubit.state as VenueBookingsSuccess;
      expect(state.items.length, 2);
      expect(state.counts[VenueBookingsTab.pending], 3);

      await cubit.loadMore();
      state = cubit.state as VenueBookingsSuccess;
      expect(state.items.map((b) => b.id), ['1', '2', '3']);
      await cubit.close();
    });
  });

  group('VenueBookingDetailCubit', () {
    late MockVenueBookingsRepo repo;

    setUp(() {
      repo = MockVenueBookingsRepo();
      when(
        () => repo.getBooking('v1', 'b1'),
      ).thenAnswer((_) async => const ApiResult.success(detail));
    });

    test('confirming a manual booking marks it changed', () async {
      when(
        () => repo.confirmManual('v1', 'b1'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      final cubit = VenueBookingDetailCubit(venueBookingsRepo: repo);
      await cubit.load('v1', 'b1');
      await cubit.confirmManual();
      final state = cubit.state as VenueBookingDetailSuccess;
      expect(state.done, VenueBookingAction.confirm);
      expect(cubit.changed, isTrue);
      await cubit.close();
    });

    test('a failed cancel keeps the booking and shows why', () async {
      when(() => repo.cancel('v1', 'b1', 'rain')).thenAnswer(
        (_) async =>
            const ApiResult.failure(AppApiFailure(message: 'errors.conflict')),
      );
      final cubit = VenueBookingDetailCubit(venueBookingsRepo: repo);
      await cubit.load('v1', 'b1');
      await cubit.cancel('rain');
      final state = cubit.state as VenueBookingDetailSuccess;
      expect(state.actionError, 'errors.conflict');
      expect(state.busy, isNull);
      expect(cubit.changed, isFalse);
      await cubit.close();
    });
  });
}
