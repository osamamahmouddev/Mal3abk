@Tags(['integration'])
library;

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/auth/data/apis/auth_api_service.dart';
import 'package:mal3abk/features/auth/data/models/logout_request_body.dart';
import 'package:mal3abk/features/phone_change/data/apis/phone_change_api_service.dart';
import 'package:mal3abk/features/phone_change/data/models/phone_change_code_request_body.dart';
import 'package:mal3abk/features/phone_change/data/models/start_phone_change_request_body.dart';
import 'package:mal3abk/features/settings/data/apis/account_api_service.dart';
import 'package:mal3abk/features/step_up/data/apis/step_up_api_service.dart';
import 'package:mal3abk/features/step_up/data/models/step_up_request_body.dart';
import 'package:mal3abk/features/step_up/data/models/step_up_scope.dart';

import 'support/local_stack.dart';

/// Signing in and staying signed in, end to end against the local stack:
/// OTP and Firebase sign-in, refresh-token rotation with reuse detection,
/// sign-out, the sessions screen, step-up and changing the phone number.
///
///     flutter test test/integration/auth_sessions_cycle_test.dart
void main() {
  late bool stackUp;
  setUpAll(() async => stackUp = await LocalStack.start());

  final api = LocalStack.apiUrl;
  Options lenient() => Options(validateStatus: (_) => true);

  Future<Response<dynamic>> refresh(String token) =>
      LocalStack.plain.post<dynamic>(
        '$api/api/v1/auth/refresh',
        data: {'refreshToken': token},
        options: lenient(),
      );

  Future<Map<String, dynamic>> otpSignIn(String phone, {String? name}) async {
    await LocalStack.sendOtp(phone);
    final response = await LocalStack.plain.post<Map<String, dynamic>>(
      '$api/api/v1/auth/otp/verify',
      data: {
        'phoneNumber': phone,
        'code': await LocalStack.otpFor(phone),
        'fullName': ?name,
      },
    );
    return response.data!;
  }

  group('auth & sessions cycle', () {
    test('OTP: the first sign-in registers, the next one returns the same '
        'player, a used or wrong code is refused', () async {
      if (!LocalStack.ready(stackUp)) return;
      final phone = LocalStack.newPhone();

      final first = await otpSignIn(phone, name: 'OTP Player');
      expect(first['isNewUser'], isTrue);
      expect((first['roles'] as List), contains('Player'));

      await LocalStack.sendOtp(phone);
      final code = await LocalStack.otpFor(phone);
      final wrong = await LocalStack.plain.post<dynamic>(
        '$api/api/v1/auth/otp/verify',
        data: {
          'phoneNumber': phone,
          'code': code == '000000' ? '111111' : '000000',
        },
        options: lenient(),
      );
      expect(wrong.statusCode, anyOf(400, 401));

      final second = await LocalStack.plain.post<Map<String, dynamic>>(
        '$api/api/v1/auth/otp/verify',
        data: {'phoneNumber': phone, 'code': code},
      );
      expect(second.data!['isNewUser'], isFalse);
      expect(second.data!['userId'], first['userId']);

      final replay = await LocalStack.plain.post<dynamic>(
        '$api/api/v1/auth/otp/verify',
        data: {'phoneNumber': phone, 'code': code},
        options: lenient(),
      );
      expect(replay.statusCode, anyOf(400, 401), reason: 'codes are one-use');
    }, timeout: const Timeout(Duration(minutes: 3)));

    test('Firebase: a verified number signs up once, then signs in; a bad '
        'token is refused', () async {
      if (!LocalStack.ready(stackUp)) return;
      final phone = LocalStack.newPhone();
      final first = await LocalStack.plain.post<Map<String, dynamic>>(
        '$api/api/v1/auth/firebase',
        data: {'idToken': 'dev:$phone', 'fullName': 'Firebase Player'},
      );
      expect(first.data!['isNewUser'], isTrue);
      expect((first.data!['roles'] as List), contains('Player'));

      final again = await LocalStack.plain.post<Map<String, dynamic>>(
        '$api/api/v1/auth/firebase',
        data: {'idToken': 'dev:$phone'},
      );
      expect(again.data!['isNewUser'], isFalse);
      expect(again.data!['userId'], first.data!['userId']);

      final forged = await LocalStack.plain.post<Map<String, dynamic>>(
        '$api/api/v1/auth/firebase',
        data: {'idToken': 'eyJhbGciOiJSUzI1NiJ9.e30.c2ln'},
        options: lenient(),
      );
      expect(forged.statusCode, 400);
      expect(forged.data!['title'], 'Identity.InvalidFirebaseToken');
    });

    test('refresh rotates the token; reusing an old one ends the whole '
        'session', () async {
      if (!LocalStack.ready(stackUp)) return;
      final player = await LocalStack.newPlayer('Refresh Player');

      final rotated = await refresh(player.refreshToken);
      expect(rotated.statusCode, 200);
      final next = rotated.data['refreshToken'] as String;
      expect(next, isNot(player.refreshToken));
      expect(rotated.data['accessToken'], isNotEmpty);

      // Someone replays the stolen, already-used token.
      final reused = await refresh(player.refreshToken);
      expect(reused.statusCode, 401);
      // Reuse revokes the family: the legitimate newer token dies too.
      final afterReuse = await refresh(next);
      expect(afterReuse.statusCode, 401);
    });

    test('sign-out kills the refresh token', () async {
      if (!LocalStack.ready(stackUp)) return;
      final player = await LocalStack.newPlayer('Logout Player');
      await AuthApiService(
        player.dio,
      ).logout(LogoutRequestBody(refreshToken: player.refreshToken));

      expect((await refresh(player.refreshToken)).statusCode, 401);
    });

    test('sessions: each sign-in is listed, revoke-others and logout-all '
        'end the other devices', () async {
      if (!LocalStack.ready(stackUp)) return;
      final phone = LocalStack.newPhone();
      final phoneA = await LocalStack.newPlayer('Device A', phone: phone);
      final phoneB = await LocalStack.newPlayer('Device B', phone: phone);
      final tablet = await LocalStack.newPlayer('Device C', phone: phone);
      expect(phoneB.id, phoneA.id);

      final sessions = await AccountApiService(phoneA.dio).getSessions();
      expect(sessions.length, greaterThanOrEqualTo(3));
      expect(sessions.where((s) => s.isCurrent), hasLength(1));

      await AccountApiService(phoneA.dio).revokeOtherSessions();
      expect((await refresh(phoneB.refreshToken)).statusCode, 401);
      expect((await refresh(tablet.refreshToken)).statusCode, 401);
      final left = await AccountApiService(phoneA.dio).getSessions();
      expect(left, hasLength(1));
      expect(left.single.isCurrent, isTrue);

      await AuthApiService(phoneA.dio).logoutAll();
      expect((await refresh(phoneA.refreshToken)).statusCode, 401);
    });

    test('step-up then phone change: both numbers confirm, the account keeps '
        'its id under the new number', () async {
      if (!LocalStack.ready(stackUp)) return;
      final player = await LocalStack.newPlayer('Mover');
      final newPhone = LocalStack.newPhone();

      final stepUp = StepUpApiService(player.dio);
      await stepUp.sendCode();
      final token = await stepUp.verify(
        StepUpRequestBody(
          scope: StepUpScope.changePhone,
          secret: await LocalStack.otpFor(player.phone),
        ),
      );
      expect(token.stepUpToken, isNotEmpty);

      final phoneChange = PhoneChangeApiService(player.dio);
      final started = await phoneChange.startPhoneChange(
        StartPhoneChangeRequestBody(
          newPhoneNumber: newPhone,
          stepUpToken: token.stepUpToken,
        ),
      );
      // The old number confirms first, then the new one.
      await phoneChange.verifyOldPhone(
        PhoneChangeCodeRequestBody(
          requestId: started.requestId,
          code: await LocalStack.otpFor(player.phone),
        ),
      );
      final done = await phoneChange.verifyNewPhone(
        PhoneChangeCodeRequestBody(
          requestId: started.requestId,
          code: await LocalStack.otpFor(newPhone),
        ),
      );
      expect(done.success, isTrue);
      expect(done.newPhoneNumber, newPhone);

      final underNewNumber = await LocalStack.newPlayer('x', phone: newPhone);
      expect(underNewNumber.id, player.id);
    }, timeout: const Timeout(Duration(minutes: 3)));

    test('a step-up token for one action cannot be used for another', () async {
      if (!LocalStack.ready(stackUp)) return;
      final player = await LocalStack.newPlayer('Scoped');
      final stepUp = StepUpApiService(player.dio);
      await stepUp.sendCode();
      final exportToken = await stepUp.verify(
        StepUpRequestBody(
          scope: StepUpScope.exportData,
          secret: await LocalStack.otpFor(player.phone),
        ),
      );

      final misuse = await player.dio.post<dynamic>(
        '/api/v1/me/phone-change/start',
        data: {
          'newPhoneNumber': LocalStack.newPhone(),
          'stepUpToken': exportToken.stepUpToken,
        },
        options: lenient(),
      );
      expect(misuse.statusCode, anyOf(400, 401, 403));
    });
  });
}
