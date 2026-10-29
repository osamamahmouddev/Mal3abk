import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/phone_change_repo.dart';
import '../apis/phone_change_api_service.dart';
import '../models/phone_change_code_request_body.dart';
import '../models/recover_phone_request_body.dart';
import '../models/start_phone_change_request_body.dart';
import '../models/start_phone_change_response_model.dart';
import '../models/step_up_request_body.dart';
import '../models/step_up_response_model.dart';
import '../models/verify_new_phone_response_model.dart';

class PhoneChangeRepoImpl implements PhoneChangeRepo {
  PhoneChangeRepoImpl({required this.phoneChangeApiService});

  static const String changePhoneScope = 'change_phone';

  final PhoneChangeApiService phoneChangeApiService;

  @override
  Future<ApiResult<StepUpResponseModel>> stepUp() async {
    try {
      final response = await phoneChangeApiService.stepUp(
        const StepUpRequestBody(scope: changePhoneScope),
      );
      return ApiResult.success(response);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<StartPhoneChangeResponseModel>> startPhoneChange(
    StartPhoneChangeRequestBody body,
  ) async {
    try {
      final response = await phoneChangeApiService.startPhoneChange(body);
      return ApiResult.success(response);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> verifyOldPhone(
    PhoneChangeCodeRequestBody body,
  ) async {
    try {
      await phoneChangeApiService.verifyOldPhone(body);
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<VerifyNewPhoneResponseModel>> verifyNewPhone(
    PhoneChangeCodeRequestBody body,
  ) async {
    try {
      final response = await phoneChangeApiService.verifyNewPhone(body);
      return ApiResult.success(response);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> recoverPhone(String recoveryToken) async {
    try {
      await phoneChangeApiService.recoverPhone(
        RecoverPhoneRequestBody(recoveryToken: recoveryToken),
      );
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }
}
