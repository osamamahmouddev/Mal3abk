import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/security/biometric_lock.dart';
import 'package:mal3abk/features/settings/presentation/cubit/biometric_lock_cubit.dart';
import 'package:mal3abk/features/settings/presentation/cubit/biometric_lock_state.dart';
import 'package:mocktail/mocktail.dart';

class MockBiometricLock extends Mock implements BiometricLock {}

void main() {
  late MockBiometricLock lock;
  late BiometricLockCubit cubit;

  setUp(() {
    lock = MockBiometricLock();
    when(() => lock.isAvailable()).thenAnswer((_) async => true);
    when(() => lock.isEnabled()).thenAnswer((_) async => false);
    when(
      () => lock.setEnabled(enabled: any(named: 'enabled')),
    ).thenAnswer((_) async {});
    cubit = BiometricLockCubit(biometricLock: lock);
  });

  tearDown(() => cubit.close());

  test('hides the setting on devices without biometrics', () async {
    when(() => lock.isAvailable()).thenAnswer((_) async => false);

    await cubit.load();

    expect(cubit.state, const BiometricLockState.unavailable());
  });

  test('turns the lock on only after a successful check', () async {
    when(() => lock.authenticate(any())).thenAnswer((_) async => false);
    await cubit.load();

    await cubit.setEnabled(enabled: true, reason: 'r');
    expect(cubit.state, const BiometricLockState.ready(enabled: false));
    verifyNever(() => lock.setEnabled(enabled: true));

    when(() => lock.authenticate(any())).thenAnswer((_) async => true);
    await cubit.setEnabled(enabled: true, reason: 'r');
    expect(cubit.state, const BiometricLockState.ready(enabled: true));
    verify(() => lock.setEnabled(enabled: true)).called(1);
  });
}
