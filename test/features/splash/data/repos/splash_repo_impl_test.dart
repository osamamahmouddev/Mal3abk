import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/splash/data/repos/splash_repo_impl.dart';

import '../../../../helpers/fake_auth_token_storage.dart';

void main() {
  group('SplashRepoImpl', () {
    test('is authenticated when a refresh token is stored', () async {
      final repo = SplashRepoImpl(
        tokenStorage: FakeAuthTokenStorage(refreshToken: 'refresh-1'),
      );

      expect(await repo.isAuthenticated(), isTrue);
    });

    test('is not authenticated without a refresh token', () async {
      final repo = SplashRepoImpl(tokenStorage: FakeAuthTokenStorage());

      expect(await repo.isAuthenticated(), isFalse);
    });
  });
}
