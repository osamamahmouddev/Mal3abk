import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/login_request_body.dart';
import '../models/user_model.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String? baseUrl}) = _AuthApiService;

  @POST(ApiConstants.login)
  Future<UserModel> login(@Body() LoginRequestBody body);

  @POST(ApiConstants.logout)
  Future<void> logout();

  @GET(ApiConstants.profile)
  Future<UserModel> getProfile();
}
