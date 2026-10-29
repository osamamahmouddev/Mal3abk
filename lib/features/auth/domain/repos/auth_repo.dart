import '../../../../core/network/api_result.dart';
import '../../data/models/send_otp_response_model.dart';
import '../../data/models/verify_otp_request_body.dart';
import '../../data/models/verify_otp_response_model.dart';

abstract class AuthRepo {
  Future<ApiResult<SendOtpResponseModel>> sendOtp(String phoneNumber);
  Future<ApiResult<VerifyOtpResponseModel>> verifyOtp(
    VerifyOtpRequestBody body,
  );
  Future<ApiResult<void>> saveSession({
    required String accessToken,
    required String refreshToken,
  });
  Future<ApiResult<void>> logout();
  Future<ApiResult<void>> logoutAll();
  Future<ApiResult<void>> clearSession();
}
