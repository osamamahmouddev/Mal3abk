import 'package:dio/dio.dart';

import '../local_storage/auth_token_storage.dart';
import '../utils/app_logger.dart';
import 'api_constants.dart';
import 'models/refresh_token_request_body.dart';
import 'token_refresh_api_service.dart';

/// Attaches the access token and, on a 401, rotates the refresh token once
/// and replays the request. Concurrent 401s share one refresh call
/// (single flight). When the refresh token is rejected the session is
/// cleared and [onSessionExpired] runs.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.dio,
    required this.tokenStorage,
    required this.tokenRefreshApiService,
    required this.onSessionExpired,
  });

  static const String _retriedKey = 'auth_retried';
  static const String _authorizationHeader = 'Authorization';

  final Dio dio;
  final AuthTokenStorage tokenStorage;
  final TokenRefreshApiService tokenRefreshApiService;
  final void Function() onSessionExpired;

  Future<String?>? _refreshInFlight;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!_isAnonymous(options) && _isOwnApi(options)) {
      final accessToken = await tokenStorage.readAccessToken();
      if (accessToken.isNotEmpty) {
        options.headers[_authorizationHeader] = 'Bearer $accessToken';
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final canRefresh =
        err.response?.statusCode == 401 &&
        !_isAnonymous(options) &&
        _isOwnApi(options) &&
        options.extra[_retriedKey] != true;
    if (!canRefresh) {
      handler.next(err);
      return;
    }

    final accessToken = await _freshAccessToken(
      options.headers[_authorizationHeader],
    );
    if (accessToken == null) {
      handler.next(err);
      return;
    }

    options.headers[_authorizationHeader] = 'Bearer $accessToken';
    options.extra[_retriedKey] = true;
    try {
      handler.resolve(await dio.fetch<dynamic>(options));
    } on DioException catch (retryError) {
      handler.next(retryError);
    } catch (e) {
      handler.reject(DioException(requestOptions: options, error: e));
    }
  }

  /// The session token only ever goes to the API itself. Upload tickets can
  /// point at another host (object storage); that host must never see it.
  bool _isOwnApi(RequestOptions options) {
    final base = Uri.tryParse(options.baseUrl);
    final target = options.uri;
    return base != null &&
        target.scheme == base.scheme &&
        target.host == base.host &&
        target.port == base.port;
  }

  bool _isAnonymous(RequestOptions options) {
    return ApiConstants.anonymousPaths.contains(options.path);
  }

  Future<String?> _freshAccessToken(Object? failedAuthorization) async {
    // Another request already rotated the token after this one was sent.
    final currentToken = await tokenStorage.readAccessToken();
    if (currentToken.isNotEmpty &&
        failedAuthorization != 'Bearer $currentToken') {
      return currentToken;
    }

    return _refreshInFlight ??= _refresh().whenComplete(
      () => _refreshInFlight = null,
    );
  }

  Future<String?> _refresh() async {
    final refreshToken = await tokenStorage.readRefreshToken();
    if (refreshToken.isEmpty) return null;

    try {
      final tokens = await tokenRefreshApiService.refresh(
        RefreshTokenRequestBody(refreshToken: refreshToken),
      );
      await tokenStorage.saveTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );
      AppLogger.i('Access token refreshed');
      return tokens.accessToken;
    } on DioException catch (error) {
      final statusCode = error.response?.statusCode;
      // Offline or server errors keep the session; a rejected token ends it.
      if (statusCode == 400 || statusCode == 401) {
        AppLogger.w('Refresh token rejected ($statusCode); session cleared');
        await tokenStorage.clear();
        onSessionExpired();
      }
      return null;
    } catch (error, stackTrace) {
      AppLogger.e(
        'Token refresh failed',
        error: error.runtimeType,
        stackTrace: stackTrace,
      );
      return null;
    }
  }
}
