import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/explore_result_model.dart';
import '../models/explore_venue_card_model.dart';
import '../models/pitch_details_model.dart';
import '../models/venue_availability_model.dart';
import '../models/venue_details_model.dart';

part 'explore_api_service.g.dart';

@RestApi()
abstract class ExploreApiService {
  factory ExploreApiService(Dio dio, {String? baseUrl}) = _ExploreApiService;

  @GET(ApiConstants.exploreVenues)
  Future<ExploreResultModel> exploreVenues({
    @Query('city') String? city,
    @Query('area') String? area,
    @Query('date') String? date,
    @Query('from') String? from,
    @Query('to') String? to,
    @Query('maxPrice') int? maxPrice,
    @Query('pitchType') String? pitchType,
    @Query('surface') String? surface,
    @Query('facilities') String? facilities,
    @Query('sort') String? sort,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  @GET(ApiConstants.venueDetails)
  Future<VenueDetailsModel> getVenueDetails(@Path('id') String venueId);

  @GET(ApiConstants.venuePitches)
  Future<List<PitchDetailsModel>> getVenuePitches(@Path('id') String venueId);

  @GET(ApiConstants.venueAvailability)
  Future<VenueAvailabilityModel> getVenueAvailability(
    @Path('id') String venueId,
    @Query('date') String date,
  );

  @GET(ApiConstants.favorites)
  Future<List<ExploreVenueCardModel>> getFavorites();

  @PUT(ApiConstants.favorite)
  Future<void> addFavorite(@Path('venueId') String venueId);

  @DELETE(ApiConstants.favorite)
  Future<void> removeFavorite(@Path('venueId') String venueId);

  @GET(ApiConstants.recentlyViewed)
  Future<List<ExploreVenueCardModel>> getRecentlyViewed();

  @POST(ApiConstants.recentlyViewedVenue)
  Future<void> recordView(@Path('venueId') String venueId);

  @DELETE(ApiConstants.recentlyViewed)
  Future<void> clearRecentlyViewed();
}
