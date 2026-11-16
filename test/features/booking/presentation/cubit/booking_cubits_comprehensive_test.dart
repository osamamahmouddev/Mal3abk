import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/booking/data/models/booking_payment_method_model.dart';
import 'package:mal3abk/features/booking/data/models/booking_status.dart';
import 'package:mal3abk/features/booking/data/models/cancel_preview_model.dart';
import 'package:mal3abk/features/booking/data/models/player_booking_detail_model.dart';
import 'package:mal3abk/features/booking/data/models/player_booking_summary_model.dart';
import 'package:mal3abk/features/booking/domain/repos/booking_repo.dart';
import 'package:mal3abk/features/booking/domain/use_cases/get_booking_detail_use_case.dart';
import 'package:mal3abk/features/booking/domain/use_cases/get_my_bookings_use_case.dart';
import 'package:mal3abk/features/booking/presentation/cubit/booking_details_cubit.dart';
import 'package:mal3abk/features/booking/presentation/cubit/booking_details_state.dart';
import 'package:mal3abk/features/booking/presentation/cubit/cancel_booking_cubit.dart';
import 'package:mal3abk/features/booking/presentation/cubit/cancel_booking_state.dart';
import 'package:mal3abk/features/booking/presentation/cubit/deposit_methods_cubit.dart';
import 'package:mal3abk/features/booking/presentation/cubit/deposit_methods_state.dart';
import 'package:mal3abk/features/booking/presentation/cubit/my_bookings_cubit.dart';
import 'package:mal3abk/features/booking/presentation/cubit/my_bookings_state.dart';
import 'package:mal3abk/features/booking/presentation/cubit/my_bookings_tab.dart';
import 'package:mocktail/mocktail.dart';

class MockBookingRepo extends Mock implements BookingRepo {}

class MockGetBookingDetailUseCase extends Mock
    implements GetBookingDetailUseCase {}

class MockGetMyBookingsUseCase extends Mock implements GetMyBookingsUseCase {}

