import '../../../../core/network/api_result.dart';
import '../../data/models/send_otp_response_model.dart';
import '../repos/auth_repo.dart';
import 'normalize_phone_number_use_case.dart';

class SendOtpUseCase {
  SendOtpUseCase({
    required this.authRepo,
    required this.normalizePhoneNumberUseCase,
  });

  final AuthRepo authRepo;
  final NormalizePhoneNumberUseCase normalizePhoneNumberUseCase;

  Future<ApiResult<SendOtpResponseModel>> call(String rawPhoneNumber) async {
    final phoneResult = normalizePhoneNumberUseCase(rawPhoneNumber);
    if (phoneResult case ApiFailure(:final failure)) {
      return ApiResult.failure(failure);
    }
    return authRepo.sendOtp((phoneResult as Success<String>).data);
  }
}
