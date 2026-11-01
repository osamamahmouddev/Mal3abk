import '../../../../core/network/api_result.dart';
import '../../data/models/complete_profile_request_body.dart';
import '../../data/models/my_profile_model.dart';
import '../repos/profile_repo.dart';

class CompleteProfileUseCase {
  CompleteProfileUseCase({required this.profileRepo});

  final ProfileRepo profileRepo;

  Future<ApiResult<MyProfileModel>> call(CompleteProfileRequestBody body) =>
      profileRepo.completeProfile(body);
}
