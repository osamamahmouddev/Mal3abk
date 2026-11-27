import '../../../../core/location/location_service.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/explore_filter_model.dart';
import '../../data/models/explore_result_model.dart';
import '../../data/models/map_bounds_model.dart';
import '../../data/models/map_venue_pin_model.dart';
import '../../data/models/explore_venue_card_model.dart';
import '../../data/models/pitch_details_model.dart';
import '../../data/models/sponsored_item_model.dart';
import '../../data/models/venue_availability_model.dart';
import '../../data/models/venue_details_model.dart';

abstract class ExploreRepo {
  /// With [near], results carry distances and can sort nearest first.
  Future<ApiResult<ExploreResultModel>> exploreVenues({
    GeoPoint? near,
    String? city,
    String? area,
    ExploreFilterModel filter = const ExploreFilterModel(),
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

  Future<ApiResult<List<ExploreVenueCardModel>>> getRecentlyViewed();

  Future<ApiResult<List<SponsoredItemModel>>> getFeaturedVenues();

  Future<ApiResult<void>> recordView(String venueId);

  Future<ApiResult<void>> clearRecentlyViewed();

  Future<ApiResult<MapSearchResultModel>> mapVenues({
    required MapBoundsModel bounds,
    ExploreFilterModel filter = const ExploreFilterModel(),
  });
}
