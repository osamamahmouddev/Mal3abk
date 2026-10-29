import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/phone_change/data/models/verify_new_phone_response_model.dart';
import 'package:mal3abk/features/phone_change/domain/use_cases/verify_new_phone_use_case.dart';
import 'package:mal3abk/features/phone_change/presentation/cubit/verify_new_phone_cubit.dart';
import 'package:mal3abk/features/phone_change/presentation/cubit/verify_new_phone_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/phone_change_fixtures.dart';

class MockVerifyNewPhoneUseCase extends Mock implements VerifyNewPhoneUseCase {}

void main() {
  late MockVerifyNewPhoneUseCase useCase;
  late VerifyNewPhoneCubit cubit;

  setUp(() {
    useCase = MockVerifyNewPhoneUseCase();
    cubit = VerifyNewPhoneCubit(verifyNewPhoneUseCase: useCase);
  });

  tearDown(() => cubit.close());

  void stub(ApiResult<VerifyNewPhoneResponseModel> result) {
    when(
      () => useCase(
        requestId: any(named: 'requestId'),
        code: any(named: 'code'),
      ),
    ).thenAnswer((_) async => result);
  }

  group('VerifyNewPhoneCubit', () {
    test('initial state is VerifyNewPhoneState.initial()', () {
      expect(cubit.state, const VerifyNewPhoneState.initial());
    });

    test('emits [loading, success] when the change completes', () async {
      stub(const ApiResult.success(verifyNewResponse));

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const VerifyNewPhoneState.loading(),
          const VerifyNewPhoneState.success(verifyNewResponse),
        ]),
      );
      await cubit.verify(requestId: testRequestId, code: '123456');
      await expectation;
    });

    test('emits [loading, error] when the number is taken', () async {
      stub(const ApiResult.failure(phoneInUseFailure));

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const VerifyNewPhoneState.loading(),
          VerifyNewPhoneState.error(phoneInUseFailure.message),
        ]),
      );
      await cubit.verify(requestId: testRequestId, code: '123456');
      await expectation;
    });
  });
}
