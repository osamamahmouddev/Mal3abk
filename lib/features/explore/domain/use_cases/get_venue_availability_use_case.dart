import '../../../../core/network/api_result.dart';
import '../../data/models/venue_availability_model.dart';
import '../repos/explore_repo.dart';

class GetVenueAvailabilityUseCase {
  const GetVenueAvailabilityUseCase({required this.exploreRepo});

  final ExploreRepo exploreRepo;

  Future<ApiResult<VenueAvailabilityModel>> call(String venueId, String date) {
    return exploreRepo.getVenueAvailability(venueId, date);
  }
}
