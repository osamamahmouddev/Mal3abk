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

  /// MonsterASP live API server: http://mal3abk.runasp.net
  /// Can be overridden with `--dart-define=BASE_URL=...`
  @override
  String get baseUrl {
    if (_baseUrlOverride.isNotEmpty) return _baseUrlOverride;
    return 'http://mal3abk.runasp.net';
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

  static const String _baseUrlOverride = String.fromEnvironment('BASE_URL');

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
}
