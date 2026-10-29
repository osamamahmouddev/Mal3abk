import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/auth/domain/use_cases/validate_otp_code_use_case.dart';

import '../../../../helpers/api_result_matchers.dart';

void main() {
  final useCase = ValidateOtpCodeUseCase();

  group('ValidateOtpCodeUseCase', () {
    test('accepts a 6-digit code and trims it', () {
      expect(useCase(' 123456 '), isSuccessWith('123456'));
    });

    test('accepts Arabic-Indic digits', () {
      expect(useCase('١٢٣٤٥٦'), isSuccessWith('123456'));
    });

    test('rejects a short code', () {
      expect(useCase('1234'), isFailureWith('errors.identity.otp_format'));
    });

    test('rejects non-digits', () {
      expect(useCase('12a456'), isFailureWith('errors.identity.otp_format'));
    });
  });
}
