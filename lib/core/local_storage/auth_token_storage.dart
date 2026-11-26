import 'secure_storage.dart';

/// Keeps the session tokens in `flutter_secure_storage`, with an in-memory
/// copy so every request does not hit the platform keystore.
class AuthTokenStorage {
  AuthTokenStorage();

  static const String _accessTokenKey = 'auth_access_token';
  static const String _refreshTokenKey = 'auth_refresh_token';
  static const String _venueSessionKey = 'auth_venue_session';

  String? _accessToken;
  String? _refreshToken;
  bool? _isVenueSession;

  /// [isVenueSession] marks a venue owner/staff sign-in (email + password),
  /// which opens the venue dashboard instead of the player app. Every player
  /// sign-in saves `false`, so the mode always follows the last sign-in.
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    bool isVenueSession = false,
  }) async {
    await SharedPrefHelper.setSecuredString(_accessTokenKey, accessToken);
    await SharedPrefHelper.setSecuredString(_refreshTokenKey, refreshToken);
    await SharedPrefHelper.setSecuredString(
      _venueSessionKey,
      isVenueSession ? '1' : '',
    );
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _isVenueSession = isVenueSession;
  }

  /// Whether the saved session belongs to the venue dashboard. Only picks the
  /// screens to show: the API checks every venue permission itself.
  Future<bool> isVenueSession() async {
    return _isVenueSession ??=
        (await SharedPrefHelper.getSecuredString(_venueSessionKey)) == '1';
  }

  Future<String> readAccessToken() async {
    return _accessToken ??= await SharedPrefHelper.getSecuredString(
      _accessTokenKey,
    );
  }

  Future<String> readRefreshToken() async {
    return _refreshToken ??= await SharedPrefHelper.getSecuredString(
      _refreshTokenKey,
    );
  }

  Future<bool> hasSession() async {
    final refreshToken = await readRefreshToken();
    return refreshToken.isNotEmpty;
  }

  Future<void> clear() async {
    _accessToken = '';
    _refreshToken = '';
    _isVenueSession = false;
    await SharedPrefHelper.removeSecuredData(_accessTokenKey);
    await SharedPrefHelper.removeSecuredData(_refreshTokenKey);
    await SharedPrefHelper.removeSecuredData(_venueSessionKey);
  }
}
