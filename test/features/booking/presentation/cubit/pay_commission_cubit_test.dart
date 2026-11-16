import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/booking/data/models/paymob_checkout_response_model.dart';
import 'package:mal3abk/features/booking/domain/use_cases/pay_booking_commission_use_case.dart';
import 'package:mal3abk/features/booking/presentation/cubit/pay_commission_cubit.dart';
import 'package:mal3abk/features/booking/presentation/cubit/pay_commission_state.dart';
import 'package:mocktail/mocktail.dart';

class MockPayBookingCommissionUseCase extends Mock
    implements PayBookingCommissionUseCase {}

const checkout = PaymobCheckoutResponseModel(
  clientSecret: 'secret',
  checkoutUrl: 'https://accept.paymob.com/unifiedcheckout/',
  amount: 50,
  currency: 'EGP',
  requiresRedirect: true,
);

void main() {
  late MockPayBookingCommissionUseCase useCase;

  setUp(() => useCase = MockPayBookingCommissionUseCase());

  group('PayCommissionCubit', () {
    test('starts in initial', () {
      final cubit = PayCommissionCubit(payBookingCommissionUseCase: useCase);
      expect(cubit.state, const PayCommissionState.initial());
      cubit.close();
    });

    test('emits loading then success with the checkout link', () async {
      when(
        () => useCase('b-1'),
      ).thenAnswer((_) async => const ApiResult.success(checkout));
      final cubit = PayCommissionCubit(payBookingCommissionUseCase: useCase);
      final states = <PayCommissionState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.pay('b-1');
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(states, [
        const PayCommissionState.loading(),
        PayCommissionState.success(checkout.checkoutUrl),
      ]);
      await cubit.close();
    });

    test('emits loading then the failure key', () async {
      when(() => useCase('b-1')).thenAnswer(
        (_) async =>
            const ApiResult.failure(AppApiFailure(message: 'errors.network')),
      );
      final cubit = PayCommissionCubit(payBookingCommissionUseCase: useCase);
      final states = <PayCommissionState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.pay('b-1');
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(states, [
        const PayCommissionState.loading(),
        const PayCommissionState.error('errors.network'),
      ]);
      await cubit.close();
    });

    test('ignores a second tap while the first is running', () async {
      final completer = Completer<ApiResult<PaymobCheckoutResponseModel>>();
      when(() => useCase('b-1')).thenAnswer((_) => completer.future);
      final cubit = PayCommissionCubit(payBookingCommissionUseCase: useCase);

      final first = cubit.pay('b-1');
      await cubit.pay('b-1');
      completer.complete(const ApiResult.success(checkout));
      await first;

      verify(() => useCase('b-1')).called(1);
      await cubit.close();
    });

    test('launchFailed shows the launch error', () async {
      final cubit = PayCommissionCubit(payBookingCommissionUseCase: useCase);
      cubit.launchFailed(PayBookingCommissionUseCase.invalidCheckoutKey);
      expect(
        cubit.state,
        const PayCommissionState.error(
          PayBookingCommissionUseCase.invalidCheckoutKey,
        ),
      );
      await cubit.close();
    });

    test('does not emit after close', () async {
      final completer = Completer<ApiResult<PaymobCheckoutResponseModel>>();
      when(() => useCase('b-1')).thenAnswer((_) => completer.future);
      final cubit = PayCommissionCubit(payBookingCommissionUseCase: useCase);

      final pending = cubit.pay('b-1');
      await cubit.close();
      completer.complete(const ApiResult.success(checkout));

      await expectLater(pending, completes);
    });
  });
}
