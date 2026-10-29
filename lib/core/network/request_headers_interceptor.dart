import 'package:dio/dio.dart';

import '../app/app_locale.dart';
import '../local_storage/device_id_storage.dart';

/// Adds the locale (`X-Locale` + `Accept-Language`) and the per-install
/// device id to every request.
class RequestHeadersInterceptor extends Interceptor {
  RequestHeadersInterceptor({required this.deviceIdStorage});

  static const String localeHeader = 'X-Locale';
  static const String deviceIdHeader = 'X-Device-Id';

  final DeviceIdStorage deviceIdStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final language = AppLocale.currentLanguage;
    options.headers[localeHeader] = language;
    options.headers['Accept-Language'] = language;
    options.headers[deviceIdHeader] = await deviceIdStorage.readDeviceId();
    handler.next(options);
  }
}
