import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/app/app_locale.dart';
import 'package:mal3abk/core/device/device_identity_provider.dart';
import 'package:mal3abk/core/local_storage/device_id_storage.dart';
import 'package:mal3abk/core/network/request_headers_interceptor.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fake_http_adapter.dart';

class MockDeviceIdStorage extends Mock implements DeviceIdStorage {}

class MockDeviceIdentityProvider extends Mock
    implements DeviceIdentityProvider {}

void main() {
  late MockDeviceIdStorage deviceIdStorage;
  late FakeHttpAdapter adapter;
  late Dio dio;

  setUp(() {
    deviceIdStorage = MockDeviceIdStorage();
    when(() => deviceIdStorage.readDeviceId()).thenAnswer((_) async => 'dev-1');
    adapter = FakeHttpAdapter((_) => FakeHttpAdapter.json(200, {}));
    dio = Dio(BaseOptions(baseUrl: 'http://api.test'))
      ..httpClientAdapter = adapter
      ..interceptors.add(
        RequestHeadersInterceptor(deviceIdStorage: deviceIdStorage),
      );
  });

  tearDown(() => AppLocale.update('ar'));

  group('RequestHeadersInterceptor', () {
    test('sends the current locale in X-Locale and Accept-Language', () async {
      AppLocale.update('en');

      await dio.get<dynamic>('/ping');

      final headers = adapter.requests.single.headers;
      expect(headers['X-Locale'], 'en');
      expect(headers['Accept-Language'], 'en');
    });

    test('sends the per-install device id', () async {
      await dio.get<dynamic>('/ping');

      expect(adapter.requests.single.headers['X-Device-Id'], 'dev-1');
    });

    test('names the device and the app for the sessions list', () async {
      final identity = MockDeviceIdentityProvider();
      when(identity.read).thenAnswer(
        (_) async => const DeviceIdentity(
          name: 'Samsung SM-S911B',
          userAgent: 'Malabak/1.0.0 (Android 14)',
        ),
      );
      dio.interceptors
        ..clear()
        ..add(
          RequestHeadersInterceptor(
            deviceIdStorage: deviceIdStorage,
            deviceIdentityProvider: identity,
          ),
        );

      await dio.get<dynamic>('/ping');

      final headers = adapter.requests.single.headers;
      expect(headers['X-Device-Name'], 'Samsung SM-S911B');
      expect(headers['User-Agent'], 'Malabak/1.0.0 (Android 14)');
    });
  });
}
