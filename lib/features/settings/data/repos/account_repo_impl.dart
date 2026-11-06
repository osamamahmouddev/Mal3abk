import 'dart:typed_data';

import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/account_repo.dart';
import '../apis/account_api_service.dart';
import '../models/consents_model.dart';
import '../models/language_request_body.dart';
import '../models/record_consent_request_body.dart';
import '../models/session_model.dart';

class AccountRepoImpl implements AccountRepo {
  AccountRepoImpl({required this.accountApiService});

  final AccountApiService accountApiService;

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<List<SessionModel>>> getSessions() =>
      _guard(accountApiService.getSessions);

  @override
  Future<ApiResult<void>> revokeSession(String sessionId) =>
      _guard(() => accountApiService.revokeSession(sessionId));

  @override
  Future<ApiResult<void>> revokeOtherSessions() =>
      _guard(accountApiService.revokeOtherSessions);

  @override
  Future<ApiResult<ConsentsModel>> getConsents() =>
      _guard(accountApiService.getConsents);

  @override
  Future<ApiResult<ConsentsModel>> recordConsent(
    ConsentType type, {
    required bool granted,
  }) => _guard(
    () => accountApiService.recordConsent(
      RecordConsentRequestBody(type: type, granted: granted),
    ),
  );

  @override
  Future<ApiResult<void>> setLanguage(String languageCode) => _guard(
    () => accountApiService.setLanguage(
      LanguageRequestBody(language: languageCode),
    ),
  );

  @override
  Future<ApiResult<Uint8List>> exportData({required String stepUpToken}) =>
      _guard(() async {
        final response = await accountApiService.exportData(stepUpToken);
        return Uint8List.fromList(response.data);
      });

  @override
  Future<ApiResult<void>> deleteAccount({required String stepUpToken}) =>
      _guard(() => accountApiService.deleteAccount(stepUpToken));
}
