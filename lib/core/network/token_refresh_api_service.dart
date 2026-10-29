import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'api_constants.dart';
import 'models/auth_tokens_model.dart';
import 'models/refresh_token_request_body.dart';

part 'token_refresh_api_service.g.dart';

/// Runs on a Dio without `AuthInterceptor`, so a failed refresh can never
/// trigger another refresh.
@RestApi()
abstract class TokenRefreshApiService {
  factory TokenRefreshApiService(Dio dio, {String? baseUrl}) =
      _TokenRefreshApiService;

  @POST(ApiConstants.refreshToken)
  Future<AuthTokensModel> refresh(@Body() RefreshTokenRequestBody body);
}
