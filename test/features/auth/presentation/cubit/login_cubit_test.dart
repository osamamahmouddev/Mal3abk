import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/auth/data/models/login_request_body.dart';
import 'package:mal3abk/features/auth/data/models/user_model.dart';
import 'package:mal3abk/features/auth/domain/use_cases/login_use_case.dart';
import 'package:mal3abk/features/auth/presentation/cubit/login_cubit.dart';
import 'package:mal3abk/features/auth/presentation/cubit/login_state.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late MockLoginUseCase mockLoginUseCase;

  const testUser = UserModel(
    id: 'user_1',
    name: 'Osama Mahmoud',
    email: 'osama@example.com',
    token: 'fake_jwt_token',
  );

  const testRequestBody = LoginRequestBody(
    email: 'osama@example.com',
    password: 'password123',
  );

  setUpAll(() {
    registerFallbackValue(testRequestBody);
  });

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
  });

  group('LoginCubit', () {
    test('initial state is LoginState.initial()', () {
      final cubit = LoginCubit(loginUseCase: mockLoginUseCase);
      expect(cubit.state, const LoginState.initial());
      cubit.close();
    });

    test('emits [loading, success] on successful login', () async {
      when(() => mockLoginUseCase(any())).thenAnswer(
        (_) async => const ApiResult.success(testUser),
      );
      final cubit = LoginCubit(loginUseCase: mockLoginUseCase);

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const LoginState.loading(),
          const LoginState.success(testUser),
        ]),
      );

      await cubit.login(testRequestBody);
      await expectation;
      await cubit.close();
    });

    test('emits [loading, error] on login failure', () async {
      when(() => mockLoginUseCase(any())).thenAnswer(
        (_) async => const ApiResult.failure(
          AppApiFailure(message: 'Invalid credentials'),
        ),
      );
      final cubit = LoginCubit(loginUseCase: mockLoginUseCase);

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const LoginState.loading(),
          const LoginState.error('Invalid credentials'),
        ]),
      );

      await cubit.login(testRequestBody);
      await expectation;
      await cubit.close();
    });
  });
}
