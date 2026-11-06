import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/location/location_service.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../domain/repos/explore_repo.dart';
import '../apis/explore_api_service.dart';
import '../models/explore_filter_model.dart';
import '../models/explore_result_model.dart';
import '../models/map_bounds_model.dart';
import '../models/map_venue_pin_model.dart';
import '../models/explore_venue_card_model.dart';
import '../models/pitch_details_model.dart';
import '../models/venue_availability_model.dart';
import '../models/venue_details_model.dart';

class ExploreRepoImpl implements ExploreRepo {
  ExploreRepoImpl({required this.exploreApiService});

  final ExploreApiService exploreApiService;

  /// Today's Cairo date for a kick-off window, as the API expects it.
  static String? _dateFor(ExploreFilterModel filter) {
    if (filter.timeWindow == null) return null;
    final today = CairoTime.today();
    return '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
  }

  static String? _facilities(ExploreFilterModel filter) =>
      filter.facilities.isEmpty ? null : filter.facilities.join(',');

  @override
  Future<ApiResult<ExploreResultModel>> exploreVenues({
    GeoPoint? near,
    String? city,
    String? area,
    ExploreFilterModel filter = const ExploreFilterModel(),
    int? page,
    int? pageSize,
  }) => _guard(
    () => exploreApiService.exploreVenues(
      lat: near?.latitude,
      lng: near?.longitude,
      city: city,
      area: area,
      date: _dateFor(filter),
      from: filter.timeWindow?.from,
      to: filter.timeWindow?.to,
      maxPrice: filter.maxPrice,
      pitchType: filter.pitchType,
      surface: filter.surface,
      facilities: _facilities(filter),
      sort: filter.sort == ExploreSortOption.distance && near == null
          ? ExploreSortOption.popularity.serverName
          : filter.sort.serverName,
      page: page,
      pageSize: pageSize,
    ),
  );

  @override
  Future<ApiResult<MapSearchResultModel>> mapVenues({
    required MapBoundsModel bounds,
    ExploreFilterModel filter = const ExploreFilterModel(),
  }) => _guard(
    () => exploreApiService.mapVenues(
      south: bounds.south,
      west: bounds.west,
      north: bounds.north,
      east: bounds.east,
      date: _dateFor(filter),
      from: filter.timeWindow?.from,
      to: filter.timeWindow?.to,
      maxPrice: filter.maxPrice,
      pitchType: filter.pitchType,
      surface: filter.surface,
      facilities: _facilities(filter),
    ),
  );

  @override
  Future<ApiResult<VenueDetailsModel>> getVenueDetails(String venueId) async {
    try {
      final response = await exploreApiService.getVenueDetails(venueId);
      return ApiResult.success(response);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<List<PitchDetailsModel>>> getVenuePitches(
    String venueId,
  ) async {
    try {
      final response = await exploreApiService.getVenuePitches(venueId);
      return ApiResult.success(response);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<VenueAvailabilityModel>> getVenueAvailability(
    String venueId,
    String date,
  ) async {
    try {
      final response = await exploreApiService.getVenueAvailability(
        venueId,
        date,
      );
      return ApiResult.success(response);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<List<ExploreVenueCardModel>>> getFavorites() async {
    try {
      return ApiResult.success(await exploreApiService.getFavorites());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> setFavorite(
    String venueId, {
    required bool favorite,
  }) async {
    try {
      favorite
          ? await exploreApiService.addFavorite(venueId)
          : await exploreApiService.removeFavorite(venueId);
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<List<ExploreVenueCardModel>>> getRecentlyViewed() =>
      _guard(exploreApiService.getRecentlyViewed);

  @override
  Future<ApiResult<void>> recordView(String venueId) =>
      _guard(() => exploreApiService.recordView(venueId));

  @override
  Future<ApiResult<void>> clearRecentlyViewed() =>
      _guard(exploreApiService.clearRecentlyViewed);
}
