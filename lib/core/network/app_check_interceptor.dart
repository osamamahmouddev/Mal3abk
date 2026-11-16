import 'package:dio/dio.dart';

import '../security/app_attestation_provider.dart';

/// Adds the App Check token to calls to our own API only. Upload tickets can
/// point at object storage, which must never receive it.
class AppCheckInterceptor extends Interceptor {
  AppCheckInterceptor({required this.attestationProvider});

  final AppAttestationProvider attestationProvider;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isOwnApi(options)) {
      final token = await attestationProvider.getAttestationToken();
      if (token != null) {
        options.headers[AppAttestationProvider.headerName] = token;
      }
    }
    handler.next(options);
  }

  bool _isOwnApi(RequestOptions options) {
    final base = Uri.tryParse(options.baseUrl);
    final target = options.uri;
    return base != null &&
        base.host.isNotEmpty &&
        target.scheme == base.scheme &&
        target.host == base.host &&
        target.port == base.port;
  }
}
