import 'secure_storage.dart';

/// Keeps the session tokens in `flutter_secure_storage`, with an in-memory
/// copy so every request does not hit the platform keystore.
class AuthTokenStorage {
  AuthTokenStorage();

  static const String _accessTokenKey = 'auth_access_token';
  static const String _refreshTokenKey = 'auth_refresh_token';

  String? _accessToken;
  String? _refreshToken;

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await SharedPrefHelper.setSecuredString(_accessTokenKey, accessToken);
    await SharedPrefHelper.setSecuredString(_refreshTokenKey, refreshToken);
    _accessToken = accessToken;
    _refreshToken = refreshToken;
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
    await SharedPrefHelper.removeSecuredData(_accessTokenKey);
    await SharedPrefHelper.removeSecuredData(_refreshTokenKey);
  }
}
