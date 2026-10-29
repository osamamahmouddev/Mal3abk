import '../../../../core/network/api_result.dart';
import '../../../auth/domain/use_cases/validate_otp_code_use_case.dart';
import '../../data/models/phone_change_code_request_body.dart';
import '../repos/phone_change_repo.dart';

class VerifyOldPhoneUseCase {
  VerifyOldPhoneUseCase({
    required this.phoneChangeRepo,
    required this.validateOtpCodeUseCase,
  });

  final PhoneChangeRepo phoneChangeRepo;
  final ValidateOtpCodeUseCase validateOtpCodeUseCase;

  Future<ApiResult<void>> call({
    required String requestId,
    required String code,
  }) async {
    final codeResult = validateOtpCodeUseCase(code);
    if (codeResult case ApiFailure(:final failure)) {
      return ApiResult.failure(failure);
    }
    return phoneChangeRepo.verifyOldPhone(
      PhoneChangeCodeRequestBody(
        requestId: requestId,
        code: (codeResult as Success<String>).data,
      ),
    );
  }
}
