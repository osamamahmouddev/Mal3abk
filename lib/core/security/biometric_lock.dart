import 'package:local_auth/local_auth.dart';

import '../local_storage/secure_storage.dart';

/// Optional app lock: once the player turns it on, a signed-in session opens
/// only after a fingerprint, face or device-credential check. The session
/// itself stays in secure storage; this only gates showing it.
class BiometricLock {
  BiometricLock({LocalAuthentication? auth})
    : _auth = auth ?? LocalAuthentication();

  static const String _enabledKey = 'biometric_lock_enabled';

  final LocalAuthentication _auth;

  Future<bool> isAvailable() async {
    try {
      return await _auth.isDeviceSupported() &&
          (await _auth.getAvailableBiometrics()).isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<bool> isEnabled() async {
    try {
      return await SharedPrefHelper.getBool(_enabledKey);
    } catch (_) {
      return false;
    }
  }

  Future<void> setEnabled({required bool enabled}) async {
    try {
      await SharedPrefHelper.setData(_enabledKey, enabled);
    } catch (_) {}
  }

  /// False when the check fails, is cancelled or can't run.
  Future<bool> authenticate(String reason) async {
    try {
      return await _auth.authenticate(localizedReason: reason);
    } catch (_) {
      return false;
    }
  }
}
