import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/config/env_config.dart';
import 'package:mal3abk/core/di/service_locator.dart';
import 'package:mal3abk/core/utils/media_url.dart';

class _FakeEnvConfig implements EnvConfig {
  @override
  final String baseUrl;
  const _FakeEnvConfig(this.baseUrl);

  @override
  String get envName => 'test';
  @override
  bool get isDebug => true;
  @override
  String get turnstileToken => '';
  @override
  bool get useFirebasePhoneAuth => false;
}

void main() {
  setUp(() async {
    await sl.reset();
  });

  tearDown(() async {
    await sl.reset();
  });

  group('MediaUrl.resolve', () {
    test('returns null for null or empty path', () {
      expect(MediaUrl.resolve(null), isNull);
      expect(MediaUrl.resolve(''), isNull);
    });

    test('returns already-absolute URLs unmodified', () {
      expect(
        MediaUrl.resolve('https://cdn.malabak.com/img.jpg'),
        'https://cdn.malabak.com/img.jpg',
      );
      expect(
        MediaUrl.resolve('http://example.com/img.jpg'),
        'http://example.com/img.jpg',
      );
    });

    test('resolves relative path using explicit baseUrl', () {
      expect(
        MediaUrl.resolve(
          '/api/v1/media/123/medium',
          baseUrl: 'http://10.0.2.2:5000',
        ),
        'http://10.0.2.2:5000/api/v1/media/123/medium',
      );
      expect(
        MediaUrl.resolve(
          '/api/v1/media/123/medium',
          baseUrl: 'http://10.0.2.2:5000/',
        ),
        'http://10.0.2.2:5000/api/v1/media/123/medium',
      );
      expect(
        MediaUrl.resolve(
          'api/v1/media/123/medium',
          baseUrl: 'http://10.0.2.2:5000',
        ),
        'http://10.0.2.2:5000/api/v1/media/123/medium',
      );
    });

    test('resolves relative path using sl<EnvConfig>() when registered', () {
      sl.registerSingleton<EnvConfig>(
        const _FakeEnvConfig('http://10.0.2.2:5000'),
      );

      expect(
        MediaUrl.resolve('/api/v1/media/456/medium'),
        'http://10.0.2.2:5000/api/v1/media/456/medium',
      );
    });

    test('returns relative path as fallback if baseUrl is not registered', () {
      expect(
        MediaUrl.resolve('/api/v1/media/789/medium'),
        '/api/v1/media/789/medium',
      );
    });
  });
}
