import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/auth/domain/use_cases/normalize_phone_number_use_case.dart';
import 'package:mal3abk/features/phone_change/data/models/start_phone_change_request_body.dart';
import 'package:mal3abk/features/phone_change/domain/repos/phone_change_repo.dart';
import 'package:mal3abk/features/phone_change/domain/use_cases/start_phone_change_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/phone_change_fixtures.dart';

class MockPhoneChangeRepo extends Mock implements PhoneChangeRepo {}

void main() {
  late MockPhoneChangeRepo repo;
  late StartPhoneChangeUseCase useCase;

  setUpAll(() {
    registerFallbackValue(
      const StartPhoneChangeRequestBody(newPhoneNumber: '', stepUpToken: ''),
    );
  });

  setUp(() {
    repo = MockPhoneChangeRepo();
    useCase = StartPhoneChangeUseCase(
      phoneChangeRepo: repo,
      normalizePhoneNumberUseCase: NormalizePhoneNumberUseCase(),
    );
  });

  group('StartPhoneChangeUseCase', () {
    test('starts the change with the step-up token', () async {
      when(
        () => repo.startPhoneChange(any()),
      ).thenAnswer((_) async => ApiResult.success(startResponse));

      final result = await useCase('01112345678', stepUpToken: stepUpToken);

      expect(result, isSuccessWith(startResponse));
      final body =
          verify(() => repo.startPhoneChange(captureAny())).captured.single
              as StartPhoneChangeRequestBody;
      expect(body.newPhoneNumber, '+201112345678');
      expect(body.stepUpToken, stepUpToken);
    });

    test('rejects an invalid number before any API call', () async {
      expect(
        useCase.validate('0100'),
        isFailureWith('errors.identity.invalid_phone'),
      );

      final result = await useCase('0100', stepUpToken: stepUpToken);

      expect(result, isFailureWith('errors.identity.invalid_phone'));
      verifyZeroInteractions(repo);
    });
  });
}
