import 'package:flutter/foundation.dart';

abstract class EnvConfig {
  String get baseUrl;
  String get envName;
  bool get isDebug;

  /// Turnstile token sent with `POST /auth/otp/send` until the mobile
  /// Turnstile challenge is integrated (see `TurnstileTokenProvider`).
  String get turnstileToken;

  /// Whether Firebase texts the sign-in code (the API sends its own code when
  /// Firebase cannot). Override with `--dart-define=FIREBASE_PHONE_AUTH=...`.
  bool get useFirebasePhoneAuth;
}

/// The `dev` flavor: the API running on the developer's machine.
class DevEnvConfig implements EnvConfig {
  const DevEnvConfig();

  static const String _baseUrlOverride = String.fromEnvironment('BASE_URL');

  /// The Android emulator reaches the host through `10.0.2.2`; the iOS
  /// simulator and desktop share the host's loopback. A physical device needs
  /// `--dart-define=BASE_URL=http://<host-lan-ip>:5000`.
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

  /// Off by default: local sign-in reads the API's code from Mailpit and
  /// sends no real SMS.
  @override
  bool get useFirebasePhoneAuth =>
      const bool.fromEnvironment('FIREBASE_PHONE_AUTH');
}

/// The `prod` flavor: the live server.
class ProdEnvConfig implements EnvConfig {
  const ProdEnvConfig();

  static const String _baseUrlOverride = String.fromEnvironment('BASE_URL');

  /// MonsterASP live API server, HTTPS only. Can be overridden with
  /// `--dart-define=BASE_URL=https://...`.
  @override
  String get baseUrl {
    if (_baseUrlOverride.isNotEmpty) return _baseUrlOverride;
    return 'https://mal3abk.runasp.net';
  }

  @override
  String get envName => 'prod';

  @override
  bool get isDebug => false;

  @override
  String get turnstileToken => const String.fromEnvironment(
    'TURNSTILE_TOKEN',
    defaultValue: 'dev-mobile-turnstile',
  );

  @override
  bool get useFirebasePhoneAuth =>
      const bool.fromEnvironment('FIREBASE_PHONE_AUTH', defaultValue: true);
}
