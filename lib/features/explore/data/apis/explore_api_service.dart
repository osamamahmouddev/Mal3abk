import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/explore_result_model.dart';
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
}
