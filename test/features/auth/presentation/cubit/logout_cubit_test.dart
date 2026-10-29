import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/auth/domain/use_cases/logout_all_use_case.dart';
import 'package:mal3abk/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:mal3abk/features/auth/presentation/cubit/logout_cubit.dart';
import 'package:mal3abk/features/auth/presentation/cubit/logout_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/auth_fixtures.dart';

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

class MockLogoutAllUseCase extends Mock implements LogoutAllUseCase {}

void main() {
  late MockLogoutUseCase logoutUseCase;
  late MockLogoutAllUseCase logoutAllUseCase;
  late LogoutCubit cubit;

  setUp(() {
    logoutUseCase = MockLogoutUseCase();
    logoutAllUseCase = MockLogoutAllUseCase();
    cubit = LogoutCubit(
      logoutUseCase: logoutUseCase,
      logoutAllUseCase: logoutAllUseCase,
    );
  });

  tearDown(() => cubit.close());

  group('LogoutCubit.logout', () {
    test('emits [loading, success]', () async {
      when(
        () => logoutUseCase(),
      ).thenAnswer((_) async => const ApiResult.success(null));

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const LogoutState.loading(),
          const LogoutState.success(),
        ]),
      );
      await cubit.logout();
      await expectation;
    });
  });

  group('LogoutCubit.logoutAll', () {
    test('emits [loading, success] when all sessions are revoked', () async {
      when(
        () => logoutAllUseCase(),
      ).thenAnswer((_) async => const ApiResult.success(null));

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const LogoutState.loading(),
          const LogoutState.success(),
        ]),
      );
      await cubit.logoutAll();
      await expectation;
    });

    test('emits [loading, error] when the server call fails', () async {
      when(
        () => logoutAllUseCase(),
      ).thenAnswer((_) async => const ApiResult.failure(serverFailure));

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const LogoutState.loading(),
          LogoutState.error(serverFailure.message),
        ]),
      );
      await cubit.logoutAll();
      await expectation;
    });
  });
}
