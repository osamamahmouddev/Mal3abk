import '../../../../core/network/api_result.dart';
import '../../data/models/venue_details_model.dart';
import '../repos/explore_repo.dart';

class GetVenueDetailsUseCase {
  GetVenueDetailsUseCase({required this.exploreRepo});

  final ExploreRepo exploreRepo;

  Future<ApiResult<VenueDetailsModel>> call(String venueId) =>
      exploreRepo.getVenueDetails(venueId);
}
