import '../../../../core/network/api_result.dart';
import '../../../auth/domain/repos/auth_repo.dart';
import '../../../auth/domain/use_cases/validate_otp_code_use_case.dart';
import '../../data/models/phone_change_code_request_body.dart';
import '../../data/models/verify_new_phone_response_model.dart';
import '../repos/phone_change_repo.dart';

/// A completed phone change revokes every session on the server, so the
/// local session is cleared too and the player signs in with the new number.
class VerifyNewPhoneUseCase {
  VerifyNewPhoneUseCase({
    required this.phoneChangeRepo,
    required this.authRepo,
    required this.validateOtpCodeUseCase,
  });

  final PhoneChangeRepo phoneChangeRepo;
  final AuthRepo authRepo;
  final ValidateOtpCodeUseCase validateOtpCodeUseCase;

  Future<ApiResult<VerifyNewPhoneResponseModel>> call({
    required String requestId,
    required String code,
  }) async {
    final codeResult = validateOtpCodeUseCase(code);
    if (codeResult case ApiFailure(:final failure)) {
      return ApiResult.failure(failure);
    }
    final validCode = (codeResult as Success<String>).data;

    final verifyResult = await phoneChangeRepo.verifyNewPhone(
      PhoneChangeCodeRequestBody(requestId: requestId, code: validCode),
    );
    if (verifyResult case Success(:final data)) {
      await authRepo.clearSession();
      return ApiResult.success(data);
    }
    return verifyResult;
  }
}
