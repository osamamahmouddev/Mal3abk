import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';

part 'venue_account_api_service.g.dart';

/// The owner's own account: name, email, mobile, password and two-factor
/// sign-in, as the venue web settings page uses them.
@RestApi()
abstract class VenueAccountApiService {
  factory VenueAccountApiService(Dio dio, {String? baseUrl}) =
      _VenueAccountApiService;

  @GET(ApiConstants.myProfile)
  Future<dynamic> getMe();

  @PATCH(ApiConstants.myProfile)
  Future<void> updateName(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.changePassword)
  Future<void> changePassword(@Body() Map<String, dynamic> body);

  /// Answers `{secret, provisioningUri}`.
  @POST(ApiConstants.totpEnroll)
  Future<dynamic> enrollTotp();

  @POST(ApiConstants.totpConfirm)
  Future<void> confirmTotp(@Body() Map<String, dynamic> body);

  /// Answers `{stepUpToken}`.
  @POST(ApiConstants.stepUp)
  Future<dynamic> stepUp(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.emailChangeStart)
  Future<void> startEmailChange(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.emailChangeConfirm)
  Future<void> confirmEmailChange(@Body() Map<String, dynamic> body);

  /// Answers `{requestId}`.
  @POST(ApiConstants.startPhoneChange)
  Future<dynamic> startPhoneChange(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.verifyOldPhone)
  Future<void> verifyOldPhone(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.verifyNewPhone)
  Future<void> verifyNewPhone(@Body() Map<String, dynamic> body);
}
