import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/auth/domain/use_cases/normalize_phone_number_use_case.dart';

import '../../../../helpers/api_result_matchers.dart';

void main() {
  final useCase = NormalizePhoneNumberUseCase();

  group('NormalizePhoneNumberUseCase', () {
    test('normalizes a local number to E.164', () {
      expect(useCase('01012345678'), isSuccessWith('+201012345678'));
    });

    test('accepts a number typed without the leading zero', () {
      expect(useCase('1112345678'), isSuccessWith('+201112345678'));
    });

    test('accepts +20 and 0020 prefixes with spaces', () {
      expect(useCase('+20 122 345 6789'), isSuccessWith('+201223456789'));
      expect(useCase('00201512345678'), isSuccessWith('+201512345678'));
    });

    test('accepts Arabic-Indic digits', () {
      expect(useCase('٠١٠١٢٣٤٥٦٧٨'), isSuccessWith('+201012345678'));
    });

    test('rejects an unsupported operator prefix', () {
      expect(
        useCase('01312345678'),
        isFailureWith('errors.identity.invalid_phone'),
      );
    });

    test('rejects a number with the wrong length', () {
      expect(useCase('010123'), isFailureWith('errors.identity.invalid_phone'));
    });

    test('rejects an empty input', () {
      expect(useCase('   '), isFailureWith('errors.identity.invalid_phone'));
    });
  });
}
