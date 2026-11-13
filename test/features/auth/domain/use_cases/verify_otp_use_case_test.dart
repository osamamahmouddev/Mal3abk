import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/auth/data/models/verify_otp_request_body.dart';
import 'package:mal3abk/features/auth/data/models/verify_otp_response_model.dart';
import 'package:mal3abk/features/auth/domain/repos/auth_repo.dart';
import 'package:mal3abk/features/auth/domain/use_cases/validate_otp_code_use_case.dart';
import 'package:mal3abk/features/auth/domain/use_cases/verify_otp_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/auth_fixtures.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late MockAuthRepo authRepo;
  late VerifyOtpUseCase useCase;

  setUpAll(() {
    registerFallbackValue(
      const VerifyOtpRequestBody(phoneNumber: '', code: ''),
    );
  });

  setUp(() {
    authRepo = MockAuthRepo();
    useCase = VerifyOtpUseCase(
      authRepo: authRepo,
      validateOtpCodeUseCase: ValidateOtpCodeUseCase(),
    );
    when(
      () => authRepo.saveSession(
        accessToken: any(named: 'accessToken'),
        refreshToken: any(named: 'refreshToken'),
      ),
    ).thenAnswer((_) async => const ApiResult.success(null));
  });

  group('VerifyOtpUseCase', () {
    test('verifies the code and stores the issued session', () async {
      when(
        () => authRepo.verifyOtp(any()),
      ).thenAnswer((_) async => const ApiResult.success(verifyOtpResponse));

      final result = await useCase(
        phoneNumber: testPhoneNumber,
        code: testCode,
      );

      expect(result, isSuccessWith(verifyOtpResponse));
      final body =
          verify(() => authRepo.verifyOtp(captureAny())).captured.single
              as VerifyOtpRequestBody;
      expect(body.phoneNumber, testPhoneNumber);
      expect(body.code, testCode);
      expect(body.restoreAccount, isNull);
      verify(
        () => authRepo.saveSession(
          accessToken: 'access-1',
          refreshToken: 'refresh-1',
        ),
      ).called(1);
    });

    test('threads restoreAccount: true to the repo', () async {
      when(
        () => authRepo.verifyOtp(any()),
      ).thenAnswer((_) async => const ApiResult.success(verifyOtpResponse));

      final result = await useCase(
        phoneNumber: testPhoneNumber,
        code: testCode,
        restoreAccount: true,
      );

      expect(result, isSuccessWith(verifyOtpResponse));
      final body =
          verify(() => authRepo.verifyOtp(captureAny())).captured.single
              as VerifyOtpRequestBody;
      expect(body.phoneNumber, testPhoneNumber);
      expect(body.code, testCode);
      expect(body.restoreAccount, isTrue);
    });

    test('rejects a malformed code without calling the API', () async {
      final result = await useCase(phoneNumber: testPhoneNumber, code: '12');

      expect(result, isFailureWith('errors.identity.otp_format'));
      verifyZeroInteractions(authRepo);
    });

    test('returns the API failure and stores nothing', () async {
      when(
        () => authRepo.verifyOtp(any()),
      ).thenAnswer((_) async => const ApiResult.failure(serverFailure));

      final result = await useCase(
        phoneNumber: testPhoneNumber,
        code: testCode,
      );

      expect(result, isFailureWith(serverFailure.message));
      verifyNever(
        () => authRepo.saveSession(
          accessToken: any(named: 'accessToken'),
          refreshToken: any(named: 'refreshToken'),
        ),
      );
    });

    test('fails when the response carries no tokens', () async {
      const withoutTokens = VerifyOtpResponseModel(
        userId: 'user-1',
        phoneNumber: testPhoneNumber,
        fullName: '',
        roles: [],
        isNewUser: true,
      );
      when(
        () => authRepo.verifyOtp(any()),
      ).thenAnswer((_) async => const ApiResult.success(withoutTokens));

      final result = await useCase(
        phoneNumber: testPhoneNumber,
        code: testCode,
      );

      expect(result, isFailureWith('common.unexpected_error'));
    });
  });
}
