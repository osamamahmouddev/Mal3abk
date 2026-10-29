import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/auth/domain/use_cases/validate_otp_code_use_case.dart';
import 'package:mal3abk/features/phone_change/data/models/phone_change_code_request_body.dart';
import 'package:mal3abk/features/phone_change/domain/repos/phone_change_repo.dart';
import 'package:mal3abk/features/phone_change/domain/use_cases/verify_old_phone_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/phone_change_fixtures.dart';

class MockPhoneChangeRepo extends Mock implements PhoneChangeRepo {}

void main() {
  late MockPhoneChangeRepo repo;
  late VerifyOldPhoneUseCase useCase;

  setUpAll(() {
    registerFallbackValue(
      const PhoneChangeCodeRequestBody(requestId: '', code: ''),
    );
  });

  setUp(() {
    repo = MockPhoneChangeRepo();
    useCase = VerifyOldPhoneUseCase(
      phoneChangeRepo: repo,
      validateOtpCodeUseCase: ValidateOtpCodeUseCase(),
    );
  });

  group('VerifyOldPhoneUseCase', () {
    test('verifies the code for the request', () async {
      when(
        () => repo.verifyOldPhone(any()),
      ).thenAnswer((_) async => const ApiResult.success(null));

      final result = await useCase(requestId: testRequestId, code: '123456');

      expect(result, isA<Success<void>>());
      final body =
          verify(() => repo.verifyOldPhone(captureAny())).captured.single
              as PhoneChangeCodeRequestBody;
      expect(body.requestId, testRequestId);
      expect(body.code, '123456');
    });

    test('rejects a malformed code', () async {
      final result = await useCase(requestId: testRequestId, code: 'abc');

      expect(result, isFailureWith('errors.identity.otp_format'));
      verifyZeroInteractions(repo);
    });
  });
}
