import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/splash/domain/use_cases/check_auth_status_use_case.dart';
import 'package:mal3abk/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:mal3abk/features/splash/presentation/cubit/splash_state.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckAuthStatusUseCase extends Mock
    implements CheckAuthStatusUseCase {}

void main() {
  late MockCheckAuthStatusUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockCheckAuthStatusUseCase();
  });

  group('SplashCubit', () {
    test('initial state is SplashState.initial()', () {
      final cubit = SplashCubit(
        checkAuthStatusUseCase: mockUseCase,
        delay: Duration.zero,
      );
      expect(cubit.state, const SplashState.initial());
      cubit.close();
    });

    test('emits [loading, authenticated] when user is logged in', () async {
      when(() => mockUseCase()).thenAnswer((_) async => true);
      final cubit = SplashCubit(
        checkAuthStatusUseCase: mockUseCase,
        delay: Duration.zero,
      );

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const SplashState.loading(),
          const SplashState.authenticated(),
        ]),
      );

      await cubit.checkAuth();
      await expectation;
      await cubit.close();
    });

    test('emits [loading, unauthenticated] when user is not logged in', () async {
      when(() => mockUseCase()).thenAnswer((_) async => false);
      final cubit = SplashCubit(
        checkAuthStatusUseCase: mockUseCase,
        delay: Duration.zero,
      );

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const SplashState.loading(),
          const SplashState.unauthenticated(),
        ]),
      );

      await cubit.checkAuth();
      await expectation;
      await cubit.close();
    });
  });
}
