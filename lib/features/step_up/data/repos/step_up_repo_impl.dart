import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/step_up_repo.dart';
import '../apis/step_up_api_service.dart';
import '../models/step_up_request_body.dart';

class StepUpRepoImpl implements StepUpRepo {
  StepUpRepoImpl({required this.stepUpApiService});

  final StepUpApiService stepUpApiService;

  @override
  Future<ApiResult<void>> sendCode() async {
    try {
      await stepUpApiService.sendCode();
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<String>> verify({
    required String scope,
    required String code,
  }) async {
    try {
      final response = await stepUpApiService.verify(
        StepUpRequestBody(scope: scope, secret: code),
      );
      return ApiResult.success(response.stepUpToken);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }
}
