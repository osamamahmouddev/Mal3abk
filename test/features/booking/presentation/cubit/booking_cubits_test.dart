import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/booking/data/models/cancel_preview_model.dart';
import 'package:mal3abk/features/booking/data/models/player_booking_summary_model.dart';
import 'package:mal3abk/features/booking/domain/repos/booking_repo.dart';
import 'package:mal3abk/features/booking/domain/use_cases/get_my_bookings_use_case.dart';
import 'package:mal3abk/features/booking/presentation/cubit/cancel_booking_cubit.dart';
import 'package:mal3abk/features/booking/presentation/cubit/cancel_booking_state.dart';
import 'package:mal3abk/features/booking/presentation/cubit/my_bookings_cubit.dart';
import 'package:mal3abk/features/booking/presentation/cubit/my_bookings_state.dart';
import 'package:mal3abk/features/booking/presentation/cubit/my_bookings_tab.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/booking_fixtures.dart';

class MockBookingRepo extends Mock implements BookingRepo {}

PlayerBookingsPagedListModel page(List<String> ids, {int page = 1}) =>
    PlayerBookingsPagedListModel(
      items: [
        for (final id in ids)
          PlayerBookingSummaryModel.fromJson({...summaryJson(5), 'id': id}),
      ],
      totalCount: 3,
      page: page,
      pageSize: 2,
    );

void main() {
  late MockBookingRepo repo;

  setUp(() => repo = MockBookingRepo());

  group('CancelBookingCubit', () {
    const preview = CancelPreviewModel(
      canCancel: true,
      refundPercentage: 100,
      estimatedRefundAmount: 100,
      currency: 'EGP',
    );

    test('retries a failed cancel with the same idempotency key', () async {
      when(
        () => repo.getCancelPreview('b-1'),
      ).thenAnswer((_) async => const ApiResult.success(preview));
      var calls = 0;
      when(
        () => repo.cancelBooking(
          'b-1',
          idempotencyKey: any(named: 'idempotencyKey'),
          reason: any(named: 'reason'),
        ),
      ).thenAnswer(
        (_) async => calls++ == 0
            ? const ApiResult.failure(AppApiFailure(message: 'errors.network'))
            : const ApiResult.success(null),
      );
      final cubit = CancelBookingCubit(bookingRepo: repo);
      await cubit.loadPreview('b-1');

      await cubit.cancel('b-1', reason: 'time');
      expect((cubit.state as CancelBookingReady).failure, 'errors.network');
      await cubit.cancel('b-1', reason: 'time');

      expect(cubit.state, const CancelBookingState.cancelled());
      final keys = verify(
        () => repo.cancelBooking(
          'b-1',
          idempotencyKey: captureAny(named: 'idempotencyKey'),
          reason: 'time',
        ),
      ).captured;
      expect(keys, hasLength(2));
      expect(keys.first, keys.last);
      await cubit.close();
    });

    test('does not call the API when the policy forbids cancelling', () async {
      when(() => repo.getCancelPreview('b-1')).thenAnswer(
        (_) async => const ApiResult.success(
          CancelPreviewModel(
            canCancel: false,
            refundPercentage: 0,
            estimatedRefundAmount: 0,
            currency: 'EGP',
          ),
        ),
      );
      final cubit = CancelBookingCubit(bookingRepo: repo);
      await cubit.loadPreview('b-1');

      await cubit.cancel('b-1');

      verifyNever(
        () => repo.cancelBooking(
          any(),
          idempotencyKey: any(named: 'idempotencyKey'),
          reason: any(named: 'reason'),
        ),
      );
      await cubit.close();
    });
  });

  group('MyBookingsCubit', () {
    test('loads a tab and appends the next page', () async {
      when(
        () => repo.getMyBookings(tab: 'upcoming', page: 1, pageSize: 10),
      ).thenAnswer((_) async => ApiResult.success(page(['a', 'b'])));
      when(
        () => repo.getMyBookings(tab: 'upcoming', page: 2, pageSize: 10),
      ).thenAnswer((_) async => ApiResult.success(page(['c'], page: 2)));
      final cubit = MyBookingsCubit(
        getMyBookingsUseCase: GetMyBookingsUseCase(bookingRepo: repo),
      );

      await cubit.load(MyBookingsTab.upcoming);
      expect((cubit.state as MyBookingsSuccess).hasMore, isTrue);
      await cubit.loadMore();

      final state = cubit.state as MyBookingsSuccess;
      expect(state.items.map((b) => b.id), ['a', 'b', 'c']);
      expect(state.hasMore, isFalse);
      await cubit.close();
    });
  });
}
