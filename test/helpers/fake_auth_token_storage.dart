import 'package:mal3abk/core/local_storage/auth_token_storage.dart';
import 'package:mocktail/mocktail.dart';

/// In-memory token store for tests; records how often it was cleared.
class FakeAuthTokenStorage extends Fake implements AuthTokenStorage {
  FakeAuthTokenStorage({this.accessToken = '', this.refreshToken = ''});

  String accessToken;
  String refreshToken;
  int clearCount = 0;

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
  }

  @override
  Future<String> readAccessToken() async => accessToken;

  @override
  Future<String> readRefreshToken() async => refreshToken;

  @override
  Future<bool> hasSession() async => refreshToken.isNotEmpty;

  @override
  Future<void> clear() async {
    clearCount++;
    accessToken = '';
    refreshToken = '';
  }
}
