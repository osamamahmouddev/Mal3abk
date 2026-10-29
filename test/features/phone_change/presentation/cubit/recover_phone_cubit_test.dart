import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/phone_change/domain/use_cases/recover_phone_use_case.dart';
import 'package:mal3abk/features/phone_change/presentation/cubit/recover_phone_cubit.dart';
import 'package:mal3abk/features/phone_change/presentation/cubit/recover_phone_state.dart';
import 'package:mocktail/mocktail.dart';

class MockRecoverPhoneUseCase extends Mock implements RecoverPhoneUseCase {}

void main() {
  late MockRecoverPhoneUseCase useCase;
  late RecoverPhoneCubit cubit;

  setUp(() {
    useCase = MockRecoverPhoneUseCase();
    cubit = RecoverPhoneCubit(recoverPhoneUseCase: useCase);
  });

  tearDown(() => cubit.close());

  group('RecoverPhoneCubit', () {
    test('initial state is RecoverPhoneState.initial()', () {
      expect(cubit.state, const RecoverPhoneState.initial());
    });

    test('emits [loading, success] when the number is restored', () async {
      when(
        () => useCase(any()),
      ).thenAnswer((_) async => const ApiResult.success(null));

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const RecoverPhoneState.loading(),
          const RecoverPhoneState.success(),
        ]),
      );
      await cubit.recover('token-1');
      await expectation;
    });

    test('emits [loading, error] for an invalid link', () async {
      when(() => useCase(any())).thenAnswer(
        (_) async => const ApiResult.failure(
          AppApiFailure(message: 'errors.identity.recovery_link_invalid'),
        ),
      );

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const RecoverPhoneState.loading(),
          const RecoverPhoneState.error(
            'errors.identity.recovery_link_invalid',
          ),
        ]),
      );
      await cubit.recover('token-1');
      await expectation;
    });
  });
}
