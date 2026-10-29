import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../data/models/verify_otp_request_body.dart';
import '../../data/models/verify_otp_response_model.dart';
import '../repos/auth_repo.dart';
import 'validate_otp_code_use_case.dart';

/// Verifies the code, then persists the issued session. A response without
/// tokens is treated as a failed sign-in.
class VerifyOtpUseCase {
  VerifyOtpUseCase({
    required this.authRepo,
    required this.validateOtpCodeUseCase,
  });

  final AuthRepo authRepo;
  final ValidateOtpCodeUseCase validateOtpCodeUseCase;

  Future<ApiResult<VerifyOtpResponseModel>> call({
    required String phoneNumber,
    required String code,
  }) async {
    final codeResult = validateOtpCodeUseCase(code);
    if (codeResult case ApiFailure(:final failure)) {
      return ApiResult.failure(failure);
    }
    final validCode = (codeResult as Success<String>).data;

    final verifyResult = await authRepo.verifyOtp(
      VerifyOtpRequestBody(phoneNumber: phoneNumber, code: validCode),
    );
    if (verifyResult case ApiFailure(:final failure)) {
      return ApiResult.failure(failure);
    }
    final response = (verifyResult as Success<VerifyOtpResponseModel>).data;

    final accessToken = response.accessToken ?? '';
    final refreshToken = response.refreshToken ?? '';
    if (accessToken.isEmpty || refreshToken.isEmpty) {
      return const ApiResult.failure(
        AppApiFailure(
          message: 'common.unexpected_error',
          code: 'auth.session_not_issued',
        ),
      );
    }

    final saveResult = await authRepo.saveSession(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
    if (saveResult case ApiFailure(:final failure)) {
      return ApiResult.failure(failure);
    }
    return ApiResult.success(response);
  }
}