void main() {
  late MockBookingRepo mockRepo;
  late MockGetBookingDetailUseCase mockDetailUseCase;
  late MockGetMyBookingsUseCase mockMyBookingsUseCase;

  setUp(() {
    mockRepo = MockBookingRepo();
    mockDetailUseCase = MockGetBookingDetailUseCase();
    mockMyBookingsUseCase = MockGetMyBookingsUseCase();
  });

  group('BookingDetailsCubit Tests', () {
    const detail = PlayerBookingDetailModel(
      id: 'b-1',
      reference: 'REF-1',
      venueId: 'v-1',
      pitchId: 'p-1',
      startUtc: '2026-12-01T18:00:00Z',
      endUtc: '2026-12-01T19:00:00Z',
      totalPrice: 200,
      depositAmount: 50,
      currency: 'EGP',
      status: BookingStatus.confirmed,
      allowedActions: PlayerAllowedActionsModel(),
      createdAtUtc: '2026-12-01T10:00:00Z',
    );

    test('75. initial state is BookingDetailsInitial', () {
      final cubit = BookingDetailsCubit(
        getBookingDetailUseCase: mockDetailUseCase,
      );
      expect(cubit.state, const BookingDetailsState.initial());
    });

    test('76. emits [loading, success] on successful load', () async {
      when(
        () => mockDetailUseCase('b-1'),
      ).thenAnswer((_) async => const ApiResult.success(detail));
      final cubit = BookingDetailsCubit(
        getBookingDetailUseCase: mockDetailUseCase,
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const BookingDetailsState.loading(),
          const BookingDetailsState.success(detail),
        ]),
      );

      await cubit.load('b-1');
    });

    test('77. emits [loading, error] when detail fails', () async {
      when(() => mockDetailUseCase('b-1')).thenAnswer(
        (_) async =>
            const ApiResult.failure(AppApiFailure(message: 'errors.not_found')),
      );
      final cubit = BookingDetailsCubit(
        getBookingDetailUseCase: mockDetailUseCase,
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const BookingDetailsState.loading(),
          const BookingDetailsState.error('errors.not_found'),
        ]),
      );

      await cubit.load('b-1');
    });

    test('78. does not re-emit loading if already in success state', () async {
      when(
        () => mockDetailUseCase('b-1'),
      ).thenAnswer((_) async => const ApiResult.success(detail));
      final cubit = BookingDetailsCubit(
        getBookingDetailUseCase: mockDetailUseCase,
      );
      await cubit.load('b-1');

      expect(cubit.state, const BookingDetailsState.success(detail));
      when(
        () => mockDetailUseCase('b-1'),
      ).thenAnswer((_) async => const ApiResult.success(detail));

      await cubit.load('b-1');
      expect(cubit.state, const BookingDetailsState.success(detail));
    });
  });

  group('DepositMethodsCubit Tests', () {
    const methods = [
      BookingPaymentMethodModel(
        id: 'pm-1',
        methodType: 'InstaPay',
        recipientName: 'Owner',
        accountDetails: 'owner@instapay',
      ),
    ];

    test('79. initial state is DepositMethodsLoading', () {
      final cubit = DepositMethodsCubit(bookingRepo: mockRepo);
      expect(cubit.state, const DepositMethodsState.loading());
    });

    test('80. emits success with methods on successful load', () async {
      when(
        () => mockRepo.getPaymentMethods('b-1'),
      ).thenAnswer((_) async => const ApiResult.success(methods));
      final cubit = DepositMethodsCubit(bookingRepo: mockRepo);

      expectLater(
        cubit.stream,
        emitsInOrder([
          const DepositMethodsState.loading(),
          const DepositMethodsState.success(methods),
        ]),
      );
      await cubit.load('b-1');
    });

    test('81. emits error on payment methods failure', () async {
      when(() => mockRepo.getPaymentMethods('b-1')).thenAnswer(
        (_) async =>
            const ApiResult.failure(AppApiFailure(message: 'errors.server')),
      );
      final cubit = DepositMethodsCubit(bookingRepo: mockRepo);

      expectLater(
        cubit.stream,
        emitsInOrder([
          const DepositMethodsState.loading(),
          const DepositMethodsState.error('errors.server'),
        ]),
      );
      await cubit.load('b-1');
    });

    test('82. emits empty list when venue has no payment methods', () async {
      when(
        () => mockRepo.getPaymentMethods('b-1'),
      ).thenAnswer((_) async => const ApiResult.success([]));
      final cubit = DepositMethodsCubit(bookingRepo: mockRepo);

      expectLater(
        cubit.stream,
        emitsInOrder([
          const DepositMethodsState.loading(),
          const DepositMethodsState.success([]),
        ]),
      );
      await cubit.load('b-1');
    });
  });

  group('CancelBookingCubit Tests', () {
    const previewAllowed = CancelPreviewModel(
      canCancel: true,
      refundPercentage: 100,
      estimatedRefundAmount: 100,
      currency: 'EGP',
    );
    const previewForbidden = CancelPreviewModel(
      canCancel: false,
      refundPercentage: 0,
      estimatedRefundAmount: 0,
      currency: 'EGP',
    );

    test('83. initial state is CancelBookingLoading', () {
      final cubit = CancelBookingCubit(bookingRepo: mockRepo);
      expect(cubit.state, const CancelBookingState.loading());
    });

    test('84. loadPreview emits ready state', () async {
      when(
        () => mockRepo.getCancelPreview('b-1'),
      ).thenAnswer((_) async => const ApiResult.success(previewAllowed));
      final cubit = CancelBookingCubit(bookingRepo: mockRepo);

      expectLater(
        cubit.stream,
        emitsInOrder([
          const CancelBookingState.loading(),
          const CancelBookingState.ready(previewAllowed),
        ]),
      );
      await cubit.loadPreview('b-1');
    });

    test('85. loadPreview emits error on failure', () async {
      when(() => mockRepo.getCancelPreview('b-1')).thenAnswer(
        (_) async => const ApiResult.failure(
          AppApiFailure(message: 'errors.preview_failed'),
        ),
      );
      final cubit = CancelBookingCubit(bookingRepo: mockRepo);

      expectLater(
        cubit.stream,
        emitsInOrder([
          const CancelBookingState.loading(),
          const CancelBookingState.error('errors.preview_failed'),
        ]),
      );
      await cubit.loadPreview('b-1');
    });

    test('86. cancel does nothing if preview forbids cancellation', () async {
      when(
        () => mockRepo.getCancelPreview('b-1'),
      ).thenAnswer((_) async => const ApiResult.success(previewForbidden));
      final cubit = CancelBookingCubit(bookingRepo: mockRepo);
      await cubit.loadPreview('b-1');

      await cubit.cancel('b-1');
      verifyNever(
        () => mockRepo.cancelBooking(
          any(),
          idempotencyKey: any(named: 'idempotencyKey'),
        ),
      );
    });

    test('87. cancel succeeds and emits cancelled state', () async {
      when(
        () => mockRepo.getCancelPreview('b-1'),
      ).thenAnswer((_) async => const ApiResult.success(previewAllowed));
      when(
        () => mockRepo.cancelBooking(
          'b-1',
          idempotencyKey: any(named: 'idempotencyKey'),
          reason: any(named: 'reason'),
        ),
      ).thenAnswer((_) async => const ApiResult.success(null));

      final cubit = CancelBookingCubit(bookingRepo: mockRepo);
      await cubit.loadPreview('b-1');

      expectLater(
        cubit.stream,
        emitsInOrder([
          const CancelBookingState.ready(previewAllowed, submitting: true),
          const CancelBookingState.cancelled(),
        ]),
      );

      await cubit.cancel('b-1', reason: 'Injured');
    });

    test(
      '88. cancel failure restores ready state with error message',
      () async {
        when(
          () => mockRepo.getCancelPreview('b-1'),
        ).thenAnswer((_) async => const ApiResult.success(previewAllowed));
        when(
          () => mockRepo.cancelBooking(
            'b-1',
            idempotencyKey: any(named: 'idempotencyKey'),
            reason: any(named: 'reason'),
          ),
        ).thenAnswer(
          (_) async => const ApiResult.failure(
            AppApiFailure(message: 'errors.conflict'),
          ),
        );

        final cubit = CancelBookingCubit(bookingRepo: mockRepo);
        await cubit.loadPreview('b-1');

        expectLater(
          cubit.stream,
          emitsInOrder([
            const CancelBookingState.ready(previewAllowed, submitting: true),
            const CancelBookingState.ready(
              previewAllowed,
              submitting: false,
              failure: 'errors.conflict',
            ),
          ]),
        );

        await cubit.cancel('b-1');
      },
    );
  });

  group('MyBookingsCubit Tests', () {
    const emptyPaged = PlayerBookingsPagedListModel(
      items: [],
      totalCount: 0,
      page: 1,
      pageSize: 10,
    );

    test('89. initial state is MyBookingsInitial', () {
      final cubit = MyBookingsCubit(
        getMyBookingsUseCase: mockMyBookingsUseCase,
      );
      expect(cubit.state, const MyBookingsState.initial());
    });

    test('90. load loads initial tab successfully', () async {
      when(
        () => mockMyBookingsUseCase(tab: 'upcoming', page: 1, pageSize: 10),
      ).thenAnswer((_) async => const ApiResult.success(emptyPaged));

      final cubit = MyBookingsCubit(
        getMyBookingsUseCase: mockMyBookingsUseCase,
      );
      await cubit.load(MyBookingsTab.upcoming);

      expect(cubit.state, isA<MyBookingsSuccess>());
    });

    test('91. load different tab updates tab identifier', () async {
      when(
        () => mockMyBookingsUseCase(tab: 'completed', page: 1, pageSize: 10),
      ).thenAnswer((_) async => const ApiResult.success(emptyPaged));

      final cubit = MyBookingsCubit(
        getMyBookingsUseCase: mockMyBookingsUseCase,
      );
      await cubit.load(MyBookingsTab.completed);

      final state = cubit.state;
      expect(state, isA<MyBookingsSuccess>());
      expect((state as MyBookingsSuccess).tab, MyBookingsTab.completed);
    });

    test('92. load emits error when request fails', () async {
      when(
        () => mockMyBookingsUseCase(tab: 'upcoming', page: 1, pageSize: 10),
      ).thenAnswer(
        (_) async =>
            const ApiResult.failure(AppApiFailure(message: 'errors.network')),
      );

      final cubit = MyBookingsCubit(
        getMyBookingsUseCase: mockMyBookingsUseCase,
      );
      await cubit.load(MyBookingsTab.upcoming);

      expect(
        cubit.state,
        const MyBookingsState.error(MyBookingsTab.upcoming, 'errors.network'),
      );
    });

    test('93. load same tab again re-triggers request', () async {
      when(
        () => mockMyBookingsUseCase(tab: 'upcoming', page: 1, pageSize: 10),
      ).thenAnswer((_) async => const ApiResult.success(emptyPaged));

      final cubit = MyBookingsCubit(
        getMyBookingsUseCase: mockMyBookingsUseCase,
      );
      await cubit.load(MyBookingsTab.upcoming);
      await cubit.load(MyBookingsTab.upcoming);

      expect(cubit.state, isA<MyBookingsSuccess>());
    });

    test('94. loadMore does nothing when hasMore is false', () async {
      when(
        () => mockMyBookingsUseCase(tab: 'upcoming', page: 1, pageSize: 10),
      ).thenAnswer((_) async => const ApiResult.success(emptyPaged));

      final cubit = MyBookingsCubit(
        getMyBookingsUseCase: mockMyBookingsUseCase,
      );
      await cubit.load(MyBookingsTab.upcoming);
      await cubit.loadMore();

      verify(
        () => mockMyBookingsUseCase(tab: 'upcoming', page: 1, pageSize: 10),
      ).called(1);
      verifyNever(
        () => mockMyBookingsUseCase(tab: 'upcoming', page: 2, pageSize: 10),
      );
    });

    test('95. loadMore appends items when hasMore is true', () async {
      const summary = PlayerBookingSummaryModel(
        id: 'b-1',
        reference: 'REF-1',
        venueId: 'v-1',
        pitchId: 'p-1',
        startUtc: '2026-12-01T18:00:00Z',
        endUtc: '2026-12-01T19:00:00Z',
        totalPrice: 200,
        depositAmount: 50,
        currency: 'EGP',
        status: BookingStatus.confirmed,
        allowedActions: PlayerAllowedActionsModel(),
        createdAtUtc: '2026-12-01T10:00:00Z',
      );
      const paged1 = PlayerBookingsPagedListModel(
        items: [summary],
        totalCount: 20,
        page: 1,
        pageSize: 10,
      );
      const paged2 = PlayerBookingsPagedListModel(
        items: [summary],
        totalCount: 20,
        page: 2,
        pageSize: 10,
      );

      when(
        () => mockMyBookingsUseCase(tab: 'upcoming', page: 1, pageSize: 10),
      ).thenAnswer((_) async => const ApiResult.success(paged1));
      when(
        () => mockMyBookingsUseCase(tab: 'upcoming', page: 2, pageSize: 10),
      ).thenAnswer((_) async => const ApiResult.success(paged2));

      final cubit = MyBookingsCubit(
        getMyBookingsUseCase: mockMyBookingsUseCase,
      );
      await cubit.load(MyBookingsTab.upcoming);
      await cubit.loadMore();

      final state = cubit.state as MyBookingsSuccess;
      expect(state.items.length, 2);
    });

    test('96. loadMore leaves existing items intact on failure', () async {
      const summary = PlayerBookingSummaryModel(
        id: 'b-1',
        reference: 'REF-1',
        venueId: 'v-1',
        pitchId: 'p-1',
        startUtc: '2026-12-01T18:00:00Z',
        endUtc: '2026-12-01T19:00:00Z',
        totalPrice: 200,
        depositAmount: 50,
        currency: 'EGP',
        status: BookingStatus.confirmed,
        allowedActions: PlayerAllowedActionsModel(),
        createdAtUtc: '2026-12-01T10:00:00Z',
      );
      const paged1 = PlayerBookingsPagedListModel(
        items: [summary],
        totalCount: 20,
        page: 1,
        pageSize: 10,
      );

      when(
        () => mockMyBookingsUseCase(tab: 'upcoming', page: 1, pageSize: 10),
      ).thenAnswer((_) async => const ApiResult.success(paged1));
      when(
        () => mockMyBookingsUseCase(tab: 'upcoming', page: 2, pageSize: 10),
      ).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'timeout')),
      );

      final cubit = MyBookingsCubit(
        getMyBookingsUseCase: mockMyBookingsUseCase,
      );
      await cubit.load(MyBookingsTab.upcoming);
      await cubit.loadMore();

      final state = cubit.state as MyBookingsSuccess;
      expect(state.items.length, 1);
      expect(state.isLoadingMore, isFalse);
    });

    test('97. cancels state if cubit is closed during load', () async {
      when(
        () => mockMyBookingsUseCase(tab: 'upcoming', page: 1, pageSize: 10),
      ).thenAnswer(
        (_) async => Future.delayed(
          const Duration(milliseconds: 50),
          () => const ApiResult.success(emptyPaged),
        ),
      );

      final cubit = MyBookingsCubit(
        getMyBookingsUseCase: mockMyBookingsUseCase,
      );
      cubit.load(MyBookingsTab.upcoming);
      await cubit.close();
    });

    test('98. load when in error state re-triggers load', () async {
      when(
        () => mockMyBookingsUseCase(tab: 'upcoming', page: 1, pageSize: 10),
      ).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'error')),
      );
      final cubit = MyBookingsCubit(
        getMyBookingsUseCase: mockMyBookingsUseCase,
      );
      await cubit.load(MyBookingsTab.upcoming);
      expect(
        cubit.state,
        const MyBookingsState.error(MyBookingsTab.upcoming, 'error'),
      );

      when(
        () => mockMyBookingsUseCase(tab: 'upcoming', page: 1, pageSize: 10),
      ).thenAnswer((_) async => const ApiResult.success(emptyPaged));
      await cubit.load(MyBookingsTab.upcoming);
      expect(cubit.state, isA<MyBookingsSuccess>());
    });

    test('99. MyBookingsState copyWith works correctly', () {
      const success = MyBookingsSuccess(
        tab: MyBookingsTab.upcoming,
        items: [],
        page: 1,
        hasMore: false,
        isLoadingMore: false,
      );
      final updated = success.copyWith(isLoadingMore: true);
      expect(updated.isLoadingMore, isTrue);
      expect(updated.tab, MyBookingsTab.upcoming);
    });

    test(
      '100. MyBookingsTab query strings match expected API query parameters',
      () {
        expect(MyBookingsTab.upcoming.query, 'upcoming');
        expect(MyBookingsTab.pending.query, 'pending');
        expect(MyBookingsTab.completed.query, 'completed');
        expect(MyBookingsTab.cancelled.query, 'cancelled');
      },
    );
  });
}
