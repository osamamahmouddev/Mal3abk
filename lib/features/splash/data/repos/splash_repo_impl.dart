import '../../../../core/network/dio_factory.dart';
import '../../domain/repos/splash_repo.dart';

class SplashRepoImpl implements SplashRepo {
  SplashRepoImpl();

  @override
  Future<bool> isAuthenticated() async {
    final token = await DioFactory.getToken();
    return token.isNotEmpty;
  }
}
