import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../../../booking/data/models/upload_ticket_model.dart';
import '../../../venue_calendar/data/models/operating_schedule_model.dart';
import '../../../venue_overview/data/models/venue_approval_model.dart';
import '../../../venue_shell/data/models/venue_model.dart';
import '../../../venue_shell/data/models/venue_pitch_model.dart';

part 'venue_setup_api_service.g.dart';

/// Creating and editing a venue, its pitches, photos and hours, and sending
/// it to the platform for review.
@RestApi()
abstract class VenueSetupApiService {
  factory VenueSetupApiService(Dio dio, {String? baseUrl}) =
      _VenueSetupApiService;

  @POST(ApiConstants.managedVenues)
  Future<VenueModel> createVenue(@Body() Map<String, dynamic> body);

  @PUT(ApiConstants.managedVenue)
  Future<VenueModel> updateVenue(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );

  @GET(ApiConstants.managedVenuePitches)
  Future<List<VenuePitchModel>> getPitches(@Path('venueId') String venueId);

  @POST(ApiConstants.managedVenuePitches)
  Future<VenuePitchModel> createPitch(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(ApiConstants.managedPitch)
  Future<void> deletePitch(@Path('pitchId') String pitchId);

  @POST(ApiConstants.venueGallery)
  Future<void> addVenuePhoto(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(ApiConstants.venueGalleryItem)
  Future<void> removeVenuePhoto(
    @Path('venueId') String venueId,
    @Path('mediaId') String mediaId,
  );

  @POST(ApiConstants.pitchGallery)
  Future<void> addPitchPhoto(
    @Path('venueId') String venueId,
    @Path('pitchId') String pitchId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(ApiConstants.pitchGalleryItem)
  Future<void> removePitchPhoto(
    @Path('venueId') String venueId,
    @Path('pitchId') String pitchId,
    @Path('mediaId') String mediaId,
  );

  @GET(ApiConstants.venueSchedules)
  Future<List<OperatingScheduleModel>> getSchedules(
    @Path('venueId') String venueId,
  );

  @PUT(ApiConstants.venueSchedules)
  Future<List<OperatingScheduleModel>> saveSchedules(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );

  @GET(ApiConstants.venueApproval)
  Future<VenueApprovalModel> getApproval(@Path('venueId') String venueId);

  @POST(ApiConstants.venueApprovalSubmit)
  Future<VenueApprovalModel> submitForReview(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.mediaUploads)
  Future<UploadTicketModel> createUpload(@Body() Map<String, dynamic> body);
}
