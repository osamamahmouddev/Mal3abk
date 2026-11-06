import 'package:freezed_annotation/freezed_annotation.dart';

part 'biometric_lock_state.freezed.dart';

@freezed
sealed class BiometricLockState with _$BiometricLockState {
  const factory BiometricLockState.loading() = BiometricLockLoading;

  /// The device has no usable biometrics, so the setting is hidden.
  const factory BiometricLockState.unavailable() = BiometricLockUnavailable;
  const factory BiometricLockState.ready({required bool enabled}) =
      BiometricLockReady;
}
