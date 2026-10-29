import 'package:dio/dio.dart';

import '../utils/app_logger.dart';

/// Logs method, path, status and duration only. Headers, query strings and
/// bodies are never logged: they carry tokens, OTP codes and phone numbers.
class ApiLoggingInterceptor extends Interceptor {
  ApiLoggingInterceptor();

  static const String _startedAtKey = 'log_started_at';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startedAtKey] = DateTime.now();
    AppLogger.d('→ ${options.method} ${options.uri.path}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final options = response.requestOptions;
    AppLogger.d(
      '← ${response.statusCode} ${options.method} ${options.uri.path} '
      '(${_elapsedMs(options)} ms)',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    AppLogger.w(
      '✗ ${err.response?.statusCode ?? err.type.name} ${options.method} '
      '${options.uri.path} (${_elapsedMs(options)} ms)',
    );
    handler.next(err);
  }

  int _elapsedMs(RequestOptions options) {
    final startedAt = options.extra[_startedAtKey];
    if (startedAt is! DateTime) return 0;
    return DateTime.now().difference(startedAt).inMilliseconds;
  }
}
