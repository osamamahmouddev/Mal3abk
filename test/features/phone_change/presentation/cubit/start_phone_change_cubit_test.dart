import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/phone_change/domain/use_cases/start_phone_change_use_case.dart';
import 'package:mal3abk/features/phone_change/presentation/cubit/start_phone_change_cubit.dart';
import 'package:mal3abk/features/phone_change/presentation/cubit/start_phone_change_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/phone_change_fixtures.dart';

class MockStartPhoneChangeUseCase extends Mock
    implements StartPhoneChangeUseCase {}

void main() {
  late MockStartPhoneChangeUseCase useCase;
  late StartPhoneChangeCubit cubit;

  setUp(() {
    useCase = MockStartPhoneChangeUseCase();
    cubit = StartPhoneChangeCubit(startPhoneChangeUseCase: useCase);
  });

  tearDown(() => cubit.close());

  group('StartPhoneChangeCubit', () {
    test('initial state is StartPhoneChangeState.initial()', () {
      expect(cubit.state, const StartPhoneChangeState.initial());
    });

    test('emits [loading, success] with the request', () async {
      when(
        () => useCase(any(), stepUpToken: stepUpToken),
      ).thenAnswer((_) async => ApiResult.success(startResponse));

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const StartPhoneChangeState.loading(),
          StartPhoneChangeState.success(startResponse),
        ]),
      );
      await cubit.start('01112345678', stepUpToken: stepUpToken);
      await expectation;
    });

    test('reports an invalid number without starting', () async {
      when(
        () => useCase.validate('0100'),
      ).thenReturn(const ApiResult.failure(phoneInUseFailure));

      expect(cubit.validate('0100'), isFalse);
      expect(
        cubit.state,
        StartPhoneChangeState.error(phoneInUseFailure.message),
      );
    });

    test('emits [loading, error] on failure', () async {
      when(
        () => useCase(any(), stepUpToken: stepUpToken),
      ).thenAnswer((_) async => const ApiResult.failure(phoneInUseFailure));

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const StartPhoneChangeState.loading(),
          StartPhoneChangeState.error(phoneInUseFailure.message),
        ]),
      );
      await cubit.start('01112345678', stepUpToken: stepUpToken);
      await expectation;
    });
  });
}
