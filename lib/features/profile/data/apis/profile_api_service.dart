import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../../../booking/data/models/upload_ticket_model.dart';
import '../models/avatar_request_body.dart';
import '../models/complete_profile_request_body.dart';
import '../models/create_upload_request_body.dart';
import '../models/my_profile_model.dart';
import '../models/public_player_profile_model.dart';

part 'profile_api_service.g.dart';

@RestApi()
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio, {String? baseUrl}) = _ProfileApiService;

  @GET(ApiConstants.myProfile)
  Future<MyProfileModel> getMyProfile();

  @PUT(ApiConstants.onboardingProfile)
  Future<MyProfileModel> completeProfile(
    @Body() CompleteProfileRequestBody body,
  );

  /// Same fields as onboarding; used to edit a completed profile.
  @PATCH(ApiConstants.myProfile)
  Future<MyProfileModel> updateProfile(@Body() CompleteProfileRequestBody body);

  @GET(ApiConstants.playerProfile)
  Future<PublicPlayerProfileModel> getPlayerProfile(
    @Path('userId') String userId,
  );

  @POST(ApiConstants.mediaUploads)
  Future<UploadTicketModel> createUpload(@Body() CreateUploadRequestBody body);

  @PUT(ApiConstants.myAvatar)
  Future<MyProfileModel> setAvatar(@Body() AvatarRequestBody body);

  @DELETE(ApiConstants.myAvatar)
  Future<MyProfileModel> removeAvatar();
}
