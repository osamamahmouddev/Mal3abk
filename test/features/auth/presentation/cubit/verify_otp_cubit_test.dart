import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
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
          restoreAccount: any(named: 'restoreAccount'),
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
          restoreAccount: any(named: 'restoreAccount'),
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

    test(
      'emits [loading, accountPendingDeletion] when account is pending deletion',
      () async {
        const pendingDeletionFailure = AppApiFailure(
          message: 'errors.identity.account_pending_deletion',
          code: 'Identity.AccountPendingDeletion',
          statusCode: 400,
        );
        when(
          () => useCase(
            phoneNumber: any(named: 'phoneNumber'),
            code: any(named: 'code'),
            restoreAccount: any(named: 'restoreAccount'),
          ),
        ).thenAnswer(
          (_) async => const ApiResult.failure(pendingDeletionFailure),
        );

        final expectation = expectLater(
          cubit.stream,
          emitsInOrder([
            const VerifyOtpState.loading(),
            const VerifyOtpState.accountPendingDeletion(),
          ]),
        );
        await cubit.verifyOtp(phoneNumber: testPhoneNumber, code: testCode);
        await expectation;
      },
    );

    test(
      'threads restoreAccount: true to useCase and emits [loading, success] on restore retry',
      () async {
        when(
          () => useCase(
            phoneNumber: testPhoneNumber,
            code: testCode,
            restoreAccount: true,
          ),
        ).thenAnswer((_) async => const ApiResult.success(verifyOtpResponse));

        final expectation = expectLater(
          cubit.stream,
          emitsInOrder([
            const VerifyOtpState.loading(),
            const VerifyOtpState.success(verifyOtpResponse),
          ]),
        );
        await cubit.verifyOtp(
          phoneNumber: testPhoneNumber,
          code: testCode,
          restoreAccount: true,
        );
        await expectation;

        verify(
          () => useCase(
            phoneNumber: testPhoneNumber,
            code: testCode,
            restoreAccount: true,
          ),
        ).called(1);
      },
    );

    test(
      'uses enableRestoreAccount() to thread restoreAccount: true on subsequent verify',
      () async {
        when(
          () => useCase(
            phoneNumber: testPhoneNumber,
            code: testCode,
            restoreAccount: true,
          ),
        ).thenAnswer((_) async => const ApiResult.success(verifyOtpResponse));

        cubit.enableRestoreAccount();
        expect(cubit.isRestoreAccount, isTrue);

        final expectation = expectLater(
          cubit.stream,
          emitsInOrder([
            const VerifyOtpState.loading(),
            const VerifyOtpState.success(verifyOtpResponse),
          ]),
        );
        await cubit.verifyOtp(phoneNumber: testPhoneNumber, code: testCode);
        await expectation;

        expect(cubit.isRestoreAccount, isFalse);
      },
    );

    test(
      'emits [loading, accountPendingDeletion] on second pending-deletion response during restore retry',
      () async {
        const pendingDeletionFailure = AppApiFailure(
          message: 'errors.identity.account_pending_deletion',
          code: 'Identity.AccountPendingDeletion',
          statusCode: 400,
        );
        when(
          () => useCase(
            phoneNumber: any(named: 'phoneNumber'),
            code: any(named: 'code'),
            restoreAccount: true,
          ),
        ).thenAnswer(
          (_) async => const ApiResult.failure(pendingDeletionFailure),
        );

        cubit.enableRestoreAccount();

        final expectation = expectLater(
          cubit.stream,
          emitsInOrder([
            const VerifyOtpState.loading(),
            const VerifyOtpState.accountPendingDeletion(),
          ]),
        );
        await cubit.verifyOtp(phoneNumber: testPhoneNumber, code: testCode);
        await expectation;
      },
    );

    test('reset() returns to initial state and clears restoreAccount', () {
      cubit.enableRestoreAccount();
      expect(cubit.isRestoreAccount, isTrue);
      cubit.reset();
      expect(cubit.isRestoreAccount, isFalse);
      expect(cubit.state, const VerifyOtpState.initial());
    });
  });
}
