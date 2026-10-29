import '../../../../core/network/api_result.dart';
import '../repos/auth_repo.dart';

/// Signing out always ends the local session, even when the API call to
/// revoke the refresh token fails (offline, expired token).
class LogoutUseCase {
  LogoutUseCase({required this.authRepo});

  final AuthRepo authRepo;

  Future<ApiResult<void>> call() async {
    await authRepo.logout();
    return authRepo.clearSession();
  }
}
