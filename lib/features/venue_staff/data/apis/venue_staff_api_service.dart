import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/venue_staff_model.dart';

part 'venue_staff_api_service.g.dart';

@RestApi()
abstract class VenueStaffApiService {
  factory VenueStaffApiService(Dio dio, {String? baseUrl}) =
      _VenueStaffApiService;

  @GET(ApiConstants.venueStaff)
  Future<VenueStaffModel> getStaff(@Path('venueId') String venueId);

  @POST(ApiConstants.venueStaffInvitations)
  Future<void> invite(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.venueStaffInvitationResend)
  Future<void> resendInvitation(
    @Path('venueId') String venueId,
    @Path('invitationId') String invitationId,
  );

  @DELETE(ApiConstants.venueStaffInvitation)
  Future<void> cancelInvitation(
    @Path('venueId') String venueId,
    @Path('invitationId') String invitationId,
  );

  @PUT(ApiConstants.venueStaffMember)
  Future<void> changeRole(
    @Path('venueId') String venueId,
    @Path('memberId') String memberId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(ApiConstants.venueStaffMember)
  Future<void> removeMember(
    @Path('venueId') String venueId,
    @Path('memberId') String memberId,
  );
}
