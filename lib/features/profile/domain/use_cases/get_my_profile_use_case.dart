import '../../../../core/network/api_result.dart';
import '../../data/models/my_profile_model.dart';
import '../repos/profile_repo.dart';

class GetMyProfileUseCase {
  GetMyProfileUseCase({required this.profileRepo});

  final ProfileRepo profileRepo;

  Future<ApiResult<MyProfileModel>> call() => profileRepo.getMyProfile();
}
