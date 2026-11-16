import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_constants.dart';
import 'package:mal3abk/core/network/auth_interceptor.dart';
import 'package:mal3abk/core/network/models/auth_tokens_model.dart';
import 'package:mal3abk/core/network/models/refresh_token_request_body.dart';
import 'package:mal3abk/core/network/token_refresh_api_service.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/dio_errors.dart';
import '../../helpers/fake_auth_token_storage.dart';
import '../../helpers/fake_http_adapter.dart';

class MockTokenRefreshApiService extends Mock
    implements TokenRefreshApiService {}

const _protectedPath = ApiConstants.logoutAll;
const _newTokens = AuthTokensModel(
  accessToken: 'access-2',
  refreshToken: 'refresh-2',
  expiresIn: 900,
);

void main() {
  late FakeAuthTokenStorage tokenStorage;
  late MockTokenRefreshApiService refreshApi;
  late FakeHttpAdapter adapter;
  late Dio dio;
  late int sessionExpiredCount;

  /// The fake API accepts only `access-2`.
  ResponseBody acceptsNewToken(RequestOptions options) {
    final authorized = options.headers['Authorization'] == 'Bearer access-2';
    return FakeHttpAdapter.json(authorized ? 200 : 401, {'ok': authorized});
  }

  setUpAll(() {
    registerFallbackValue(const RefreshTokenRequestBody(refreshToken: ''));
  });

  setUp(() {
    tokenStorage = FakeAuthTokenStorage(
      accessToken: 'access-1',
      refreshToken: 'refresh-1',
    );
    refreshApi = MockTokenRefreshApiService();
    adapter = FakeHttpAdapter(acceptsNewToken);
    sessionExpiredCount = 0;
    dio = Dio(BaseOptions(baseUrl: 'http://api.test'))
      ..httpClientAdapter = adapter;
    dio.interceptors.add(
      AuthInterceptor(
        dio: dio,
        tokenStorage: tokenStorage,
        tokenRefreshApiService: refreshApi,
        onSessionExpired: () => sessionExpiredCount++,
      ),
    );
  });

  group('AuthInterceptor.onRequest', () {
    test('attaches the access token to protected endpoints', () async {
      adapter = FakeHttpAdapter((_) => FakeHttpAdapter.json(200, {}));
      dio.httpClientAdapter = adapter;

      await dio.post<dynamic>(_protectedPath);

      expect(
        adapter.requests.single.headers['Authorization'],
        'Bearer access-1',
      );
    });

    test('never sends the token to another host (upload storage)', () async {
      adapter = FakeHttpAdapter((_) => FakeHttpAdapter.json(200, {}));
      dio.httpClientAdapter = adapter;

      await dio.put<dynamic>('https://storage.example.com/upload/abc?sig=1');

      expect(adapter.requests.single.headers['Authorization'], isNull);
    });

    test(
      'never sends the token to the same host on another scheme or port',
      () async {
        adapter = FakeHttpAdapter((_) => FakeHttpAdapter.json(200, {}));
        dio.httpClientAdapter = adapter;

        await dio.get<dynamic>('https://api.test/x');
        await dio.get<dynamic>('http://api.test:8080/x');

        for (final request in adapter.requests) {
          expect(request.headers['Authorization'], isNull);
        }
      },
    );

    test('an absolute url on the api host still gets the token', () async {
      adapter = FakeHttpAdapter((_) => FakeHttpAdapter.json(200, {}));
      dio.httpClientAdapter = adapter;

      await dio.put<dynamic>('http://api.test/api/v1/media/uploads/1');

      expect(
        adapter.requests.single.headers['Authorization'],
        'Bearer access-1',
      );
    });

    test('a 401 from another host does not trigger a token refresh', () async {
      adapter = FakeHttpAdapter((_) => FakeHttpAdapter.json(401, {}));
      dio.httpClientAdapter = adapter;

      await expectLater(
        dio.put<dynamic>('https://storage.example.com/upload/abc'),
        throwsA(isA<DioException>()),
      );
      verifyNever(() => refreshApi.refresh(any()));
    });

    test('does not attach a token to anonymous endpoints', () async {
      adapter = FakeHttpAdapter((_) => FakeHttpAdapter.json(200, {}));
      dio.httpClientAdapter = adapter;

      await dio.post<dynamic>(ApiConstants.sendOtp);

      expect(adapter.requests.single.headers['Authorization'], isNull);
    });
  });

  group('AuthInterceptor.onError', () {
    test('refreshes on 401, stores the rotated tokens and replays', () async {
      when(() => refreshApi.refresh(any())).thenAnswer((_) async => _newTokens);

      final response = await dio.post<dynamic>(_protectedPath);

      expect(response.statusCode, 200);
      expect(tokenStorage.accessToken, 'access-2');
      expect(tokenStorage.refreshToken, 'refresh-2');
      final body = verify(() => refreshApi.refresh(captureAny())).captured;
      expect(
        (body.single as RefreshTokenRequestBody).refreshToken,
        'refresh-1',
      );
    });

    test('shares one refresh between concurrent 401s', () async {
      final refreshGate = Completer<AuthTokensModel>();
      when(
        () => refreshApi.refresh(any()),
      ).thenAnswer((_) => refreshGate.future);

      final requests = [
        dio.post<dynamic>(_protectedPath),
        dio.post<dynamic>(_protectedPath),
        dio.post<dynamic>(_protectedPath),
      ];
      await Future<void>.delayed(Duration.zero);
      refreshGate.complete(_newTokens);
      final responses = await Future.wait(requests);

      expect(responses.map((r) => r.statusCode), everyElement(200));
      verify(() => refreshApi.refresh(any())).called(1);
    });

    test('ends the session when the refresh token is rejected', () async {
      when(() => refreshApi.refresh(any())).thenThrow(badResponse(401));

      await expectLater(
        dio.post<dynamic>(_protectedPath),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'status',
            401,
          ),
        ),
      );
      expect(tokenStorage.clearCount, 1);
      expect(sessionExpiredCount, 1);
    });

    test('keeps the session when the refresh fails offline', () async {
      when(() => refreshApi.refresh(any())).thenThrow(
        DioException.connectionError(
          requestOptions: RequestOptions(path: ApiConstants.refreshToken),
          reason: 'offline',
        ),
      );

      await expectLater(
        dio.post<dynamic>(_protectedPath),
        throwsA(isA<DioException>()),
      );
      expect(tokenStorage.clearCount, 0);
      expect(sessionExpiredCount, 0);
    });

    test('replays only once when the new token is also rejected', () async {
      adapter = FakeHttpAdapter((_) => FakeHttpAdapter.json(401, {}));
      dio.httpClientAdapter = adapter;
      when(() => refreshApi.refresh(any())).thenAnswer((_) async => _newTokens);

      await expectLater(
        dio.post<dynamic>(_protectedPath),
        throwsA(isA<DioException>()),
      );
      expect(adapter.requests, hasLength(2));
      verify(() => refreshApi.refresh(any())).called(1);
    });

    test('does not refresh when an anonymous endpoint answers 401', () async {
      await expectLater(
        dio.post<dynamic>(ApiConstants.verifyOtp),
        throwsA(isA<DioException>()),
      );
      verifyNever(() => refreshApi.refresh(any()));
    });

    test('does not refresh without a stored session', () async {
      tokenStorage = FakeAuthTokenStorage();
      dio.interceptors
        ..clear()
        ..add(
          AuthInterceptor(
            dio: dio,
            tokenStorage: tokenStorage,
            tokenRefreshApiService: refreshApi,
            onSessionExpired: () => sessionExpiredCount++,
          ),
        );

      await expectLater(
        dio.post<dynamic>(_protectedPath),
        throwsA(isA<DioException>()),
      );
      verifyNever(() => refreshApi.refresh(any()));
      expect(sessionExpiredCount, 0);
    });
  });
}
