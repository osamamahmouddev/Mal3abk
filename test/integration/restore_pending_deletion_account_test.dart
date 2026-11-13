@Tags(['integration'])
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_constants.dart';
import 'package:mal3abk/features/auth/data/apis/auth_api_service.dart';
import 'package:mal3abk/features/auth/data/models/send_otp_request_body.dart';
import 'package:mal3abk/features/auth/data/models/verify_otp_request_body.dart';
import 'package:mal3abk/features/profile/data/apis/profile_api_service.dart';
import 'package:mal3abk/features/settings/data/apis/account_api_service.dart';
import 'package:mal3abk/features/step_up/data/apis/step_up_api_service.dart';
import 'package:mal3abk/features/step_up/data/models/step_up_request_body.dart';
import 'package:mal3abk/features/step_up/data/models/step_up_scope.dart';

void main() {
  const baseUrl = 'http://127.0.0.1:5000';
  const mailpitUrl = 'http://127.0.0.1:8025';

  late Dio dio;
  late Dio mailpitDio;
  late AuthApiService authApi;

  setUpAll(() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
    mailpitDio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 2),
        receiveTimeout: const Duration(seconds: 2),
      ),
    );
    authApi = AuthApiService(dio);
  });

  Future<String> fetchLatestOtp(String phoneDigits) async {
    final searchRes = await mailpitDio.get<Map<String, dynamic>>(
      '$mailpitUrl/api/v1/search',
      queryParameters: {'query': 'to:sms+$phoneDigits@malabak.local'},
    );
    final messages = (searchRes.data!['messages'] as List)
        .cast<Map<String, dynamic>>();
    expect(messages, isNotEmpty);

    final latestMessageId = messages.first['ID'] as String;
    final messageDetail = await mailpitDio.get<Map<String, dynamic>>(
      '$mailpitUrl/api/v1/message/$latestMessageId',
    );
    final textBody = messageDetail.data!['Text'] as String;
    final otpMatch = RegExp(r'\b[0-9]{6}\b').firstMatch(textBody);
    expect(otpMatch, isNotNull);
    return otpMatch!.group(0)!;
  }

  test(
    'Restore pending deletion account flow: sign up -> delete -> sign in (pending deletion) -> restore -> signed in',
    () async {
      // Skip test if local API or Mailpit are down
      try {
        await dio.get('/api/v1/home');
        await mailpitDio.get('$mailpitUrl/api/v1/messages');
      } catch (_) {
        return;
      }

      final randomDigits = (10000000 + Random().nextInt(89999999)).toString();
      final phone = '+2010$randomDigits';
      final phoneDigits = '2010$randomDigits';

      // 1. Sign up: Send OTP
      final sendResponse = await authApi.sendOtp(
        SendOtpRequestBody(
          phoneNumber: phone,
          turnstileToken: 'dev-mobile-turnstile',
        ),
      );
      expect(sendResponse.normalizedPhoneNumber, phone);

      // 2. Fetch OTP and verify
      final otpCode1 = await fetchLatestOtp(phoneDigits);
      final verifyResponse = await authApi.verifyOtp(
        VerifyOtpRequestBody(phoneNumber: phone, code: otpCode1),
      );
      expect(verifyResponse.accessToken, isNotEmpty);
      expect(verifyResponse.userId, isNotEmpty);

      // 3. Authenticated Dio for deletion flow
      final authDio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {'Authorization': 'Bearer ${verifyResponse.accessToken}'},
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      );

      // 4. Request Step-Up OTP for account deletion
      final stepUpApi = StepUpApiService(authDio);
      await stepUpApi.sendCode();

      // 5. Fetch Step-Up OTP and trade for Step-Up Token
      final stepUpOtp = await fetchLatestOtp(phoneDigits);
      final stepUpResponse = await stepUpApi.verify(
        StepUpRequestBody(
          scope: StepUpScope.deleteAccount,
          secret: stepUpOtp,
          method: StepUpMethod.otp,
        ),
      );
      expect(stepUpResponse.stepUpToken, isNotEmpty);

      // 6. Delete account
      final accountApi = AccountApiService(authDio);
      await accountApi.deleteAccount(stepUpResponse.stepUpToken);

      // 7. Sign in again: Send OTP
      await authApi.sendOtp(
        SendOtpRequestBody(
          phoneNumber: phone,
          turnstileToken: 'dev-mobile-turnstile',
        ),
      );
      final otpCode2 = await fetchLatestOtp(phoneDigits);

      // 8. Verify OTP without restoreAccount: expect 4xx Identity.AccountPendingDeletion
      try {
        await authApi.verifyOtp(
          VerifyOtpRequestBody(phoneNumber: phone, code: otpCode2),
        );
        fail('Expected 4xx Identity.AccountPendingDeletion');
      } on DioException catch (e) {
        expect(e.response?.statusCode, anyOf(400, 403, 409));
        final problem = e.response?.data as Map<String, dynamic>?;
        final code = problem?['errorCode'] ?? problem?['code'] ?? problem?['title'];
        expect(code, 'Identity.AccountPendingDeletion');
      }

      // 9. The OTP was consumed by verify attempt, so request a new OTP
      await authApi.sendOtp(
        SendOtpRequestBody(
          phoneNumber: phone,
          turnstileToken: 'dev-mobile-turnstile',
        ),
      );
      final otpCode3 = await fetchLatestOtp(phoneDigits);

      // 10. Verify OTP with restoreAccount: true
      final restoreResponse = await authApi.verifyOtp(
        VerifyOtpRequestBody(
          phoneNumber: phone,
          code: otpCode3,
          restoreAccount: true,
        ),
      );
      expect(restoreResponse.accessToken, isNotEmpty);
      expect(restoreResponse.userId, verifyResponse.userId);

      // 11. Verify player is signed in and profile is active
      final restoredAuthDio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {'Authorization': 'Bearer ${restoreResponse.accessToken}'},
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      );
      final profileApi = ProfileApiService(restoredAuthDio);
      final profile = await profileApi.getMyProfile();
      expect(profile.userId, verifyResponse.userId);
      expect(profile.phoneNumber, phone);
    },
  );
}
