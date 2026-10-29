import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/local_storage/auth_token_storage.dart';

void main() {
  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  group('AuthTokenStorage', () {
    test('has no session before tokens are saved', () async {
      expect(await AuthTokenStorage().hasSession(), isFalse);
    });

    test('persists tokens across instances', () async {
      await AuthTokenStorage().saveTokens(
        accessToken: 'access',
        refreshToken: 'refresh',
      );

      final storage = AuthTokenStorage();
      expect(await storage.readAccessToken(), 'access');
      expect(await storage.readRefreshToken(), 'refresh');
      expect(await storage.hasSession(), isTrue);
    });

    test('clear removes both tokens', () async {
      final storage = AuthTokenStorage();
      await storage.saveTokens(accessToken: 'access', refreshToken: 'refresh');

      await storage.clear();

      expect(await storage.hasSession(), isFalse);
      expect(await AuthTokenStorage().readAccessToken(), isEmpty);
    });
  });
}
