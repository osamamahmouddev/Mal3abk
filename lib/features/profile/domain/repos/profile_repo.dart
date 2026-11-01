import '../../../../core/network/api_result.dart';
import '../../data/models/complete_profile_request_body.dart';
import '../../data/models/my_profile_model.dart';

abstract class ProfileRepo {
  Future<ApiResult<MyProfileModel>> getMyProfile();
  Future<ApiResult<MyProfileModel>> completeProfile(
    CompleteProfileRequestBody body,
  );
}
