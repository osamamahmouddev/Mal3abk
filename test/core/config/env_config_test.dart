import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/config/env_config.dart';

void main() {
  group('DevEnvConfig (the staging / dev API)', () {
    test('defaults to the staging server on MonsterASP', () {
      expect(const DevEnvConfig().baseUrl, 'http://mal3abk-staging.runasp.net');
    });

    test('is a debug environment named dev', () {
      expect(const DevEnvConfig().envName, 'dev');
      expect(const DevEnvConfig().isDebug, isTrue);
    });
  });

  group('StagingEnvConfig (the staging server)', () {
    test('defaults to the staging server on MonsterASP', () {
      expect(const StagingEnvConfig().baseUrl, 'http://mal3abk-staging.runasp.net');
    });

    test('is a debug environment named staging', () {
      expect(const StagingEnvConfig().envName, 'staging');
      expect(const StagingEnvConfig().isDebug, isTrue);
    });
  });

  group('ProdEnvConfig (the live server)', () {
    test('points at the live server, never at staging or local API', () {
      expect(const ProdEnvConfig().baseUrl, 'http://mal3abk.runasp.net');
      expect(const ProdEnvConfig().baseUrl, isNot(contains('10.0.2.2')));
      expect(const ProdEnvConfig().baseUrl, isNot(contains('127.0.0.1')));
      expect(const ProdEnvConfig().baseUrl, isNot(contains('staging')));
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
