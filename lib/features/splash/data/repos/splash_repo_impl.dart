import '../../../../core/local_storage/auth_token_storage.dart';
import '../../domain/repos/splash_repo.dart';

class SplashRepoImpl implements SplashRepo {
  SplashRepoImpl({required this.tokenStorage});

  final AuthTokenStorage tokenStorage;

  @override
  Future<bool> isAuthenticated() async {
    return tokenStorage.hasSession();
  }
}
