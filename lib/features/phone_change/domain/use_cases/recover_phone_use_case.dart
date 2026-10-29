import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../../auth/domain/repos/auth_repo.dart';
import '../repos/phone_change_repo.dart';

/// Reverts an unauthorized phone change from the recovery link sent to the
/// old phone. The API revokes every session, so the local one is cleared.
class RecoverPhoneUseCase {
  RecoverPhoneUseCase({required this.phoneChangeRepo, required this.authRepo});

  final PhoneChangeRepo phoneChangeRepo;
  final AuthRepo authRepo;

  Future<ApiResult<void>> call(String recoveryToken) async {
    final token = recoveryToken.trim();
    if (token.isEmpty) {
      return const ApiResult.failure(
        AppApiFailure(
          message: 'errors.identity.recovery_link_invalid',
          code: 'recovery.missing_token',
        ),
      );
    }

    final result = await phoneChangeRepo.recoverPhone(token);
    if (result case Success()) {
      return authRepo.clearSession();
    }
    return result;
  }
}
