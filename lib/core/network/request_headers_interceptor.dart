import 'package:dio/dio.dart';

import '../app/app_locale.dart';
import '../device/device_identity_provider.dart';
import '../local_storage/device_id_storage.dart';

/// Adds the locale (`X-Locale` + `Accept-Language`), the per-install device
/// id, and the device name and app user agent shown in the player's list of
/// signed-in devices.
class RequestHeadersInterceptor extends Interceptor {
  RequestHeadersInterceptor({
    required this.deviceIdStorage,
    this.deviceIdentityProvider,
  });

  static const String localeHeader = 'X-Locale';
  static const String deviceIdHeader = 'X-Device-Id';
  static const String deviceNameHeader = 'X-Device-Name';
  static const String userAgentHeader = 'User-Agent';

  final DeviceIdStorage deviceIdStorage;
  final DeviceIdentityProvider? deviceIdentityProvider;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isOwnApi(options)) {
      try {
        final language = AppLocale.currentLanguage;
        options.headers[localeHeader] = language;
        options.headers['Accept-Language'] = language;
        options.headers[deviceIdHeader] = await deviceIdStorage.readDeviceId();
        final identity = await deviceIdentityProvider?.read();
        if (identity != null) {
          options.headers[userAgentHeader] = identity.userAgent;
          if (identity.name != null) {
            options.headers[deviceNameHeader] = identity.name;
          }
        }
      } catch (_) {
        // Proceed safely even if reading local device info/storage encounters an error
      }
    }
    handler.next(options);
  }

  bool _isOwnApi(RequestOptions options) {
    final base = Uri.tryParse(options.baseUrl);
    final target = options.uri;
    return base != null &&
        target.scheme == base.scheme &&
        target.host == base.host &&
        target.port == base.port;
  }
}
