import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/step_up_request_body.dart';
import '../models/step_up_response_model.dart';

part 'step_up_api_service.g.dart';

@RestApi()
abstract class StepUpApiService {
  factory StepUpApiService(Dio dio, {String? baseUrl}) = _StepUpApiService;

  @POST(ApiConstants.stepUpOtp)
  Future<void> sendCode();

  @POST(ApiConstants.stepUp)
  Future<StepUpResponseModel> verify(@Body() StepUpRequestBody body);
}
