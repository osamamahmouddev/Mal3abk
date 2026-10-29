import 'package:flutter/foundation.dart';

abstract class EnvConfig {
  String get baseUrl;
  String get envName;
  bool get isDebug;

  /// Turnstile token sent with `POST /auth/otp/send` until the mobile
  /// Turnstile challenge is integrated (see `TurnstileTokenProvider`).
  String get turnstileToken;
}

class DevEnvConfig implements EnvConfig {
  const DevEnvConfig();

  static const String _baseUrlOverride = String.fromEnvironment('BASE_URL');

  /// Local API (`dotnet run`) listens on port 5000. The Android emulator
  /// reaches the host machine through 10.0.2.2. `127.0.0.1` rather than
  /// `localhost` avoids a stalled IPv6 (`::1`) connect. A physical device
  /// needs `--dart-define=BASE_URL=http://<host-lan-ip>:5000`.
  @override
  String get baseUrl {
    if (_baseUrlOverride.isNotEmpty) return _baseUrlOverride;
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:5000';
    }
    return 'http://127.0.0.1:5000';
  }

  @override
  String get envName => 'dev';

  @override
  bool get isDebug => true;

  /// The Development API accepts any non-empty Turnstile token.
  @override
  String get turnstileToken => const String.fromEnvironment(
    'TURNSTILE_TOKEN',
    defaultValue: 'dev-mobile-turnstile',
  );
}

class ProdEnvConfig implements EnvConfig {
  const ProdEnvConfig();

  @override
  String get baseUrl => 'https://api.malabak.app';

  @override
  String get envName => 'prod';

  @override
  bool get isDebug => false;

  @override
  String get turnstileToken => '';
}
