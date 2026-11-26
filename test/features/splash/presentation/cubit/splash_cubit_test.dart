import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/security/biometric_lock.dart';
import 'package:mal3abk/features/splash/domain/use_cases/check_auth_status_use_case.dart';
import 'package:mal3abk/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:mal3abk/features/splash/presentation/cubit/splash_state.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckAuthStatusUseCase extends Mock
    implements CheckAuthStatusUseCase {}

class MockBiometricLock extends Mock implements BiometricLock {}

void main() {
  late MockCheckAuthStatusUseCase checkAuth;
  late MockBiometricLock lock;
  late SplashCubit cubit;

  setUp(() {
    checkAuth = MockCheckAuthStatusUseCase();
    when(() => checkAuth.isVenueSession()).thenAnswer((_) async => false);
    lock = MockBiometricLock();
    when(() => lock.isEnabled()).thenAnswer((_) async => false);
    when(() => lock.isAvailable()).thenAnswer((_) async => true);
    cubit = SplashCubit(
      checkAuthStatusUseCase: checkAuth,
      biometricLock: lock,
      delay: Duration.zero,
    );
  });

  tearDown(() => cubit.close());

  test('initial state is SplashState.initial()', () {
    expect(cubit.state, const SplashState.initial());
  });

  test('opens the app for a signed-in player without the lock', () async {
    when(() => checkAuth()).thenAnswer((_) async => true);

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        const SplashState.loading(),
        const SplashState.authenticated(),
      ]),
    );
    await cubit.checkAuth();
    await expectation;
  });

  test('goes to login when nobody is signed in', () async {
    when(() => checkAuth()).thenAnswer((_) async => false);

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        const SplashState.loading(),
        const SplashState.unauthenticated(),
      ]),
    );
    await cubit.checkAuth();
    await expectation;
    verifyNever(() => lock.isEnabled());
  });

  test('stays locked until the biometric check passes', () async {
    when(() => checkAuth()).thenAnswer((_) async => true);
    when(() => lock.isEnabled()).thenAnswer((_) async => true);
    var attempts = 0;
    when(
      () => lock.authenticate(any()),
    ).thenAnswer((_) async => attempts++ > 0);

    await cubit.checkAuth();
    expect(cubit.state, const SplashState.locked());

    await cubit.unlock('reason');
    expect(cubit.state, const SplashState.locked());

    await cubit.unlock('reason');
    expect(cubit.state, const SplashState.authenticated());
  });

  test('ignores the lock when the device lost its biometrics', () async {
    when(() => checkAuth()).thenAnswer((_) async => true);
    when(() => lock.isEnabled()).thenAnswer((_) async => true);
    when(() => lock.isAvailable()).thenAnswer((_) async => false);

    await cubit.checkAuth();

    expect(cubit.state, const SplashState.authenticated());
  });
}
