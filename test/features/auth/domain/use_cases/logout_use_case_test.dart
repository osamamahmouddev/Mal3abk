import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/auth/domain/repos/auth_repo.dart';
import 'package:mal3abk/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/auth_fixtures.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late MockAuthRepo authRepo;
  late LogoutUseCase useCase;

  setUp(() {
    authRepo = MockAuthRepo();
    useCase = LogoutUseCase(authRepo: authRepo);
    when(
      () => authRepo.clearSession(),
    ).thenAnswer((_) async => const ApiResult.success(null));
  });

  group('LogoutUseCase', () {
    test('revokes the refresh token and clears the session', () async {
      when(
        () => authRepo.logout(),
      ).thenAnswer((_) async => const ApiResult.success(null));

      final result = await useCase();

      expect(result, isA<Success<void>>());
      verifyInOrder([() => authRepo.logout(), () => authRepo.clearSession()]);
    });

    test('clears the session even when the API call fails', () async {
      when(
        () => authRepo.logout(),
      ).thenAnswer((_) async => const ApiResult.failure(serverFailure));

      final result = await useCase();

      expect(result, isA<Success<void>>());
      verify(() => authRepo.clearSession()).called(1);
    });
  });
}
