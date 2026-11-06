import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/auth/domain/repos/auth_repo.dart';
import 'package:mal3abk/features/settings/domain/repos/account_repo.dart';
import 'package:mal3abk/features/settings/domain/use_cases/delete_account_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';

class MockAccountRepo extends Mock implements AccountRepo {}

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late MockAccountRepo accountRepo;
  late MockAuthRepo authRepo;
  late DeleteAccountUseCase useCase;

  setUp(() {
    accountRepo = MockAccountRepo();
    authRepo = MockAuthRepo();
    useCase = DeleteAccountUseCase(
      accountRepo: accountRepo,
      authRepo: authRepo,
    );
  });

  test('drops the local session once the account is deleted', () async {
    when(
      () => accountRepo.deleteAccount(stepUpToken: 'token'),
    ).thenAnswer((_) async => const ApiResult.success(null));
    when(
      () => authRepo.clearSession(),
    ).thenAnswer((_) async => const ApiResult.success(null));

    expect(await useCase(stepUpToken: 'token'), isA<Success<void>>());
    verify(() => authRepo.clearSession()).called(1);
  });

  test('keeps the session when the server refuses', () async {
    when(() => accountRepo.deleteAccount(stepUpToken: 'expired')).thenAnswer(
      (_) async => const ApiResult.failure(
        AppApiFailure(message: 'errors.identity.step_up_expired'),
      ),
    );

    expect(
      await useCase(stepUpToken: 'expired'),
      isFailureWith('errors.identity.step_up_expired'),
    );
    verifyNever(() => authRepo.clearSession());
  });
}
