import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/phone_change/data/apis/phone_change_api_service.dart';
import 'package:mal3abk/features/phone_change/data/models/phone_change_code_request_body.dart';
import 'package:mal3abk/features/phone_change/data/models/recover_phone_request_body.dart';
import 'package:mal3abk/features/phone_change/data/models/start_phone_change_request_body.dart';
import 'package:mal3abk/features/phone_change/data/repos/phone_change_repo_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/dio_errors.dart';
import '../../../../helpers/phone_change_fixtures.dart';

class MockPhoneChangeApiService extends Mock implements PhoneChangeApiService {}

void main() {
  late MockPhoneChangeApiService api;
  late PhoneChangeRepoImpl repo;

  const codeBody = PhoneChangeCodeRequestBody(
    requestId: testRequestId,
    code: '123456',
  );

  setUpAll(() {
    registerFallbackValue(const RecoverPhoneRequestBody(recoveryToken: ''));
  });

  setUp(() {
    api = MockPhoneChangeApiService();
    repo = PhoneChangeRepoImpl(phoneChangeApiService: api);
  });

  group('PhoneChangeRepoImpl.startPhoneChange', () {
    const body = StartPhoneChangeRequestBody(
      newPhoneNumber: '+201112345678',
      stepUpToken: 'step-up-1',
    );

    test('maps the cooldown error', () async {
      when(() => api.startPhoneChange(body)).thenThrow(
        badResponse(429, {'title': 'Identity.PhoneChangeCooldownActive'}),
      );

      expect(
        await repo.startPhoneChange(body),
        isFailureWith('errors.identity.phone_change_cooldown'),
      );
    });

    test('maps an expired step-up token', () async {
      when(
        () => api.startPhoneChange(body),
      ).thenThrow(badResponse(401, {'title': 'Identity.InvalidStepUpToken'}));

      expect(
        await repo.startPhoneChange(body),
        isFailureWith('errors.identity.step_up_expired'),
      );
    });
  });

  group('PhoneChangeRepoImpl.verifyOldPhone', () {
    test('returns success when the code is accepted', () async {
      when(() => api.verifyOldPhone(codeBody)).thenAnswer((_) async {});

      expect(await repo.verifyOldPhone(codeBody), isA<Success<void>>());
    });
  });

  group('PhoneChangeRepoImpl.verifyNewPhone', () {
    test('maps a number already in use', () async {
      when(() => api.verifyNewPhone(codeBody)).thenThrow(
        badResponse(409, {'title': 'Identity.PhoneNumberAlreadyInUse'}),
      );

      expect(
        await repo.verifyNewPhone(codeBody),
        isFailureWith('errors.identity.phone_in_use'),
      );
    });
  });

  group('PhoneChangeRepoImpl.recoverPhone', () {
    test('sends the recovery token', () async {
      when(() => api.recoverPhone(any())).thenAnswer((_) async {});

      expect(await repo.recoverPhone('token-1'), isA<Success<void>>());
      final body =
          verify(() => api.recoverPhone(captureAny())).captured.single
              as RecoverPhoneRequestBody;
      expect(body.recoveryToken, 'token-1');
    });

    test('maps an expired recovery link', () async {
      when(
        () => api.recoverPhone(any()),
      ).thenThrow(badResponse(400, {'title': 'Identity.RecoveryTokenExpired'}));

      expect(
        await repo.recoverPhone('token-1'),
        isFailureWith('errors.identity.recovery_link_invalid'),
      );
    });
  });
}
