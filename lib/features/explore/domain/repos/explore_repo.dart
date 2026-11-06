import '../../../../core/network/api_result.dart';
import '../../data/models/explore_result_model.dart';
import '../../data/models/explore_venue_card_model.dart';
import '../../data/models/pitch_details_model.dart';
import '../../data/models/venue_availability_model.dart';
import '../../data/models/venue_details_model.dart';

abstract class ExploreRepo {
  Future<ApiResult<ExploreResultModel>> exploreVenues({
    String? city,
    String? area,
    int? page,
    int? pageSize,
  });

  Future<ApiResult<VenueDetailsModel>> getVenueDetails(String venueId);

  Future<ApiResult<List<PitchDetailsModel>>> getVenuePitches(String venueId);

  Future<ApiResult<VenueAvailabilityModel>> getVenueAvailability(
    String venueId,
    String date,
  );

  Future<ApiResult<List<ExploreVenueCardModel>>> getFavorites();

  Future<ApiResult<void>> setFavorite(String venueId, {required bool favorite});
}
