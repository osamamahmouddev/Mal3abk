import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/security/biometric_lock.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import 'biometric_lock_state.dart';

class BiometricLockCubit extends Cubit<BiometricLockState>
    with SafeEmitCubitMixin<BiometricLockState> {
  BiometricLockCubit({required this.biometricLock})
    : super(const BiometricLockState.loading());

  final BiometricLock biometricLock;

  Future<void> load() async {
    if (!await biometricLock.isAvailable()) {
      emitIfOpen(const BiometricLockState.unavailable());
      return;
    }
    emitIfOpen(
      BiometricLockState.ready(enabled: await biometricLock.isEnabled()),
    );
  }

  /// Turning the lock on needs a successful check first, so nobody locks
  /// themselves out with a sensor that doesn't recognise them.
  Future<void> setEnabled({
    required bool enabled,
    required String reason,
  }) async {
    if (state is! BiometricLockReady) return;
    if (enabled && !await biometricLock.authenticate(reason)) return;
    await biometricLock.setEnabled(enabled: enabled);
    emitIfOpen(BiometricLockState.ready(enabled: enabled));
  }
}
