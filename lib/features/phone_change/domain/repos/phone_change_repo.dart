import '../../../../core/network/api_result.dart';
import '../../data/models/phone_change_code_request_body.dart';
import '../../data/models/start_phone_change_request_body.dart';
import '../../data/models/start_phone_change_response_model.dart';
import '../../data/models/verify_new_phone_response_model.dart';

abstract class PhoneChangeRepo {
  Future<ApiResult<StartPhoneChangeResponseModel>> startPhoneChange(
    StartPhoneChangeRequestBody body,
  );
  Future<ApiResult<void>> verifyOldPhone(PhoneChangeCodeRequestBody body);
  Future<ApiResult<VerifyNewPhoneResponseModel>> verifyNewPhone(
    PhoneChangeCodeRequestBody body,
  );
  Future<ApiResult<void>> recoverPhone(String recoveryToken);
}
