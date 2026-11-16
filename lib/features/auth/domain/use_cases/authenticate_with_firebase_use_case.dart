import '../../../../core/network/api_result.dart';
import '../../data/models/verify_otp_response_model.dart';
import '../repos/auth_repo.dart';

class AuthenticateWithFirebaseUseCase {
  const AuthenticateWithFirebaseUseCase({required this.authRepo});

  final AuthRepo authRepo;

  Future<ApiResult<VerifyOtpResponseModel>> call({
    required String idToken,
    String? fullName,
    bool restoreAccount = false,
  }) async {
    final result = await authRepo.authenticateWithFirebase(
      idToken: idToken,
      fullName: fullName,
      restoreAccount: restoreAccount,
    );

    if (result case Success(:final data)) {
      final access = data.accessToken;
      final refresh = data.refreshToken;
      if (access != null &&
          access.isNotEmpty &&
          refresh != null &&
          refresh.isNotEmpty) {
        await authRepo.saveSession(
          accessToken: access,
          refreshToken: refresh,
        );
      }
    }

    return result;
  }
}
