abstract class EnvConfig {
  /// Test phone number reserved for Apple App Store / test review that bypasses Firebase SMS.
  static const String reviewTestPhoneNumber = '+201000000999';

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

/// The `dev` flavor: talks to the staging server on MonsterASP by default,
/// or localhost/emulator when overridden via `--dart-define=BASE_URL=...`.
class DevEnvConfig implements EnvConfig {
  const DevEnvConfig();

  static const String _baseUrlOverride = String.fromEnvironment('BASE_URL');

  /// Defaults to the staging API on MonsterASP (mal3abk-staging.runasp.net) so physical
  /// device builds and TestFlight reach the staging backend immediately.
  /// Can be overridden with `--dart-define=BASE_URL=http://10.0.2.2:5000` for local emulator.
  @override
  String get baseUrl {
    if (_baseUrlOverride.isNotEmpty) return _baseUrlOverride;
    return 'http://mal3abk-staging.runasp.net';
  }

  @override
  String get envName => 'dev';

  @override
  bool get isDebug => true;

  @override
  String get turnstileToken => const String.fromEnvironment(
    'TURNSTILE_TOKEN',
    defaultValue: 'dev-mobile-turnstile',
  );

  /// Off by default: staging/local sign-in reads the API's code from logs/SMS gateway.
  @override
  bool get useFirebasePhoneAuth =>
      const bool.fromEnvironment('FIREBASE_PHONE_AUTH');
}

/// The `staging` flavor: explicitly named alias for staging server.
class StagingEnvConfig implements EnvConfig {
  const StagingEnvConfig();

  static const String _baseUrlOverride = String.fromEnvironment('BASE_URL');

  @override
  String get baseUrl {
    if (_baseUrlOverride.isNotEmpty) return _baseUrlOverride;
    return 'http://mal3abk-staging.runasp.net';
  }

  @override
  String get envName => 'staging';

  @override
  bool get isDebug => true;

  @override
  String get turnstileToken => const String.fromEnvironment(
    'TURNSTILE_TOKEN',
    defaultValue: 'dev-mobile-turnstile',
  );

  @override
  bool get useFirebasePhoneAuth =>
      const bool.fromEnvironment('FIREBASE_PHONE_AUTH');
}

/// The `prod` flavor: the live server.
class ProdEnvConfig implements EnvConfig {
  const ProdEnvConfig();

  static const String _baseUrlOverride = String.fromEnvironment('BASE_URL');

  /// MonsterASP live API server. Can be overridden with
  /// `--dart-define=BASE_URL=...`.
  @override
  String get baseUrl {
    if (_baseUrlOverride.isNotEmpty) return _baseUrlOverride;
    return 'http://mal3abk.runasp.net';
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
