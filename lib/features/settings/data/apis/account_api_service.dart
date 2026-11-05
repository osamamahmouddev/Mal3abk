import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/consents_model.dart';
import '../models/language_request_body.dart';
import '../models/record_consent_request_body.dart';
import '../models/session_model.dart';

part 'account_api_service.g.dart';

@RestApi()
abstract class AccountApiService {
  factory AccountApiService(Dio dio, {String? baseUrl}) = _AccountApiService;

  @GET(ApiConstants.sessions)
  Future<List<SessionModel>> getSessions();

  @DELETE(ApiConstants.session)
  Future<void> revokeSession(@Path('id') String sessionId);

  @POST(ApiConstants.revokeOtherSessions)
  Future<void> revokeOtherSessions();

  @GET(ApiConstants.consents)
  Future<ConsentsModel> getConsents();

  @POST(ApiConstants.consents)
  Future<ConsentsModel> recordConsent(@Body() RecordConsentRequestBody body);

  @PUT(ApiConstants.language)
  Future<void> setLanguage(@Body() LanguageRequestBody body);

  @GET(ApiConstants.dataExport)
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> exportData(
    @Header(ApiConstants.stepUpTokenHeader) String stepUpToken,
  );

  @DELETE(ApiConstants.me)
  Future<void> deleteAccount(
    @Header(ApiConstants.stepUpTokenHeader) String stepUpToken,
  );
}
