import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/profile_repo.dart';
import '../apis/profile_api_service.dart';
import '../models/complete_profile_request_body.dart';
import '../models/my_profile_model.dart';

class ProfileRepoImpl implements ProfileRepo {
  ProfileRepoImpl({required this.profileApiService});

  final ProfileApiService profileApiService;

  @override
  Future<ApiResult<MyProfileModel>> getMyProfile() async {
    try {
      final response = await profileApiService.getMyProfile();
      return ApiResult.success(response);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<MyProfileModel>> completeProfile(
    CompleteProfileRequestBody body,
  ) async {
    try {
      final response = await profileApiService.completeProfile(body);
      return ApiResult.success(response);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }
}
