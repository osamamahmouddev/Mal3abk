import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/complete_profile_request_body.dart';
import '../models/my_profile_model.dart';

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
}
