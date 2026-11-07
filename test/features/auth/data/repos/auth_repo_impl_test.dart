import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/turnstile_token_provider.dart';
import 'package:mal3abk/features/auth/data/apis/auth_api_service.dart';
import 'package:mal3abk/features/auth/data/models/logout_request_body.dart';
import 'package:mal3abk/features/auth/data/models/send_otp_request_body.dart';
import 'package:mal3abk/features/auth/data/models/verify_otp_request_body.dart';
import 'package:mal3abk/features/auth/data/repos/auth_repo_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/auth_fixtures.dart';
import '../../../../helpers/dio_errors.dart';
import '../../../../helpers/fake_auth_token_storage.dart';

class MockAuthApiService extends Mock implements AuthApiService {}

class MockTurnstileTokenProvider extends Mock
    implements TurnstileTokenProvider {}

void main() {
  late MockAuthApiService api;
  late MockTurnstileTokenProvider turnstile;
  late FakeAuthTokenStorage tokenStorage;
  late AuthRepoImpl repo;

  const verifyBody = VerifyOtpRequestBody(
    phoneNumber: testPhoneNumber,
    code: testCode,
  );

  setUpAll(() {
    registerFallbackValue(
      const SendOtpRequestBody(phoneNumber: '', turnstileToken: ''),
    );
    registerFallbackValue(const LogoutRequestBody(refreshToken: ''));
  });

  setUp(() {
    api = MockAuthApiService();
    turnstile = MockTurnstileTokenProvider();
    tokenStorage = FakeAuthTokenStorage(
      accessToken: 'access-1',
      refreshToken: 'refresh-1',
    );
    repo = AuthRepoImpl(
      authApiService: api,
      tokenStorage: tokenStorage,
      turnstileTokenProvider: turnstile,
    );
    when(() => turnstile.getToken()).thenAnswer((_) async => 'turnstile-1');
  });

  group('AuthRepoImpl.sendOtp', () {
    test('sends the phone number with the Turnstile token', () async {
      when(() => api.sendOtp(any())).thenAnswer((_) async => sendOtpResponse);

      final result = await repo.sendOtp(testPhoneNumber);

      expect(result, isSuccessWith(sendOtpResponse));
      final body =
          verify(() => api.sendOtp(captureAny())).captured.single
              as SendOtpRequestBody;
      expect(body.phoneNumber, testPhoneNumber);
      expect(body.turnstileToken, 'turnstile-1');
    });

    test('maps a ProblemDetails error to a failure', () async {
      when(
        () => api.sendOtp(any()),
      ).thenThrow(badResponse(429, {'title': 'Identity.RateLimitExceeded'}));

      final result = await repo.sendOtp(testPhoneNumber);

      expect(result, isFailureWith('errors.identity.otp_rate_limited'));
    });
  });

  group('AuthRepoImpl.verifyOtp', () {
    test('returns the verify response', () async {
      when(
        () => api.verifyOtp(verifyBody),
      ).thenAnswer((_) async => verifyOtpResponse);

      expect(
        await repo.verifyOtp(verifyBody),
        isSuccessWith(verifyOtpResponse),
      );
    });

    test('maps an expired code error', () async {
      when(
        () => api.verifyOtp(verifyBody),
      ).thenThrow(badResponse(400, {'title': 'Identity.OtpExpiredOrNotFound'}));

      expect(
        await repo.verifyOtp(verifyBody),
        isFailureWith('errors.identity.otp_expired'),
      );
    });
  });

  group('AuthRepoImpl.saveSession', () {
    test('stores both tokens', () async {
      await repo.saveSession(accessToken: 'a', refreshToken: 'r');

      expect(tokenStorage.accessToken, 'a');
      expect(tokenStorage.refreshToken, 'r');
    });
  });

  group('AuthRepoImpl.logout', () {
    test('revokes the stored refresh token', () async {
      when(() => api.logout(any())).thenAnswer((_) async {});

      final result = await repo.logout();

      expect(result, isA<Success<void>>());
      final body =
          verify(() => api.logout(captureAny())).captured.single
              as LogoutRequestBody;
      expect(body.refreshToken, 'refresh-1');
    });

    test('skips the API call without a refresh token', () async {
      tokenStorage.refreshToken = '';

      final result = await repo.logout();

      expect(result, isA<Success<void>>());
      verifyNever(() => api.logout(any()));
    });

    test('maps a network failure', () async {
      when(() => api.logout(any())).thenThrow(badResponse(500));

      expect(await repo.logout(), isFailureWith('errors.server'));
    });
  });

  group('AuthRepoImpl.logoutAll', () {
    test('maps a 401 to the unauthorized key', () async {
      when(() => api.logoutAll()).thenThrow(badResponse(401));

      expect(await repo.logoutAll(), isFailureWith('errors.unauthorized'));
    });
  });

  group('AuthRepoImpl.clearSession', () {
    test('clears the stored tokens', () async {
      await repo.clearSession();

      expect(tokenStorage.clearCount, 1);
    });
  });
}
