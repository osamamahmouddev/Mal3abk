import '../config/env_config.dart';

/// INTEGRATION POINT — Cloudflare Turnstile on mobile.
///
/// `POST /auth/otp/send` requires a Turnstile token. Turnstile has no native
/// mobile SDK, so production needs a WebView challenge (rendering the
/// Turnstile widget with the site key) whose callback token is returned
/// here. Until that lands, the token comes from [EnvConfig.turnstileToken]:
/// any non-empty value passes in the Development API; production sends an
/// empty token and the API answers `Identity.InvalidTurnstileToken`.
class TurnstileTokenProvider {
  TurnstileTokenProvider({required this.envConfig});

  final EnvConfig envConfig;

  Future<String> getToken() async => envConfig.turnstileToken;
}
