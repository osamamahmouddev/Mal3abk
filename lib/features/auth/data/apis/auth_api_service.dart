import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/firebase_auth_request_body.dart';
import '../models/logout_request_body.dart';
import '../models/send_otp_request_body.dart';
import '../models/send_otp_response_model.dart';
import '../models/verify_otp_request_body.dart';
import '../models/verify_otp_response_model.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String? baseUrl}) = _AuthApiService;

  @POST(ApiConstants.sendOtp)
  Future<SendOtpResponseModel> sendOtp(@Body() SendOtpRequestBody body);

  @POST(ApiConstants.verifyOtp)
  Future<VerifyOtpResponseModel> verifyOtp(@Body() VerifyOtpRequestBody body);

  @POST(ApiConstants.firebaseAuth)
  Future<VerifyOtpResponseModel> firebaseAuth(
    @Body() FirebaseAuthRequestBody body,
  );

  @POST(ApiConstants.logout)
  Future<void> logout(@Body() LogoutRequestBody body);

  @POST(ApiConstants.logoutAll)
  Future<void> logoutAll();
}
