import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/auth/domain/repos/auth_repo.dart';
import 'package:mal3abk/features/auth/domain/use_cases/normalize_phone_number_use_case.dart';
import 'package:mal3abk/features/auth/domain/use_cases/send_otp_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/auth_fixtures.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late MockAuthRepo authRepo;
  late SendOtpUseCase useCase;

  setUp(() {
    authRepo = MockAuthRepo();
    useCase = SendOtpUseCase(
      authRepo: authRepo,
      normalizePhoneNumberUseCase: NormalizePhoneNumberUseCase(),
    );
  });

  group('SendOtpUseCase', () {
    test('sends the code to the normalized number', () async {
      when(
        () => authRepo.sendOtp(testPhoneNumber),
      ).thenAnswer((_) async => const ApiResult.success(sendOtpResponse));

      final result = await useCase('01012345678');

      expect(result, isSuccessWith(sendOtpResponse));
      verify(() => authRepo.sendOtp(testPhoneNumber)).called(1);
    });

    test('does not call the API for an invalid number', () async {
      final result = await useCase('123');

      expect(result, isFailureWith('errors.identity.invalid_phone'));
      verifyZeroInteractions(authRepo);
    });

    test('returns the repository failure', () async {
      when(
        () => authRepo.sendOtp(any()),
      ).thenAnswer((_) async => const ApiResult.failure(serverFailure));

      final result = await useCase('01012345678');

      expect(result, isFailureWith(serverFailure.message));
    });
  });
}
