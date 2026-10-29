import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/auth/domain/repos/auth_repo.dart';
import 'package:mal3abk/features/phone_change/domain/repos/phone_change_repo.dart';
import 'package:mal3abk/features/phone_change/domain/use_cases/recover_phone_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';

class MockPhoneChangeRepo extends Mock implements PhoneChangeRepo {}

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late MockPhoneChangeRepo repo;
  late MockAuthRepo authRepo;
  late RecoverPhoneUseCase useCase;

  setUp(() {
    repo = MockPhoneChangeRepo();
    authRepo = MockAuthRepo();
    useCase = RecoverPhoneUseCase(phoneChangeRepo: repo, authRepo: authRepo);
    when(
      () => authRepo.clearSession(),
    ).thenAnswer((_) async => const ApiResult.success(null));
  });

  group('RecoverPhoneUseCase', () {
    test('restores the number and clears the revoked session', () async {
      when(
        () => repo.recoverPhone('token-1'),
      ).thenAnswer((_) async => const ApiResult.success(null));

      final result = await useCase(' token-1 ');

      expect(result, isA<Success<void>>());
      verify(() => authRepo.clearSession()).called(1);
    });

    test('rejects a missing token without calling the API', () async {
      final result = await useCase('');

      expect(result, isFailureWith('errors.identity.recovery_link_invalid'));
      verifyZeroInteractions(repo);
    });

    test('returns the API failure for an expired link', () async {
      when(() => repo.recoverPhone(any())).thenAnswer(
        (_) async => const ApiResult.failure(
          AppApiFailure(message: 'errors.identity.recovery_link_invalid'),
        ),
      );

      final result = await useCase('token-1');

      expect(result, isFailureWith('errors.identity.recovery_link_invalid'));
      verifyNever(() => authRepo.clearSession());
    });
  });
}
