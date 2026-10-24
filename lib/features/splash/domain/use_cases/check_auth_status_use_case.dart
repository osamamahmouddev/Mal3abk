import '../repos/splash_repo.dart';

class CheckAuthStatusUseCase {
  CheckAuthStatusUseCase({required this.splashRepo});

  final SplashRepo splashRepo;

  Future<bool> call() async {
    return splashRepo.isAuthenticated();
  }
}
