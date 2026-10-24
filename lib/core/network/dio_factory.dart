import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../app/app_locale.dart';
import '../config/env_config.dart';
import '../di/service_locator.dart';
import '../local_storage/secure_storage.dart';

class DioFactory {
  DioFactory._();

  static Dio? _dio;
  static const String _tokenKey = 'auth_token';

  static Dio getDio() {
    if (_dio != null) return _dio!;

    const timeout = Duration(seconds: 30);
    final envConfig = sl<EnvConfig>();

    _dio = Dio(
      BaseOptions(
        baseUrl: envConfig.baseUrl,
        connectTimeout: timeout,
        receiveTimeout: timeout,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SharedPrefHelper.getSecuredString(_tokenKey);
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.headers['Accept-Language'] = AppLocale.currentLanguage;
          return handler.next(options);
        },
      ),
    );

    if (kDebugMode) {
      _dio!.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
        ),
      );
    }

    return _dio!;
  }

  static Future<void> saveToken(String token) async {
    await SharedPrefHelper.setSecuredString(_tokenKey, token);
  }

  static Future<String> getToken() async {
    return SharedPrefHelper.getSecuredString(_tokenKey);
  }

  static Future<void> clearToken() async {
    await SharedPrefHelper.clearAllSecuredData();
  }
}
