import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/email_request_body.dart';
import '../models/owner_login_request_body.dart';
import '../models/owner_login_response_model.dart';
import '../models/register_owner_request_body.dart';

part 'venue_auth_api_service.g.dart';

/// Email + password accounts of venue owners and staff, the same endpoints the
/// venue web dashboard uses.
@RestApi()
abstract class VenueAuthApiService {
  factory VenueAuthApiService(Dio dio, {String? baseUrl}) =
      _VenueAuthApiService;

  @POST(ApiConstants.ownerLogin)
  Future<OwnerLoginResponseModel> login(@Body() OwnerLoginRequestBody body);

  @POST(ApiConstants.registerVenueOwner)
  Future<void> registerOwner(@Body() RegisterOwnerRequestBody body);

  @POST(ApiConstants.resendVerificationEmail)
  Future<void> resendVerification(@Body() EmailRequestBody body);

  @POST(ApiConstants.forgotPassword)
  Future<void> forgotPassword(@Body() EmailRequestBody body);
}
