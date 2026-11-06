import 'dart:typed_data';

import '../../../../core/network/api_result.dart';
import '../../data/models/consents_model.dart';
import '../../data/models/record_consent_request_body.dart';
import '../../data/models/session_model.dart';

abstract class AccountRepo {
  Future<ApiResult<List<SessionModel>>> getSessions();

  Future<ApiResult<void>> revokeSession(String sessionId);

  Future<ApiResult<void>> revokeOtherSessions();

  Future<ApiResult<ConsentsModel>> getConsents();

  Future<ApiResult<ConsentsModel>> recordConsent(
    ConsentType type, {
    required bool granted,
  });

  Future<ApiResult<void>> setLanguage(String languageCode);

  /// The player's personal data as a JSON document.
  Future<ApiResult<Uint8List>> exportData({required String stepUpToken});

  Future<ApiResult<void>> deleteAccount({required String stepUpToken});
}
