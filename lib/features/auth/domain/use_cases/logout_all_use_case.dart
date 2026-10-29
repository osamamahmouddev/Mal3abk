import '../../../../core/network/api_result.dart';
import '../repos/auth_repo.dart';

/// Revokes every session on the server; the local session is cleared only
/// when the server confirms, so a failure leaves the user signed in.
class LogoutAllUseCase {
  LogoutAllUseCase({required this.authRepo});

  final AuthRepo authRepo;

  Future<ApiResult<void>> call() async {
    final result = await authRepo.logoutAll();
    if (result case ApiFailure(:final failure)) {
      return ApiResult.failure(failure);
    }
    return authRepo.clearSession();
  }
}
