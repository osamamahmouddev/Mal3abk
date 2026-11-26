import '../../../../core/local_storage/auth_token_storage.dart';
import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/turnstile_token_provider.dart';
import '../../../../core/services/push_notification_service.dart';
import '../../../../core/services/realtime_service.dart';
import '../../domain/repos/venue_auth_repo.dart';
import '../apis/venue_auth_api_service.dart';
import '../models/email_request_body.dart';
import '../models/owner_login_request_body.dart';
import '../models/register_owner_request_body.dart';

class VenueAuthRepoImpl implements VenueAuthRepo {
  VenueAuthRepoImpl({
    required this.apiService,
    required this.tokenStorage,
    required this.turnstileTokenProvider,
    this.pushNotificationService,
    this.realtimeService,
  });

  final VenueAuthApiService apiService;
  final AuthTokenStorage tokenStorage;
  final TurnstileTokenProvider turnstileTokenProvider;
  final PushNotificationService? pushNotificationService;
  final RealtimeService? realtimeService;

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> login({
    required String email,
    required String password,
    String? totpCode,
  }) => _guard(() async {
    // The API asks for the security check only after repeated failures; the
    // token is sent every time so that case needs no second round trip.
    final turnstileToken = await turnstileTokenProvider.getToken();
    final response = await apiService.login(
      OwnerLoginRequestBody(
        email: email.trim(),
        password: password,
        totpCode: (totpCode?.trim().isEmpty ?? true) ? null : totpCode!.trim(),
        turnstileToken: turnstileToken.isEmpty ? null : turnstileToken,
      ),
    );
    await tokenStorage.saveTokens(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
      isVenueSession: true,
    );
    try {
      await realtimeService?.disconnect();
    } catch (_) {}
    try {
      await pushNotificationService?.syncPushToken();
    } catch (_) {}
  });

  @override
  Future<ApiResult<void>> registerOwner(RegisterOwnerRequestBody body) =>
      _guard(() => apiService.registerOwner(body));

  @override
  Future<ApiResult<void>> resendVerification(String email) => _guard(
    () => apiService.resendVerification(EmailRequestBody(email: email.trim())),
  );

  @override
  Future<ApiResult<void>> forgotPassword(String email) => _guard(
    () => apiService.forgotPassword(EmailRequestBody(email: email.trim())),
  );
}
