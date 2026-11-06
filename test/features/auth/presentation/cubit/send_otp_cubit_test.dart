import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/auth/domain/use_cases/send_otp_use_case.dart';
import 'package:mal3abk/features/auth/presentation/cubit/send_otp_cubit.dart';
import 'package:mal3abk/features/auth/presentation/cubit/send_otp_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/auth_fixtures.dart';

class MockSendOtpUseCase extends Mock implements SendOtpUseCase {}

void main() {
  late MockSendOtpUseCase useCase;
  late SendOtpCubit cubit;

  setUp(() {
    useCase = MockSendOtpUseCase();
    cubit = SendOtpCubit(sendOtpUseCase: useCase);
  });

  tearDown(() => cubit.close());

  group('SendOtpCubit', () {
    test('initial state is SendOtpState.initial()', () {
      expect(cubit.state, const SendOtpState.initial());
    });

    test('emits [loading, success] when the code is sent', () async {
      when(
        () => useCase(any()),
      ).thenAnswer((_) async => const ApiResult.success(sendOtpResponse));

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const SendOtpState.loading(),
          const SendOtpState.success(sendOtpResponse),
        ]),
      );
      await cubit.sendOtp('01012345678');
      await expectation;
    });

    test('emits [loading, error] with the failure key', () async {
      when(
        () => useCase(any()),
      ).thenAnswer((_) async => const ApiResult.failure(serverFailure));

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const SendOtpState.loading(),
          SendOtpState.error(serverFailure.message),
        ]),
      );
      await cubit.sendOtp('01012345678');
      await expectation;
    });

    test('reset returns to the phone step', () async {
      when(
        () => useCase(any()),
      ).thenAnswer((_) async => const ApiResult.success(sendOtpResponse));
      await cubit.sendOtp('01012345678');

      cubit.reset();

      expect(cubit.state, const SendOtpState.initial());
    });

    test('resends on the code step and restarts the countdown', () async {
      when(
        () => useCase(any()),
      ).thenAnswer((_) async => const ApiResult.success(sendOtpResponse));
      await cubit.sendOtp('01012345678');

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const SendOtpState.success(sendOtpResponse, resending: true),
          const SendOtpState.success(sendOtpResponse, sendCount: 2),
        ]),
      );
      await cubit.resend();
      await expectation;
      verify(() => useCase(testPhoneNumber)).called(1);
    });
  });
}
