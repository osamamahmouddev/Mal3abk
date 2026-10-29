import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/auth/domain/repos/auth_repo.dart';
import 'package:mal3abk/features/auth/domain/use_cases/logout_all_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/auth_fixtures.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late MockAuthRepo authRepo;
  late LogoutAllUseCase useCase;

  setUp(() {
    authRepo = MockAuthRepo();
    useCase = LogoutAllUseCase(authRepo: authRepo);
    when(
      () => authRepo.clearSession(),
    ).thenAnswer((_) async => const ApiResult.success(null));
  });

  group('LogoutAllUseCase', () {
    test('clears the session after the server revokes all sessions', () async {
      when(
        () => authRepo.logoutAll(),
      ).thenAnswer((_) async => const ApiResult.success(null));

      final result = await useCase();

      expect(result, isA<Success<void>>());
      verify(() => authRepo.clearSession()).called(1);
    });

    test('keeps the session when the server call fails', () async {
      when(
        () => authRepo.logoutAll(),
      ).thenAnswer((_) async => const ApiResult.failure(serverFailure));

      final result = await useCase();

      expect(result, isFailureWith(serverFailure.message));
      verifyNever(() => authRepo.clearSession());
    });
  });
}
