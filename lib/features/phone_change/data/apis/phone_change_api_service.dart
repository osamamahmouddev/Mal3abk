import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/phone_change_code_request_body.dart';
import '../models/recover_phone_request_body.dart';
import '../models/start_phone_change_request_body.dart';
import '../models/start_phone_change_response_model.dart';
import '../models/verify_new_phone_response_model.dart';

part 'phone_change_api_service.g.dart';

@RestApi()
abstract class PhoneChangeApiService {
  factory PhoneChangeApiService(Dio dio, {String? baseUrl}) =
      _PhoneChangeApiService;

  @POST(ApiConstants.startPhoneChange)
  Future<StartPhoneChangeResponseModel> startPhoneChange(
    @Body() StartPhoneChangeRequestBody body,
  );

  @POST(ApiConstants.verifyOldPhone)
  Future<void> verifyOldPhone(@Body() PhoneChangeCodeRequestBody body);

  @POST(ApiConstants.verifyNewPhone)
  Future<VerifyNewPhoneResponseModel> verifyNewPhone(
    @Body() PhoneChangeCodeRequestBody body,
  );

  @POST(ApiConstants.recoverPhone)
  Future<void> recoverPhone(@Body() RecoverPhoneRequestBody body);
}
