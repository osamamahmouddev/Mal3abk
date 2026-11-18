import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/config/env_config.dart';

void main() {
  tearDown(() => debugDefaultTargetPlatformOverride = null);

  group('DevEnvConfig (the local API)', () {
    test('uses the emulator host alias on Android', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      expect(const DevEnvConfig().baseUrl, 'http://10.0.2.2:5000');
    });

    test('uses the host loopback on iOS', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      expect(const DevEnvConfig().baseUrl, 'http://127.0.0.1:5000');
    });

    test('is a debug environment named dev', () {
      expect(const DevEnvConfig().envName, 'dev');
      expect(const DevEnvConfig().isDebug, isTrue);
    });
  });

  group('ProdEnvConfig (the live server)', () {
    test('points at the live server, never at the local API', () {
      expect(const ProdEnvConfig().baseUrl, 'http://mal3abk.runasp.net');
      expect(const ProdEnvConfig().baseUrl, isNot(contains('10.0.2.2')));
      expect(const ProdEnvConfig().baseUrl, isNot(contains('127.0.0.1')));
    });

    test('points at the remote host', () {
      expect(const ProdEnvConfig().baseUrl, contains('mal3abk.runasp.net'));
    });

    test('is not a debug environment and is named prod', () {
      expect(const ProdEnvConfig().envName, 'prod');
      expect(const ProdEnvConfig().isDebug, isFalse);
    });
  });
}
