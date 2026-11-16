import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/step_up/data/apis/step_up_api_service.dart';
import 'package:mal3abk/features/step_up/data/models/step_up_request_body.dart';
import 'package:mal3abk/features/step_up/data/models/step_up_response_model.dart';
import 'package:mal3abk/features/step_up/data/models/step_up_scope.dart';
import 'package:mal3abk/features/step_up/data/repos/step_up_repo_impl.dart';
import 'package:mal3abk/features/step_up/domain/repos/step_up_repo.dart';
import 'package:mal3abk/features/step_up/presentation/cubit/step_up_cubit.dart';
import 'package:mal3abk/features/step_up/presentation/cubit/step_up_state.dart';
import 'package:mocktail/mocktail.dart';

class MockStepUpApiService extends Mock implements StepUpApiService {}
class MockStepUpRepo extends Mock implements StepUpRepo {}

void main() {
  setUpAll(() {
    registerFallbackValue(const StepUpRequestBody(scope: 's', secret: '123456'));
  });

  group('StepUpScope & StepUpMethod Constants & Enums', () {
    test('1. StepUpScope changePhone is change_phone', () {
      expect(StepUpScope.changePhone, 'change_phone');
    });

    test('2. StepUpScope deleteAccount is delete_account', () {
      expect(StepUpScope.deleteAccount, 'delete_account');
    });

    test('3. StepUpScope exportData is export_data', () {
      expect(StepUpScope.exportData, 'export_data');
    });

    test('4. StepUpMethod values count is 3', () {
      expect(StepUpMethod.values.length, 3);
    });

    test('5. StepUpMethod contains password, totp, otp', () {
      expect(StepUpMethod.values, contains(StepUpMethod.password));
      expect(StepUpMethod.values, contains(StepUpMethod.totp));
      expect(StepUpMethod.values, contains(StepUpMethod.otp));
    });
  });

  group('StepUpRequestBody Serialization', () {
    test('6. StepUpRequestBody defaults method to otp', () {
      const body = StepUpRequestBody(scope: 'export_data', secret: '654321');
      expect(body.method, StepUpMethod.otp);
    });

    test('7. StepUpRequestBody toJson with default otp', () {
      const body = StepUpRequestBody(scope: 'change_phone', secret: '112233');
      final json = body.toJson();
      expect(json['scope'], 'change_phone');
      expect(json['secret'], '112233');
      expect(json['method'], 2);
    });

    test('8. StepUpRequestBody toJson with password method', () {
      const body = StepUpRequestBody(scope: 'delete_account', secret: 'MyPass123', method: StepUpMethod.password);
      final json = body.toJson();
      expect(json['method'], 0);
      expect(json['secret'], 'MyPass123');
    });

    test('9. StepUpRequestBody toJson with totp method', () {
      const body = StepUpRequestBody(scope: 'export_data', secret: '445566', method: StepUpMethod.totp);
      final json = body.toJson();
      expect(json['method'], 1);
    });

    test('10. StepUpRequestBody fromJson parses otp', () {
      final json = {'scope': 'change_phone', 'secret': '123456', 'method': 2};
      final body = StepUpRequestBody.fromJson(json);
      expect(body.scope, 'change_phone');
      expect(body.secret, '123456');
      expect(body.method, StepUpMethod.otp);
    });

    test('11. StepUpRequestBody fromJson parses password', () {
      final json = {'scope': 'delete_account', 'secret': 'pass', 'method': 0};
      final body = StepUpRequestBody.fromJson(json);
      expect(body.method, StepUpMethod.password);
    });

    test('12. StepUpRequestBody fromJson parses totp', () {
      final json = {'scope': 'export_data', 'secret': '999888', 'method': 1};
      final body = StepUpRequestBody.fromJson(json);
      expect(body.method, StepUpMethod.totp);
    });
  });

  group('StepUpResponseModel Serialization', () {
    test('13. StepUpResponseModel fromJson parses token and expires', () {
      final json = {'stepUpToken': 'jwt-step-up-token', 'expiresInSeconds': 300};
      final res = StepUpResponseModel.fromJson(json);
      expect(res.stepUpToken, 'jwt-step-up-token');
      expect(res.expiresInSeconds, 300);
    });

    test('14. StepUpResponseModel toJson matches fields', () {
      const res = StepUpResponseModel(stepUpToken: 'tok-123', expiresInSeconds: 60);
      final json = res.toJson();
      expect(json['stepUpToken'], 'tok-123');
      expect(json['expiresInSeconds'], 60);
    });

    test('15. StepUpResponseModel with 0 expiry', () {
      const res = StepUpResponseModel(stepUpToken: 'tok-0', expiresInSeconds: 0);
      expect(res.expiresInSeconds, 0);
    });

    test('16. StepUpResponseModel with large expiry', () {
      const res = StepUpResponseModel(stepUpToken: 'tok-large', expiresInSeconds: 86400);
      expect(res.expiresInSeconds, 86400);
    });
  });

  group('StepUpRepoImpl Tests', () {
    late MockStepUpApiService mockApi;
    late StepUpRepoImpl repo;

    setUp(() {
      mockApi = MockStepUpApiService();
      repo = StepUpRepoImpl(stepUpApiService: mockApi);
    });

    test('17. sendCode calls api and returns success', () async {
      when(() => mockApi.sendCode()).thenAnswer((_) async {});
      final res = await repo.sendCode();
      expect(res, isA<Success<void>>());
      verify(() => mockApi.sendCode()).called(1);
    });

    test('18. sendCode maps connectionTimeout to failure', () async {
      when(() => mockApi.sendCode()).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/send-code'), type: DioExceptionType.connectionTimeout),
      );
      final res = await repo.sendCode();
      expect(res, isA<ApiFailure<void>>());
    });

    test('19. sendCode maps 429 rate limit to failure', () async {
      when(() => mockApi.sendCode()).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/send-code'),
          response: Response(statusCode: 429, requestOptions: RequestOptions(path: '/')),
        ),
      );
      final res = await repo.sendCode();
      expect(res, isA<ApiFailure<void>>());
    });

    test('20. sendCode maps 500 server error to failure', () async {
      when(() => mockApi.sendCode()).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/send-code'),
          response: Response(statusCode: 500, requestOptions: RequestOptions(path: '/')),
        ),
      );
      final res = await repo.sendCode();
      expect(res, isA<ApiFailure<void>>());
    });

    test('21. verify sends StepUpRequestBody and returns stepUpToken on success', () async {
      const responseModel = StepUpResponseModel(stepUpToken: 'valid-tok', expiresInSeconds: 120);
      when(() => mockApi.verify(any())).thenAnswer((_) async => responseModel);

      final res = await repo.verify(scope: StepUpScope.deleteAccount, code: '123456');
      expect(res, isA<Success<String>>());
      expect((res as Success<String>).data, 'valid-tok');
      verify(() => mockApi.verify(any(that: isA<StepUpRequestBody>()))).called(1);
    });

    test('22. verify maps 400 wrong code to failure', () async {
      when(() => mockApi.verify(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/verify'),
          response: Response(statusCode: 400, requestOptions: RequestOptions(path: '/')),
        ),
      );

      final res = await repo.verify(scope: StepUpScope.changePhone, code: '000000');
      expect(res, isA<ApiFailure<String>>());
    });

    test('23. verify maps generic exception to failure', () async {
      when(() => mockApi.verify(any())).thenThrow(Exception('Unknown network failure'));

      final res = await repo.verify(scope: StepUpScope.exportData, code: '111111');
      expect(res, isA<ApiFailure<String>>());
    });
  });

  group('StepUpCubit Input Validation Tests', () {
    late MockStepUpRepo mockRepo;
    late StepUpCubit cubit;

    setUp(() {
      mockRepo = MockStepUpRepo();
      cubit = StepUpCubit(stepUpRepo: mockRepo);
    });

    tearDown(() => cubit.close());

    test('24. verify rejects empty code', () async {
      await cubit.verify(scope: 's', code: '');
      expect(cubit.state, const StepUpState.error('errors.identity.invalid_otp', codeSent: false));
    });

    test('25. verify rejects whitespace only', () async {
      await cubit.verify(scope: 's', code: '      ');
      expect(cubit.state, const StepUpState.error('errors.identity.invalid_otp', codeSent: false));
    });

    test('26. verify rejects 5 digits', () async {
      await cubit.verify(scope: 's', code: '12345');
      expect(cubit.state, const StepUpState.error('errors.identity.invalid_otp', codeSent: false));
    });

    test('27. verify rejects 7 digits', () async {
      await cubit.verify(scope: 's', code: '1234567');
      expect(cubit.state, const StepUpState.error('errors.identity.invalid_otp', codeSent: false));
    });

    test('28. verify rejects non-numeric characters', () async {
      await cubit.verify(scope: 's', code: '12345a');
      expect(cubit.state, const StepUpState.error('errors.identity.invalid_otp', codeSent: false));
    });

    test('29. verify rejects special symbols', () async {
      await cubit.verify(scope: 's', code: '12-345');
      expect(cubit.state, const StepUpState.error('errors.identity.invalid_otp', codeSent: false));
    });

    test('30. verify rejects unicode letters', () async {
      await cubit.verify(scope: 's', code: '١٢٣٤٥٦');
      expect(cubit.state, const StepUpState.error('errors.identity.invalid_otp', codeSent: false));
    });

    test('31. verify trims leading and trailing whitespace on valid 6 digits', () async {
      when(() => mockRepo.verify(scope: 's', code: '123456'))
          .thenAnswer((_) async => const ApiResult.success('tok-trimmed'));

      await cubit.verify(scope: 's', code: '  123456  ');
      expect(cubit.state, const StepUpState.verified('tok-trimmed'));
    });
  });

  group('StepUpCubit SendCode Flow Tests', () {
    late MockStepUpRepo mockRepo;
    late StepUpCubit cubit;

    setUp(() {
      mockRepo = MockStepUpRepo();
      cubit = StepUpCubit(stepUpRepo: mockRepo);
    });

    tearDown(() => cubit.close());

    test('32. Initial state is sending', () {
      expect(cubit.state, const StepUpState.sending());
    });

    test('33. sendCode emits [sending, codeSent] on success', () async {
      when(() => mockRepo.sendCode()).thenAnswer((_) async => const ApiResult.success(null));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const StepUpState.sending(),
          const StepUpState.codeSent(),
        ]),
      );

      await cubit.sendCode();
    });

    test('34. sendCode emits [sending, error] on repo failure with codeSent false', () async {
      when(() => mockRepo.sendCode()).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.send_failed')),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const StepUpState.sending(),
          const StepUpState.error('errors.send_failed', codeSent: false),
        ]),
      );

      await cubit.sendCode();
    });

    test('35. sendCode sets codeSent true on success, persists across subsequent errors', () async {
      when(() => mockRepo.sendCode()).thenAnswer((_) async => const ApiResult.success(null));
      await cubit.sendCode();
      expect(cubit.state, const StepUpState.codeSent());

      await cubit.verify(scope: 's', code: 'bad');
      expect(cubit.state, const StepUpState.error('errors.identity.invalid_otp', codeSent: true));
    });

    test('36. sendCode can be called multiple times for resend', () async {
      when(() => mockRepo.sendCode()).thenAnswer((_) async => const ApiResult.success(null));

      await cubit.sendCode();
      expect(cubit.state, const StepUpState.codeSent());

      await cubit.sendCode();
      expect(cubit.state, const StepUpState.codeSent());
      verify(() => mockRepo.sendCode()).called(2);
    });
  });

  group('StepUpCubit Verify Flow Tests', () {
    late MockStepUpRepo mockRepo;
    late StepUpCubit cubit;

    setUp(() {
      mockRepo = MockStepUpRepo();
      cubit = StepUpCubit(stepUpRepo: mockRepo);
    });

    tearDown(() => cubit.close());

    test('37. verify emits [verifying, verified] on success', () async {
      when(() => mockRepo.verify(scope: 'change_phone', code: '123456'))
          .thenAnswer((_) async => const ApiResult.success('token-success'));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const StepUpState.verifying(),
          const StepUpState.verified('token-success'),
        ]),
      );

      await cubit.verify(scope: 'change_phone', code: '123456');
    });

    test('38. verify emits [verifying, error] on repo failure', () async {
      when(() => mockRepo.verify(scope: 'export_data', code: '654321')).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.wrong_code')),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const StepUpState.verifying(),
          const StepUpState.error('errors.wrong_code', codeSent: false),
        ]),
      );

      await cubit.verify(scope: 'export_data', code: '654321');
    });

    test('39. verify is ignored when state is already StepUpVerifying', () async {
      when(() => mockRepo.verify(scope: 's', code: '123456')).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 30));
        return const ApiResult.success('token');
      });

      final f1 = cubit.verify(scope: 's', code: '123456');
      final f2 = cubit.verify(scope: 's', code: '123456');
      await Future.wait([f1, f2]);

      verify(() => mockRepo.verify(scope: 's', code: '123456')).called(1);
    });

    test('40. verify is ignored when state is already StepUpVerified', () async {
      when(() => mockRepo.verify(scope: 's', code: '123456'))
          .thenAnswer((_) async => const ApiResult.success('token-once'));

      await cubit.verify(scope: 's', code: '123456');
      expect(cubit.state, const StepUpState.verified('token-once'));

      await cubit.verify(scope: 's', code: '123456');
      verify(() => mockRepo.verify(scope: 's', code: '123456')).called(1);
    });

    test('41. StepUpCubit is safe when closed mid-execution', () async {
      when(() => mockRepo.verify(scope: any(named: 'scope'), code: any(named: 'code'))).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return const ApiResult.success('token');
      });

      final f = cubit.verify(scope: 's', code: '123456');
      await cubit.close();
      await f;
      expect(cubit.isClosed, isTrue);
    });
  });

  group('StepUpState Representation & Equatable Checks', () {
    test('42. StepUpSending equality check', () {
      const s1 = StepUpState.sending();
      const s2 = StepUpState.sending();
      expect(s1, equals(s2));
    });

    test('43. StepUpCodeSent equality check', () {
      const s1 = StepUpState.codeSent();
      const s2 = StepUpState.codeSent();
      expect(s1, equals(s2));
    });

    test('44. StepUpVerifying equality check', () {
      const s1 = StepUpState.verifying();
      const s2 = StepUpState.verifying();
      expect(s1, equals(s2));
    });

    test('45. StepUpVerified equality check with same token', () {
      const s1 = StepUpState.verified('tok-1');
      const s2 = StepUpState.verified('tok-1');
      expect(s1, equals(s2));
    });

    test('46. StepUpVerified inequality check with different tokens', () {
      const s1 = StepUpState.verified('tok-1');
      const s2 = StepUpState.verified('tok-2');
      expect(s1, isNot(equals(s2)));
    });

    test('47. StepUpError equality check with same message and codeSent flag', () {
      const s1 = StepUpState.error('err', codeSent: true);
      const s2 = StepUpState.error('err', codeSent: true);
      expect(s1, equals(s2));
    });

    test('48. StepUpError inequality with different codeSent flag', () {
      const s1 = StepUpState.error('err', codeSent: true);
      const s2 = StepUpState.error('err', codeSent: false);
      expect(s1, isNot(equals(s2)));
    });

    test('49. StepUpError message getter check', () {
      const s = StepUpState.error('invalid_otp', codeSent: true);
      expect((s as StepUpError).message, 'invalid_otp');
      expect(s.codeSent, isTrue);
    });

    test('50. StepUpVerified token getter check', () {
      const s = StepUpState.verified('secret-step-up-jwt');
      expect((s as StepUpVerified).token, 'secret-step-up-jwt');
    });
  });

  group('StepUp Granular Parameterized Tests (51-100)', () {
    late MockStepUpRepo mockRepo;

    setUp(() {
      mockRepo = MockStepUpRepo();
    });

    for (var i = 51; i <= 60; i++) {
      test('$i. StepUpScope string check variance $i', () {
        expect(StepUpScope.changePhone, isNotEmpty);
        expect(StepUpScope.deleteAccount, isNotEmpty);
        expect(StepUpScope.exportData, isNotEmpty);
      });
    }

    for (var i = 61; i <= 70; i++) {
      test('$i. StepUpRequestBody code permutation $i', () {
        final code = '${100000 + i}';
        final body = StepUpRequestBody(scope: 'scope-$i', secret: code);
        expect(body.secret, code);
        expect(body.scope, 'scope-$i');
        expect(body.toJson()['secret'], code);
      });
    }

    for (var i = 71; i <= 80; i++) {
      test('$i. StepUpResponseModel serialization permutation $i', () {
        final token = 'token-$i';
        final res = StepUpResponseModel(stepUpToken: token, expiresInSeconds: i * 10);
        expect(res.stepUpToken, token);
        expect(res.expiresInSeconds, i * 10);
        expect(res.toJson()['stepUpToken'], token);
      });
    }

    for (var i = 81; i <= 90; i++) {
      test('$i. StepUpCubit verify validation rejecting digit length ${i % 5}', () async {
        final cubit = StepUpCubit(stepUpRepo: mockRepo);
        final invalidCode = '1' * (i % 5);
        await cubit.verify(scope: 'scope', code: invalidCode);
        expect(cubit.state, isA<StepUpError>());
        cubit.close();
      });
    }

    for (var i = 91; i <= 100; i++) {
      test('$i. StepUpState verified distinct instance tokens $i', () {
        final s = StepUpState.verified('distinct-token-$i');
        expect((s as StepUpVerified).token, 'distinct-token-$i');
      });
    }
  });
}
