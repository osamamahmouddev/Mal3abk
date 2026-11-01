import '../../../../core/network/api_result.dart';
import '../../data/models/pitch_details_model.dart';
import '../repos/explore_repo.dart';

class GetVenuePitchesUseCase {
  GetVenuePitchesUseCase({required this.exploreRepo});

  final ExploreRepo exploreRepo;

  Future<ApiResult<List<PitchDetailsModel>>> call(String venueId) =>
      exploreRepo.getVenuePitches(venueId);
}
