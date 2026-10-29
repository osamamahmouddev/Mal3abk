import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/auth/domain/use_cases/verify_otp_use_case.dart';
import 'package:mal3abk/features/auth/presentation/cubit/verify_otp_cubit.dart';
import 'package:mal3abk/features/auth/presentation/cubit/verify_otp_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/auth_fixtures.dart';

class MockVerifyOtpUseCase extends Mock implements VerifyOtpUseCase {}

void main() {
  late MockVerifyOtpUseCase useCase;
  late VerifyOtpCubit cubit;

  setUp(() {
    useCase = MockVerifyOtpUseCase();
    cubit = VerifyOtpCubit(verifyOtpUseCase: useCase);
  });

  tearDown(() => cubit.close());

  group('VerifyOtpCubit', () {
    test('initial state is VerifyOtpState.initial()', () {
      expect(cubit.state, const VerifyOtpState.initial());
    });

    test('emits [loading, success] when the code is accepted', () async {
      when(
        () => useCase(
          phoneNumber: any(named: 'phoneNumber'),
          code: any(named: 'code'),
        ),
      ).thenAnswer((_) async => const ApiResult.success(verifyOtpResponse));

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const VerifyOtpState.loading(),
          const VerifyOtpState.success(verifyOtpResponse),
        ]),
      );
      await cubit.verifyOtp(phoneNumber: testPhoneNumber, code: testCode);
      await expectation;
    });

    test('emits [loading, error] when the code is rejected', () async {
      when(
        () => useCase(
          phoneNumber: any(named: 'phoneNumber'),
          code: any(named: 'code'),
        ),
      ).thenAnswer((_) async => const ApiResult.failure(serverFailure));

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const VerifyOtpState.loading(),
          VerifyOtpState.error(serverFailure.message),
        ]),
      );
      await cubit.verifyOtp(phoneNumber: testPhoneNumber, code: testCode);
      await expectation;
    });
  });
}
