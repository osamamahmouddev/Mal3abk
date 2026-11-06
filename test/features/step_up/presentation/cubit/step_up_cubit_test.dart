import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/step_up/data/models/step_up_scope.dart';
import 'package:mal3abk/features/step_up/domain/repos/step_up_repo.dart';
import 'package:mal3abk/features/step_up/presentation/cubit/step_up_cubit.dart';
import 'package:mal3abk/features/step_up/presentation/cubit/step_up_state.dart';
import 'package:mocktail/mocktail.dart';

class MockStepUpRepo extends Mock implements StepUpRepo {}

void main() {
  late MockStepUpRepo repo;
  late StepUpCubit cubit;

  setUp(() {
    repo = MockStepUpRepo();
    cubit = StepUpCubit(stepUpRepo: repo);
    when(
      () => repo.sendCode(),
    ).thenAnswer((_) async => const ApiResult.success(null));
  });

  tearDown(() => cubit.close());

  test('sends a code, then trades it for a token', () async {
    when(
      () => repo.verify(scope: StepUpScope.deleteAccount, code: '123456'),
    ).thenAnswer((_) async => const ApiResult.success('token-1'));

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        const StepUpState.sending(),
        const StepUpState.codeSent(),
        const StepUpState.verifying(),
        const StepUpState.verified('token-1'),
      ]),
    );
    await cubit.sendCode();
    await cubit.verify(scope: StepUpScope.deleteAccount, code: ' 123456 ');
    await expectation;
  });

  test('rejects a malformed code locally', () async {
    await cubit.sendCode();

    await cubit.verify(scope: StepUpScope.exportData, code: '12a');

    expect(
      cubit.state,
      const StepUpState.error('errors.identity.invalid_otp', codeSent: true),
    );
    verifyNever(
      () => repo.verify(
        scope: any(named: 'scope'),
        code: any(named: 'code'),
      ),
    );
  });

  test('keeps the code entry open after a wrong code', () async {
    when(
      () => repo.verify(scope: StepUpScope.changePhone, code: '000000'),
    ).thenAnswer(
      (_) async => const ApiResult.failure(
        AppApiFailure(message: 'errors.identity.invalid_otp'),
      ),
    );
    await cubit.sendCode();

    await cubit.verify(scope: StepUpScope.changePhone, code: '000000');

    expect((cubit.state as StepUpError).codeSent, isTrue);
  });
}
