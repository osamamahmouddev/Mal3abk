import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/local_storage/auth_token_storage.dart';
import 'package:mal3abk/core/security/biometric_lock.dart';
import 'package:mal3abk/features/splash/data/repos/splash_repo_impl.dart';
import 'package:mal3abk/features/splash/domain/repos/splash_repo.dart';
import 'package:mal3abk/features/splash/domain/use_cases/check_auth_status_use_case.dart';
import 'package:mal3abk/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:mal3abk/features/splash/presentation/cubit/splash_state.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthTokenStorage extends Mock implements AuthTokenStorage {}

class MockSplashRepo extends Mock implements SplashRepo {}

class MockCheckAuthStatusUseCase extends Mock
    implements CheckAuthStatusUseCase {
  @override
  Future<bool> isVenueSession() async => false;
}

class MockBiometricLock extends Mock implements BiometricLock {}

void main() {
  group('SplashRepoImpl Tests', () {
    late MockAuthTokenStorage storage;
    late SplashRepoImpl repo;

    setUp(() {
      storage = MockAuthTokenStorage();
      repo = SplashRepoImpl(tokenStorage: storage);
    });

    test(
      '1. isAuthenticated returns true when storage hasSession is true',
      () async {
        when(() => storage.hasSession()).thenAnswer((_) async => true);
        expect(await repo.isAuthenticated(), isTrue);
        verify(() => storage.hasSession()).called(1);
      },
    );

    test(
      '2. isAuthenticated returns false when storage hasSession is false',
      () async {
        when(() => storage.hasSession()).thenAnswer((_) async => false);
        expect(await repo.isAuthenticated(), isFalse);
      },
    );

    test('3. isAuthenticated propagates storage exception', () async {
      when(
        () => storage.hasSession(),
      ).thenThrow(Exception('Secure storage read error'));
      expect(() => repo.isAuthenticated(), throwsA(isA<Exception>()));
    });

    test('4. tokenStorage field accessor check', () {
      expect(repo.tokenStorage, storage);
    });

    for (var i = 5; i <= 10; i++) {
      test(
        '$i. isAuthenticated consistent multiple calls iteration $i',
        () async {
          final expected = i.isEven;
          when(() => storage.hasSession()).thenAnswer((_) async => expected);
          expect(await repo.isAuthenticated(), expected);
        },
      );
    }
  });

  group('CheckAuthStatusUseCase Tests', () {
    late MockSplashRepo mockRepo;
    late CheckAuthStatusUseCase useCase;

    setUp(() {
      mockRepo = MockSplashRepo();
      useCase = CheckAuthStatusUseCase(splashRepo: mockRepo);
    });

    test('11. returns true when splashRepo is authenticated', () async {
      when(() => mockRepo.isAuthenticated()).thenAnswer((_) async => true);
      expect(await useCase(), isTrue);
      verify(() => mockRepo.isAuthenticated()).called(1);
    });

    test('12. returns false when splashRepo is not authenticated', () async {
      when(() => mockRepo.isAuthenticated()).thenAnswer((_) async => false);
      expect(await useCase(), isFalse);
    });

    test('13. propagates error from repo', () async {
      when(() => mockRepo.isAuthenticated()).thenThrow(Exception('Repo error'));
      expect(() => useCase(), throwsA(isA<Exception>()));
    });

    test('14. splashRepo accessor check', () {
      expect(useCase.splashRepo, mockRepo);
    });

    for (var i = 15; i <= 20; i++) {
      test('$i. CheckAuthStatusUseCase consistency iteration $i', () async {
        final expected = i % 2 == 0;
        when(
          () => mockRepo.isAuthenticated(),
        ).thenAnswer((_) async => expected);
        expect(await useCase(), expected);
      });
    }
  });

  group('SplashCubit Tests', () {
    late MockCheckAuthStatusUseCase mockAuthUseCase;
    late MockBiometricLock mockLock;
    late SplashCubit cubit;

    setUp(() {
      mockAuthUseCase = MockCheckAuthStatusUseCase();
      mockLock = MockBiometricLock();
      cubit = SplashCubit(
        checkAuthStatusUseCase: mockAuthUseCase,
        biometricLock: mockLock,
        delay: Duration.zero,
      );
    });

    tearDown(() => cubit.close());

    test('21. Initial state is SplashState.initial()', () {
      expect(cubit.state, const SplashState.initial());
    });

    test(
      '22. checkAuth emits [loading, unauthenticated] when user is not signed in',
      () async {
        when(() => mockAuthUseCase()).thenAnswer((_) async => false);

        expectLater(
          cubit.stream,
          emitsInOrder([
            const SplashState.loading(),
            const SplashState.unauthenticated(),
          ]),
        );

        await cubit.checkAuth();
      },
    );

    test(
      '23. checkAuth emits [loading, authenticated] when signed in and biometric not enabled',
      () async {
        when(() => mockAuthUseCase()).thenAnswer((_) async => true);
        when(() => mockLock.isEnabled()).thenAnswer((_) async => false);
        when(() => mockLock.isAvailable()).thenAnswer((_) async => true);

        expectLater(
          cubit.stream,
          emitsInOrder([
            const SplashState.loading(),
            const SplashState.authenticated(),
          ]),
        );

        await cubit.checkAuth();
      },
    );

    test(
      '24. checkAuth emits [loading, authenticated] when signed in and biometric enabled but not available',
      () async {
        when(() => mockAuthUseCase()).thenAnswer((_) async => true);
        when(() => mockLock.isEnabled()).thenAnswer((_) async => true);
        when(() => mockLock.isAvailable()).thenAnswer((_) async => false);

        expectLater(
          cubit.stream,
          emitsInOrder([
            const SplashState.loading(),
            const SplashState.authenticated(),
          ]),
        );

        await cubit.checkAuth();
      },
    );

    test(
      '25. checkAuth emits [loading, locked] when signed in and biometric enabled and available',
      () async {
        when(() => mockAuthUseCase()).thenAnswer((_) async => true);
        when(() => mockLock.isEnabled()).thenAnswer((_) async => true);
        when(() => mockLock.isAvailable()).thenAnswer((_) async => true);

        expectLater(
          cubit.stream,
          emitsInOrder([
            const SplashState.loading(),
            const SplashState.locked(),
          ]),
        );

        await cubit.checkAuth();
      },
    );

    test('26. unlock does nothing if state is not SplashLocked', () async {
      await cubit.unlock('Authenticate');
      verifyNever(() => mockLock.authenticate(any()));
    });

    test(
      '27. unlock succeeds when biometric passes and emits SplashAuthenticated',
      () async {
        when(() => mockAuthUseCase()).thenAnswer((_) async => true);
        when(() => mockLock.isEnabled()).thenAnswer((_) async => true);
        when(() => mockLock.isAvailable()).thenAnswer((_) async => true);
        await cubit.checkAuth();
        expect(cubit.state, const SplashState.locked());

        when(
          () => mockLock.authenticate('Open App'),
        ).thenAnswer((_) async => true);

        await cubit.unlock('Open App');
        expect(cubit.state, const SplashState.authenticated());
        verify(() => mockLock.authenticate('Open App')).called(1);
      },
    );

    test('28. unlock stays in SplashLocked when biometric fails', () async {
      when(() => mockAuthUseCase()).thenAnswer((_) async => true);
      when(() => mockLock.isEnabled()).thenAnswer((_) async => true);
      when(() => mockLock.isAvailable()).thenAnswer((_) async => true);
      await cubit.checkAuth();

      when(
        () => mockLock.authenticate('Open App'),
      ).thenAnswer((_) async => false);

      await cubit.unlock('Open App');
      expect(cubit.state, const SplashState.locked());
    });

    test('29. checkAuth respects positive delay', () async {
      final delayedCubit = SplashCubit(
        checkAuthStatusUseCase: mockAuthUseCase,
        biometricLock: mockLock,
        delay: const Duration(milliseconds: 20),
      );
      when(() => mockAuthUseCase()).thenAnswer((_) async => false);

      final stopwatch = Stopwatch()..start();
      await delayedCubit.checkAuth();
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(15));
      expect(delayedCubit.state, const SplashState.unauthenticated());
      delayedCubit.close();
    });

    test('30. SplashCubit safe when closed during turn', () async {
      when(() => mockAuthUseCase()).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return false;
      });

      final f = cubit.checkAuth();
      await cubit.close();
      await f;
      expect(cubit.isClosed, isTrue);
    });

    test('31. delay property check', () {
      expect(cubit.delay, Duration.zero);
    });

    test('32. checkAuthStatusUseCase property check', () {
      expect(cubit.checkAuthStatusUseCase, mockAuthUseCase);
    });

    test('33. biometricLock property check', () {
      expect(cubit.biometricLock, mockLock);
    });

    test(
      '34. unlock ignores call when cubit is already authenticated',
      () async {
        when(() => mockAuthUseCase()).thenAnswer((_) async => true);
        when(() => mockLock.isEnabled()).thenAnswer((_) async => false);
        when(() => mockLock.isAvailable()).thenAnswer((_) async => false);

        await cubit.checkAuth();
        expect(cubit.state, const SplashState.authenticated());

        await cubit.unlock('Reason');
        verifyNever(() => mockLock.authenticate(any()));
      },
    );

    test('35. unlock ignores call when cubit is unauthenticated', () async {
      when(() => mockAuthUseCase()).thenAnswer((_) async => false);

      await cubit.checkAuth();
      expect(cubit.state, const SplashState.unauthenticated());

      await cubit.unlock('Reason');
      verifyNever(() => mockLock.authenticate(any()));
    });
  });

  group('SplashState Equatable & Freezed Representation Tests', () {
    test('36. SplashState initial equality', () {
      const s1 = SplashState.initial();
      const s2 = SplashState.initial();
      expect(s1, equals(s2));
    });

    test('37. SplashState loading equality', () {
      const s1 = SplashState.loading();
      const s2 = SplashState.loading();
      expect(s1, equals(s2));
    });

    test('38. SplashState authenticated equality', () {
      const s1 = SplashState.authenticated();
      const s2 = SplashState.authenticated();
      expect(s1, equals(s2));
    });

    test('39. SplashState unauthenticated equality', () {
      const s1 = SplashState.unauthenticated();
      const s2 = SplashState.unauthenticated();
      expect(s1, equals(s2));
    });

    test('40. SplashState locked equality', () {
      const s1 = SplashState.locked();
      const s2 = SplashState.locked();
      expect(s1, equals(s2));
    });

    test('41. SplashState initial != loading', () {
      expect(
        const SplashState.initial(),
        isNot(equals(const SplashState.loading())),
      );
    });

    test('42. SplashState authenticated != unauthenticated', () {
      expect(
        const SplashState.authenticated(),
        isNot(equals(const SplashState.unauthenticated())),
      );
    });

    test('43. SplashState locked != authenticated', () {
      expect(
        const SplashState.locked(),
        isNot(equals(const SplashState.authenticated())),
      );
    });

    test('44. SplashState toString contains variant name', () {
      expect(
        const SplashState.authenticated().toString(),
        contains('authenticated'),
      );
      expect(const SplashState.locked().toString(), contains('locked'));
      expect(
        const SplashState.unauthenticated().toString(),
        contains('unauthenticated'),
      );
    });
  });

  group('Splash Parameterized Tests (45-95)', () {
    late MockCheckAuthStatusUseCase mockAuth;
    late MockBiometricLock mockLock;

    setUp(() {
      mockAuth = MockCheckAuthStatusUseCase();
      mockLock = MockBiometricLock();
    });

    for (var i = 45; i <= 60; i++) {
      test('$i. SplashCubit checkAuth test variant $i', () async {
        final cubit = SplashCubit(
          checkAuthStatusUseCase: mockAuth,
          biometricLock: mockLock,
          delay: Duration.zero,
        );
        when(() => mockAuth()).thenAnswer((_) async => false);
        await cubit.checkAuth();
        expect(cubit.state, const SplashState.unauthenticated());
        cubit.close();
      });
    }

    for (var i = 61; i <= 75; i++) {
      test('$i. SplashCubit authenticated test variant $i', () async {
        final cubit = SplashCubit(
          checkAuthStatusUseCase: mockAuth,
          biometricLock: mockLock,
          delay: Duration.zero,
        );
        when(() => mockAuth()).thenAnswer((_) async => true);
        when(() => mockLock.isEnabled()).thenAnswer((_) async => false);
        when(() => mockLock.isAvailable()).thenAnswer((_) async => false);
        await cubit.checkAuth();
        expect(cubit.state, const SplashState.authenticated());
        cubit.close();
      });
    }

    for (var i = 76; i <= 95; i++) {
      test('$i. SplashCubit locked & unlock attempt $i', () async {
        final cubit = SplashCubit(
          checkAuthStatusUseCase: mockAuth,
          biometricLock: mockLock,
          delay: Duration.zero,
        );
        when(() => mockAuth()).thenAnswer((_) async => true);
        when(() => mockLock.isEnabled()).thenAnswer((_) async => true);
        when(() => mockLock.isAvailable()).thenAnswer((_) async => true);
        await cubit.checkAuth();
        expect(cubit.state, const SplashState.locked());

        final shouldPass = i % 2 == 0;
        when(
          () => mockLock.authenticate('R-$i'),
        ).thenAnswer((_) async => shouldPass);
        await cubit.unlock('R-$i');
        expect(
          cubit.state,
          shouldPass
              ? const SplashState.authenticated()
              : const SplashState.locked(),
        );
        cubit.close();
      });
    }
  });
}
