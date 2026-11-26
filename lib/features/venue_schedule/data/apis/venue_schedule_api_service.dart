import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../../../venue_calendar/data/models/operating_schedule_model.dart';
import '../models/venue_schedule_models.dart';

part 'venue_schedule_api_service.g.dart';

@RestApi()
abstract class VenueScheduleApiService {
  factory VenueScheduleApiService(Dio dio, {String? baseUrl}) =
      _VenueScheduleApiService;

  @GET(ApiConstants.venueSchedules)
  Future<List<OperatingScheduleModel>> getSchedules(
    @Path('venueId') String venueId,
  );

  @PUT(ApiConstants.venueSchedules)
  Future<void> saveSchedules(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );

  /// Answers `{affectedBookings}`.
  @POST(ApiConstants.venueScheduleImpact)
  Future<dynamic> previewImpact(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );

  @GET(ApiConstants.venueSpecialSchedules)
  Future<SpecialSchedulesModel> getSpecialSchedules(
    @Path('venueId') String venueId,
  );

  @POST(ApiConstants.venueScheduleOverrides)
  Future<void> addOverride(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.venueHolidayClosures)
  Future<void> closeHolidays(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(ApiConstants.venueScheduleOverride)
  Future<void> removeOverride(
    @Path('venueId') String venueId,
    @Path('overrideId') String overrideId, {
    @Query('confirm') bool confirm = true,
  });

  @PUT(ApiConstants.venueBookingRules)
  Future<void> saveRules(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );

  @PUT(ApiConstants.pitchWeeklyHours)
  Future<void> savePitchHours(
    @Path('venueId') String venueId,
    @Path('pitchId') String pitchId,
    @Body() Map<String, dynamic> body,
  );
}
