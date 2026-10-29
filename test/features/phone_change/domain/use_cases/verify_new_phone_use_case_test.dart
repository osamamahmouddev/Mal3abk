import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/auth/domain/repos/auth_repo.dart';
import 'package:mal3abk/features/auth/domain/use_cases/validate_otp_code_use_case.dart';
import 'package:mal3abk/features/phone_change/data/models/phone_change_code_request_body.dart';
import 'package:mal3abk/features/phone_change/domain/repos/phone_change_repo.dart';
import 'package:mal3abk/features/phone_change/domain/use_cases/verify_new_phone_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/phone_change_fixtures.dart';

class MockPhoneChangeRepo extends Mock implements PhoneChangeRepo {}

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late MockPhoneChangeRepo repo;
  late MockAuthRepo authRepo;
  late VerifyNewPhoneUseCase useCase;

  setUpAll(() {
    registerFallbackValue(
      const PhoneChangeCodeRequestBody(requestId: '', code: ''),
    );
  });

  setUp(() {
    repo = MockPhoneChangeRepo();
    authRepo = MockAuthRepo();
    useCase = VerifyNewPhoneUseCase(
      phoneChangeRepo: repo,
      authRepo: authRepo,
      validateOtpCodeUseCase: ValidateOtpCodeUseCase(),
    );
    when(
      () => authRepo.clearSession(),
    ).thenAnswer((_) async => const ApiResult.success(null));
  });

  group('VerifyNewPhoneUseCase', () {
    test('completes the change and clears the revoked session', () async {
      when(
        () => repo.verifyNewPhone(any()),
      ).thenAnswer((_) async => const ApiResult.success(verifyNewResponse));

      final result = await useCase(requestId: testRequestId, code: '123456');

      expect(result, isSuccessWith(verifyNewResponse));
      verify(() => authRepo.clearSession()).called(1);
    });

    test('keeps the session when the new number is taken', () async {
      when(
        () => repo.verifyNewPhone(any()),
      ).thenAnswer((_) async => const ApiResult.failure(phoneInUseFailure));

      final result = await useCase(requestId: testRequestId, code: '123456');

      expect(result, isFailureWith(phoneInUseFailure.message));
      verifyNever(() => authRepo.clearSession());
    });

    test('rejects a malformed code', () async {
      final result = await useCase(requestId: testRequestId, code: '1');

      expect(result, isFailureWith('errors.identity.otp_format'));
      verifyZeroInteractions(repo);
    });
  });
}
