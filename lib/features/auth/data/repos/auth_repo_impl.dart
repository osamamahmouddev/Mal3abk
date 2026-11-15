import '../../../../core/local_storage/auth_token_storage.dart';
import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/turnstile_token_provider.dart';
import '../../../../core/services/push_notification_service.dart';
import '../../domain/repos/auth_repo.dart';
import '../apis/auth_api_service.dart';
import '../models/logout_request_body.dart';
import '../models/send_otp_request_body.dart';
import '../models/send_otp_response_model.dart';
import '../models/verify_otp_request_body.dart';
import '../models/verify_otp_response_model.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({
    required this.authApiService,
    required this.tokenStorage,
    required this.turnstileTokenProvider,
    this.pushNotificationService,
  });

  final AuthApiService authApiService;
  final AuthTokenStorage tokenStorage;
  final TurnstileTokenProvider turnstileTokenProvider;
  final PushNotificationService? pushNotificationService;

  @override
  Future<ApiResult<SendOtpResponseModel>> sendOtp(String phoneNumber) async {
    try {
      final turnstileToken = await turnstileTokenProvider.getToken();
      final response = await authApiService.sendOtp(
        SendOtpRequestBody(
          phoneNumber: phoneNumber,
          turnstileToken: turnstileToken,
        ),
      );
      return ApiResult.success(response);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<VerifyOtpResponseModel>> verifyOtp(
    VerifyOtpRequestBody body,
  ) async {
    try {
      final response = await authApiService.verifyOtp(body);
      return ApiResult.success(response);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> saveSession({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      await tokenStorage.saveTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
      try {
        await pushNotificationService?.syncPushToken();
      } catch (_) {}
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> logout() async {
    try {
      try {
        await pushNotificationService?.unregisterPushToken();
      } catch (_) {}
      final refreshToken = await tokenStorage.readRefreshToken();
      if (refreshToken.isNotEmpty) {
        await authApiService.logout(
          LogoutRequestBody(refreshToken: refreshToken),
        );
      }
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> logoutAll() async {
    try {
      try {
        await pushNotificationService?.unregisterPushToken();
      } catch (_) {}
      await authApiService.logoutAll();
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> clearSession() async {
    try {
      try {
        await pushNotificationService?.unregisterPushToken();
      } catch (_) {}
      await tokenStorage.clear();
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }
}
