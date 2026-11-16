import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/config/env_config.dart';
import 'package:mal3abk/core/network/app_check_interceptor.dart';
import 'package:mal3abk/core/security/app_attestation_provider.dart';

class RecordingHandler extends RequestInterceptorHandler {
  RequestOptions? forwarded;

  @override
  void next(RequestOptions requestOptions) => forwarded = requestOptions;
}

void main() {
  group('AppAttestationProvider', () {
    test('returns the dev token in the dev flavor', () async {
      final provider = AppAttestationProvider(envConfig: const DevEnvConfig());

      expect(
        await provider.getAttestationToken(),
        AppAttestationProvider.devToken,
      );
    });

    test('returns null in prod while App Check is not active', () async {
      final provider = AppAttestationProvider(envConfig: const ProdEnvConfig());

      expect(await provider.getAttestationToken(), isNull);
    });

    test('returns the App Check token in prod', () async {
      final provider = AppAttestationProvider(
        envConfig: const ProdEnvConfig(),
        readToken: () async => 'app-check-token',
      );

      expect(await provider.getAttestationToken(), 'app-check-token');
    });

    test('never throws: a failing token source gives null', () async {
      final provider = AppAttestationProvider(
        envConfig: const ProdEnvConfig(),
        readToken: () async => throw Exception('play integrity down'),
      );

      expect(await provider.getAttestationToken(), isNull);
    });

    test('a slow token source does not hold the request back', () async {
      final provider = AppAttestationProvider(
        envConfig: const ProdEnvConfig(),
        readToken: () => Completer<String?>().future,
      );

      final token = await provider.getAttestationToken();

      expect(token, isNull);
    });
  });

  group('AppCheckInterceptor', () {
    final interceptor = AppCheckInterceptor(
      attestationProvider: AppAttestationProvider(
        envConfig: const ProdEnvConfig(),
        readToken: () async => 'app-check-token',
      ),
    );

    test('adds the token to calls to our API', () async {
      final handler = RecordingHandler();
      await interceptor.onRequest(
        RequestOptions(
          baseUrl: 'https://mal3abk.runasp.net',
          path: '/api/v1/bookings',
        ),
        handler,
      );

      expect(
        handler.forwarded?.headers[AppAttestationProvider.headerName],
        'app-check-token',
      );
    });

    test('never sends the token to another host', () async {
      final handler = RecordingHandler();
      await interceptor.onRequest(
        RequestOptions(
          baseUrl: 'https://mal3abk.runasp.net',
          path: 'https://storage.example.com/upload/abc',
        ),
        handler,
      );

      expect(
        handler.forwarded?.headers.containsKey(
          AppAttestationProvider.headerName,
        ),
        isFalse,
      );
    });
  });
}
