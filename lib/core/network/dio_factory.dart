import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/env_config.dart';
import '../device/device_identity_provider.dart';
import '../local_storage/device_id_storage.dart';
import '../security/app_attestation_provider.dart';
import 'api_logging_interceptor.dart';
import 'app_check_interceptor.dart';
import 'request_headers_interceptor.dart';

class DioFactory {
  DioFactory._();

  static const Duration _timeout = Duration(seconds: 30);

  /// Base client: JSON, timeouts, locale + device headers, App Check token
  /// and safe logging.
  /// `AuthInterceptor` is added on top in the service locator.
  static Dio createDio({
    required EnvConfig envConfig,
    required DeviceIdStorage deviceIdStorage,
    DeviceIdentityProvider? deviceIdentityProvider,
    AppAttestationProvider? attestationProvider,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: envConfig.baseUrl,
        connectTimeout: _timeout,
        sendTimeout: _timeout,
        receiveTimeout: _timeout,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      RequestHeadersInterceptor(
        deviceIdStorage: deviceIdStorage,
        deviceIdentityProvider: deviceIdentityProvider,
      ),
    );
    if (attestationProvider != null) {
      dio.interceptors.add(
        AppCheckInterceptor(attestationProvider: attestationProvider),
      );
    }
    if (kDebugMode) {
      dio.interceptors.add(ApiLoggingInterceptor());
    }
    return dio;
  }
}
