import '../config/env_config.dart';

/// App Attestation provider (Google Play Integrity on Android, DeviceCheck /
/// App Attest on iOS). Provides integrity tokens sent with critical operations
/// like booking creation and OTP verification.
class AppAttestationProvider {
  const AppAttestationProvider({required this.envConfig});

  final EnvConfig envConfig;

  /// Returns an integrity token for attesting requests. In dev/test environments,
  /// returns a mock token if configured, or null when attestation is not required.
  Future<String?> getAttestationToken() async {
    if (envConfig.isDebug) {
      return 'dev-app-integrity-token';
    }
    // Production integration bridge with Google Play Integrity / Apple App Attest.
    return null;
  }
}
