import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/phone_change/domain/use_cases/verify_old_phone_use_case.dart';
import 'package:mal3abk/features/phone_change/presentation/cubit/verify_old_phone_cubit.dart';
import 'package:mal3abk/features/phone_change/presentation/cubit/verify_old_phone_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/phone_change_fixtures.dart';

class MockVerifyOldPhoneUseCase extends Mock implements VerifyOldPhoneUseCase {}

void main() {
  late MockVerifyOldPhoneUseCase useCase;
  late VerifyOldPhoneCubit cubit;

  setUp(() {
    useCase = MockVerifyOldPhoneUseCase();
    cubit = VerifyOldPhoneCubit(verifyOldPhoneUseCase: useCase);
  });

  tearDown(() => cubit.close());

  void stub(ApiResult<void> result) {
    when(
      () => useCase(
        requestId: any(named: 'requestId'),
        code: any(named: 'code'),
      ),
    ).thenAnswer((_) async => result);
  }

  group('VerifyOldPhoneCubit', () {
    test('initial state is VerifyOldPhoneState.initial()', () {
      expect(cubit.state, const VerifyOldPhoneState.initial());
    });

    test('emits [loading, success] when the code is accepted', () async {
      stub(const ApiResult.success(null));

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const VerifyOldPhoneState.loading(),
          const VerifyOldPhoneState.success(),
        ]),
      );
      await cubit.verify(requestId: testRequestId, code: '123456');
      await expectation;
    });

    test('emits [loading, error] when the code is rejected', () async {
      stub(const ApiResult.failure(phoneInUseFailure));

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const VerifyOldPhoneState.loading(),
          VerifyOldPhoneState.error(phoneInUseFailure.message),
        ]),
      );
      await cubit.verify(requestId: testRequestId, code: '123456');
      await expectation;
    });
  });
}
