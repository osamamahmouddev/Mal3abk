import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/auth/domain/repos/auth_repo.dart';
import 'package:mal3abk/features/auth/domain/use_cases/normalize_phone_number_use_case.dart';
import 'package:mal3abk/features/auth/domain/use_cases/validate_otp_code_use_case.dart';
import 'package:mal3abk/features/phone_change/data/apis/phone_change_api_service.dart';
import 'package:mal3abk/features/phone_change/data/models/phone_change_code_request_body.dart';
import 'package:mal3abk/features/phone_change/data/models/recover_phone_request_body.dart';
import 'package:mal3abk/features/phone_change/data/models/start_phone_change_request_body.dart';
import 'package:mal3abk/features/phone_change/data/models/start_phone_change_response_model.dart';
import 'package:mal3abk/features/phone_change/data/models/verify_new_phone_response_model.dart';
import 'package:mal3abk/features/phone_change/data/repos/phone_change_repo_impl.dart';
import 'package:mal3abk/features/phone_change/domain/repos/phone_change_repo.dart';
import 'package:mal3abk/features/phone_change/domain/use_cases/recover_phone_use_case.dart';
import 'package:mal3abk/features/phone_change/domain/use_cases/start_phone_change_use_case.dart';
import 'package:mal3abk/features/phone_change/domain/use_cases/verify_new_phone_use_case.dart';
import 'package:mal3abk/features/phone_change/domain/use_cases/verify_old_phone_use_case.dart';
import 'package:mal3abk/features/phone_change/presentation/cubit/recover_phone_cubit.dart';
import 'package:mal3abk/features/phone_change/presentation/cubit/recover_phone_state.dart';
import 'package:mal3abk/features/phone_change/presentation/cubit/start_phone_change_cubit.dart';
import 'package:mal3abk/features/phone_change/presentation/cubit/start_phone_change_state.dart';
import 'package:mal3abk/features/phone_change/presentation/cubit/verify_new_phone_cubit.dart';
import 'package:mal3abk/features/phone_change/presentation/cubit/verify_new_phone_state.dart';
import 'package:mal3abk/features/phone_change/presentation/cubit/verify_old_phone_cubit.dart';
import 'package:mal3abk/features/phone_change/presentation/cubit/verify_old_phone_state.dart';
import 'package:mocktail/mocktail.dart';

class MockPhoneChangeApiService extends Mock implements PhoneChangeApiService {}
class MockPhoneChangeRepo extends Mock implements PhoneChangeRepo {}
class MockAuthRepo extends Mock implements AuthRepo {}
class MockNormalizePhoneNumberUseCase extends Mock implements NormalizePhoneNumberUseCase {}
class MockValidateOtpCodeUseCase extends Mock implements ValidateOtpCodeUseCase {}
class MockStartPhoneChangeUseCase extends Mock implements StartPhoneChangeUseCase {}
class MockVerifyOldPhoneUseCase extends Mock implements VerifyOldPhoneUseCase {}
class MockVerifyNewPhoneUseCase extends Mock implements VerifyNewPhoneUseCase {}
class MockRecoverPhoneUseCase extends Mock implements RecoverPhoneUseCase {}

void main() {
  setUpAll(() {
    registerFallbackValue(const StartPhoneChangeRequestBody(
      newPhoneNumber: '+201012345678',
      stepUpToken: 'step-1',
    ));
    registerFallbackValue(const PhoneChangeCodeRequestBody(
      requestId: 'req-1',
      code: '123456',
    ));
    registerFallbackValue(const RecoverPhoneRequestBody(
      recoveryToken: 'rec-1',
    ));
  });

  group('Phone Change Request and Response Models Tests', () {
    test('1. StartPhoneChangeRequestBody fromJson and toJson', () {
      final json = {'newPhoneNumber': '+201012345678', 'stepUpToken': 'token-xyz'};
      final body = StartPhoneChangeRequestBody.fromJson(json);
      expect(body.newPhoneNumber, '+201012345678');
      expect(body.stepUpToken, 'token-xyz');
      expect(body.toJson()['newPhoneNumber'], '+201012345678');
      expect(body.toJson()['stepUpToken'], 'token-xyz');
    });

    test('2. StartPhoneChangeResponseModel fromJson and toJson', () {
      final json = {
        'requestId': 'req-999',
        'expiresAtUtc': '2026-06-01T12:00:00.000Z',
      };
      final res = StartPhoneChangeResponseModel.fromJson(json);
      expect(res.requestId, 'req-999');
      expect(res.expiresAtUtc.toUtc(), DateTime.utc(2026, 6, 1, 12));
      expect(res.toJson()['requestId'], 'req-999');
    });

    test('3. PhoneChangeCodeRequestBody fromJson and toJson', () {
      final json = {'requestId': 'req-123', 'code': '654321'};
      final body = PhoneChangeCodeRequestBody.fromJson(json);
      expect(body.requestId, 'req-123');
      expect(body.code, '654321');
      expect(body.toJson()['requestId'], 'req-123');
      expect(body.toJson()['code'], '654321');
    });

    test('4. VerifyNewPhoneResponseModel fromJson and toJson', () {
      final json = {'success': true, 'newPhoneNumber': '+201098765432'};
      final res = VerifyNewPhoneResponseModel.fromJson(json);
      expect(res.success, isTrue);
      expect(res.newPhoneNumber, '+201098765432');
      expect(res.toJson()['success'], isTrue);
      expect(res.toJson()['newPhoneNumber'], '+201098765432');
    });

    test('5. RecoverPhoneRequestBody fromJson and toJson', () {
      final json = {'recoveryToken': 'token-abc-123'};
      final body = RecoverPhoneRequestBody.fromJson(json);
      expect(body.recoveryToken, 'token-abc-123');
      expect(body.toJson()['recoveryToken'], 'token-abc-123');
    });
  });

  group('PhoneChangeRepoImpl Tests', () {
    late MockPhoneChangeApiService mockApi;
    late PhoneChangeRepoImpl repo;

    setUp(() {
      mockApi = MockPhoneChangeApiService();
      repo = PhoneChangeRepoImpl(phoneChangeApiService: mockApi);
    });

    test('6. startPhoneChange returns success with response model', () async {
      final responseModel = StartPhoneChangeResponseModel(
        requestId: 'r-1',
        expiresAtUtc: DateTime.utc(2026, 1, 1),
      );
      when(() => mockApi.startPhoneChange(any())).thenAnswer((_) async => responseModel);

      final res = await repo.startPhoneChange(const StartPhoneChangeRequestBody(
        newPhoneNumber: '+201012345678',
        stepUpToken: 'token',
      ));

      expect(res, isA<Success<StartPhoneChangeResponseModel>>());
      expect((res as Success<StartPhoneChangeResponseModel>).data.requestId, 'r-1');
    });

    test('7. startPhoneChange catches DioException and returns failure', () async {
      when(() => mockApi.startPhoneChange(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/api/phone-change/start'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      final res = await repo.startPhoneChange(const StartPhoneChangeRequestBody(
        newPhoneNumber: '+201012345678',
        stepUpToken: 'token',
      ));

      expect(res, isA<ApiFailure<StartPhoneChangeResponseModel>>());
    });

    test('8. verifyOldPhone returns success when API accepts', () async {
      when(() => mockApi.verifyOldPhone(any())).thenAnswer((_) async {});

      final res = await repo.verifyOldPhone(const PhoneChangeCodeRequestBody(
        requestId: 'r-1',
        code: '123456',
      ));

      expect(res, isA<Success<void>>());
    });

    test('9. verifyOldPhone returns failure on error', () async {
      when(() => mockApi.verifyOldPhone(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/api/phone-change/verify-old'),
          response: Response(statusCode: 400, requestOptions: RequestOptions(path: '/')),
        ),
      );

      final res = await repo.verifyOldPhone(const PhoneChangeCodeRequestBody(
        requestId: 'r-1',
        code: '000000',
      ));

      expect(res, isA<ApiFailure<void>>());
    });

    test('10. verifyNewPhone returns success with VerifyNewPhoneResponseModel', () async {
      const responseModel = VerifyNewPhoneResponseModel(success: true, newPhoneNumber: '+201012345678');
      when(() => mockApi.verifyNewPhone(any())).thenAnswer((_) async => responseModel);

      final res = await repo.verifyNewPhone(const PhoneChangeCodeRequestBody(
        requestId: 'r-1',
        code: '123456',
      ));

      expect(res, isA<Success<VerifyNewPhoneResponseModel>>());
      expect((res as Success<VerifyNewPhoneResponseModel>).data.newPhoneNumber, '+201012345678');
    });

    test('11. verifyNewPhone returns failure on error', () async {
      when(() => mockApi.verifyNewPhone(any())).thenThrow(Exception('Verification failed'));

      final res = await repo.verifyNewPhone(const PhoneChangeCodeRequestBody(
        requestId: 'r-1',
        code: '123456',
      ));

      expect(res, isA<ApiFailure<VerifyNewPhoneResponseModel>>());
    });

    test('12. recoverPhone returns success when API accepts token', () async {
      when(() => mockApi.recoverPhone(any())).thenAnswer((_) async {});

      final res = await repo.recoverPhone('recovery-tok-123');
      expect(res, isA<Success<void>>());
      verify(() => mockApi.recoverPhone(any(that: isA<RecoverPhoneRequestBody>()))).called(1);
    });

    test('13. recoverPhone returns failure on 404/expired link', () async {
      when(() => mockApi.recoverPhone(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/api/phone-change/recover'),
          response: Response(statusCode: 404, requestOptions: RequestOptions(path: '/')),
        ),
      );

      final res = await repo.recoverPhone('expired-token');
      expect(res, isA<ApiFailure<void>>());
    });
  });

  group('StartPhoneChangeUseCase Tests', () {
    late MockPhoneChangeRepo mockRepo;
    late MockNormalizePhoneNumberUseCase mockNormalize;
    late StartPhoneChangeUseCase useCase;

    setUp(() {
      mockRepo = MockPhoneChangeRepo();
      mockNormalize = MockNormalizePhoneNumberUseCase();
      useCase = StartPhoneChangeUseCase(
        phoneChangeRepo: mockRepo,
        normalizePhoneNumberUseCase: mockNormalize,
      );
    });

    test('14. validate delegates directly to normalizePhoneNumberUseCase', () {
      when(() => mockNormalize('01012345678')).thenReturn(const ApiResult.success('+201012345678'));
      final res = useCase.validate('01012345678');
      expect((res as Success<String>).data, '+201012345678');
      verify(() => mockNormalize('01012345678')).called(1);
    });

    test('15. validate returns failure for invalid number', () {
      when(() => mockNormalize('123')).thenReturn(
        const ApiResult.failure(AppApiFailure(message: 'errors.auth.invalid_phone')),
      );
      final res = useCase.validate('123');
      expect(res, isA<ApiFailure<String>>());
    });

    test('16. call succeeds when phone is normalized and repo succeeds', () async {
      final responseModel = StartPhoneChangeResponseModel(
        requestId: 'req-ok',
        expiresAtUtc: DateTime.utc(2026, 1, 1),
      );
      when(() => mockNormalize('01012345678')).thenReturn(const ApiResult.success('+201012345678'));
      when(() => mockRepo.startPhoneChange(any())).thenAnswer((_) async => ApiResult.success(responseModel));

      final res = await useCase('01012345678', stepUpToken: 'step-tok');
      expect(res, isA<Success<StartPhoneChangeResponseModel>>());
      expect((res as Success<StartPhoneChangeResponseModel>).data.requestId, 'req-ok');
    });

    test('17. call stops and returns failure when normalization fails', () async {
      when(() => mockNormalize('invalid')).thenReturn(
        const ApiResult.failure(AppApiFailure(message: 'errors.auth.invalid_phone')),
      );

      final res = await useCase('invalid', stepUpToken: 'step-tok');
      expect(res, isA<ApiFailure<StartPhoneChangeResponseModel>>());
      verifyNever(() => mockRepo.startPhoneChange(any()));
    });

    test('18. call returns repo failure when repo call fails', () async {
      when(() => mockNormalize('01012345678')).thenReturn(const ApiResult.success('+201012345678'));
      when(() => mockRepo.startPhoneChange(any())).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.phone_change.rate_limited')),
      );

      final res = await useCase('01012345678', stepUpToken: 'step-tok');
      expect(res, isA<ApiFailure<StartPhoneChangeResponseModel>>());
      expect((res as ApiFailure<StartPhoneChangeResponseModel>).failure.message, 'errors.phone_change.rate_limited');
    });
  });

  group('VerifyOldPhoneUseCase Tests', () {
    late MockPhoneChangeRepo mockRepo;
    late MockValidateOtpCodeUseCase mockValidateOtp;
    late VerifyOldPhoneUseCase useCase;

    setUp(() {
      mockRepo = MockPhoneChangeRepo();
      mockValidateOtp = MockValidateOtpCodeUseCase();
      useCase = VerifyOldPhoneUseCase(
        phoneChangeRepo: mockRepo,
        validateOtpCodeUseCase: mockValidateOtp,
      );
    });

    test('19. rejects invalid otp code without calling repo', () async {
      when(() => mockValidateOtp('12')).thenReturn(
        const ApiResult.failure(AppApiFailure(message: 'errors.auth.otp_invalid')),
      );

      final res = await useCase(requestId: 'req-1', code: '12');
      expect(res, isA<ApiFailure<void>>());
      verifyNever(() => mockRepo.verifyOldPhone(any()));
    });

    test('20. succeeds when code is valid and repo succeeds', () async {
      when(() => mockValidateOtp('123456')).thenReturn(const ApiResult.success('123456'));
      when(() => mockRepo.verifyOldPhone(any())).thenAnswer((_) async => const ApiResult.success(null));

      final res = await useCase(requestId: 'req-1', code: '123456');
      expect(res, isA<Success<void>>());
      verify(() => mockRepo.verifyOldPhone(any(that: isA<PhoneChangeCodeRequestBody>()))).called(1);
    });

    test('21. returns failure when repo rejects code', () async {
      when(() => mockValidateOtp('123456')).thenReturn(const ApiResult.success('123456'));
      when(() => mockRepo.verifyOldPhone(any())).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.phone_change.invalid_code')),
      );

      final res = await useCase(requestId: 'req-1', code: '123456');
      expect(res, isA<ApiFailure<void>>());
    });
  });

  group('VerifyNewPhoneUseCase Tests', () {
    late MockPhoneChangeRepo mockRepo;
    late MockAuthRepo mockAuthRepo;
    late MockValidateOtpCodeUseCase mockValidateOtp;
    late VerifyNewPhoneUseCase useCase;

    setUp(() {
      mockRepo = MockPhoneChangeRepo();
      mockAuthRepo = MockAuthRepo();
      mockValidateOtp = MockValidateOtpCodeUseCase();
      useCase = VerifyNewPhoneUseCase(
        phoneChangeRepo: mockRepo,
        authRepo: mockAuthRepo,
        validateOtpCodeUseCase: mockValidateOtp,
      );
    });

    test('22. rejects invalid otp code without calling repo or authRepo', () async {
      when(() => mockValidateOtp('abc')).thenReturn(
        const ApiResult.failure(AppApiFailure(message: 'errors.auth.otp_invalid')),
      );

      final res = await useCase(requestId: 'req-1', code: 'abc');
      expect(res, isA<ApiFailure<VerifyNewPhoneResponseModel>>());
      verifyNever(() => mockRepo.verifyNewPhone(any()));
      verifyNever(() => mockAuthRepo.clearSession());
    });

    test('23. on success clears auth session and returns response model', () async {
      const responseModel = VerifyNewPhoneResponseModel(success: true, newPhoneNumber: '+201012345678');
      when(() => mockValidateOtp('654321')).thenReturn(const ApiResult.success('654321'));
      when(() => mockRepo.verifyNewPhone(any())).thenAnswer((_) async => const ApiResult.success(responseModel));
      when(() => mockAuthRepo.clearSession()).thenAnswer((_) async => const ApiResult.success(null));

      final res = await useCase(requestId: 'req-1', code: '654321');
      expect(res, isA<Success<VerifyNewPhoneResponseModel>>());
      verify(() => mockAuthRepo.clearSession()).called(1);
    });

    test('24. on repo failure does not clear auth session', () async {
      when(() => mockValidateOtp('654321')).thenReturn(const ApiResult.success('654321'));
      when(() => mockRepo.verifyNewPhone(any())).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.phone_already_taken')),
      );

      final res = await useCase(requestId: 'req-1', code: '654321');
      expect(res, isA<ApiFailure<VerifyNewPhoneResponseModel>>());
      verifyNever(() => mockAuthRepo.clearSession());
    });
  });

  group('RecoverPhoneUseCase Tests', () {
    late MockPhoneChangeRepo mockRepo;
    late MockAuthRepo mockAuthRepo;
    late RecoverPhoneUseCase useCase;

    setUp(() {
      mockRepo = MockPhoneChangeRepo();
      mockAuthRepo = MockAuthRepo();
      useCase = RecoverPhoneUseCase(
        phoneChangeRepo: mockRepo,
        authRepo: mockAuthRepo,
      );
    });

    test('25. rejects empty or whitespace recovery token', () async {
      final res1 = await useCase('');
      final res2 = await useCase('    ');
      expect(res1, isA<ApiFailure<void>>());
      expect(res2, isA<ApiFailure<void>>());
      verifyNever(() => mockRepo.recoverPhone(any()));
    });

    test('26. on success clears auth session and returns success', () async {
      when(() => mockRepo.recoverPhone('valid-token')).thenAnswer((_) async => const ApiResult.success(null));
      when(() => mockAuthRepo.clearSession()).thenAnswer((_) async => const ApiResult.success(null));

      final res = await useCase('valid-token');
      expect(res, isA<Success<void>>());
      verify(() => mockRepo.recoverPhone('valid-token')).called(1);
      verify(() => mockAuthRepo.clearSession()).called(1);
    });

    test('27. on failure does not clear auth session', () async {
      when(() => mockRepo.recoverPhone('bad-token')).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.recovery_expired')),
      );

      final res = await useCase('bad-token');
      expect(res, isA<ApiFailure<void>>());
      verifyNever(() => mockAuthRepo.clearSession());
    });
  });

  group('StartPhoneChangeCubit Tests', () {
    late MockStartPhoneChangeUseCase mockUseCase;
    late StartPhoneChangeCubit cubit;

    setUp(() {
      mockUseCase = MockStartPhoneChangeUseCase();
      cubit = StartPhoneChangeCubit(startPhoneChangeUseCase: mockUseCase);
    });

    tearDown(() => cubit.close());

    test('28. Initial state is StartPhoneChangeInitial', () {
      expect(cubit.state, const StartPhoneChangeState.initial());
    });

    test('29. validate returns true and does not emit error for valid number', () {
      when(() => mockUseCase.validate('01012345678')).thenReturn(const ApiResult.success('+201012345678'));
      final ok = cubit.validate('01012345678');
      expect(ok, isTrue);
      expect(cubit.state, const StartPhoneChangeState.initial());
    });

    test('30. validate returns false and emits error for invalid number', () {
      when(() => mockUseCase.validate('bad')).thenReturn(
        const ApiResult.failure(AppApiFailure(message: 'errors.invalid_phone')),
      );
      final ok = cubit.validate('bad');
      expect(ok, isFalse);
      expect(cubit.state, const StartPhoneChangeState.error('errors.invalid_phone'));
    });

    test('31. start emits [loading, success]', () async {
      final responseModel = StartPhoneChangeResponseModel(
        requestId: 'r-1',
        expiresAtUtc: DateTime.utc(2026, 1, 1),
      );
      when(() => mockUseCase('01012345678', stepUpToken: 'tok'))
          .thenAnswer((_) async => ApiResult.success(responseModel));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const StartPhoneChangeState.loading(),
          StartPhoneChangeState.success(responseModel),
        ]),
      );

      await cubit.start('01012345678', stepUpToken: 'tok');
    });

    test('32. start emits [loading, error] on failure', () async {
      when(() => mockUseCase('01012345678', stepUpToken: 'tok')).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.cooldown')),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const StartPhoneChangeState.loading(),
          const StartPhoneChangeState.error('errors.cooldown'),
        ]),
      );

      await cubit.start('01012345678', stepUpToken: 'tok');
    });

    test('33. start is ignored when already in loading state', () async {
      final responseModel = StartPhoneChangeResponseModel(requestId: 'r', expiresAtUtc: DateTime.utc(2026));
      when(() => mockUseCase('01012345678', stepUpToken: 'tok')).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 30));
        return ApiResult.success(responseModel);
      });

      final f1 = cubit.start('01012345678', stepUpToken: 'tok');
      final f2 = cubit.start('01012345678', stepUpToken: 'tok');
      await Future.wait([f1, f2]);

      verify(() => mockUseCase('01012345678', stepUpToken: 'tok')).called(1);
    });

    test('34. StartPhoneChangeCubit safe when closed during turn', () async {
      when(() => mockUseCase(any(), stepUpToken: any(named: 'stepUpToken'))).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return ApiResult.success(StartPhoneChangeResponseModel(requestId: 'r', expiresAtUtc: DateTime.utc(2026)));
      });

      final f = cubit.start('01012345678', stepUpToken: 'tok');
      await cubit.close();
      await f;
      expect(cubit.isClosed, isTrue);
    });
  });

  group('VerifyOldPhoneCubit Tests', () {
    late MockVerifyOldPhoneUseCase mockUseCase;
    late VerifyOldPhoneCubit cubit;

    setUp(() {
      mockUseCase = MockVerifyOldPhoneUseCase();
      cubit = VerifyOldPhoneCubit(verifyOldPhoneUseCase: mockUseCase);
    });

    tearDown(() => cubit.close());

    test('35. Initial state is VerifyOldPhoneInitial', () {
      expect(cubit.state, const VerifyOldPhoneState.initial());
    });

    test('36. verify emits [loading, success]', () async {
      when(() => mockUseCase(requestId: 'r-1', code: '123456')).thenAnswer((_) async => const ApiResult.success(null));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const VerifyOldPhoneState.loading(),
          const VerifyOldPhoneState.success(),
        ]),
      );

      await cubit.verify(requestId: 'r-1', code: '123456');
    });

    test('37. verify emits [loading, error] on failure', () async {
      when(() => mockUseCase(requestId: 'r-1', code: '000000')).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.wrong_otp')),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const VerifyOldPhoneState.loading(),
          const VerifyOldPhoneState.error('errors.wrong_otp'),
        ]),
      );

      await cubit.verify(requestId: 'r-1', code: '000000');
    });

    test('38. verify is ignored when in loading state', () async {
      when(() => mockUseCase(requestId: 'r-1', code: '123456')).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 30));
        return const ApiResult.success(null);
      });

      final f1 = cubit.verify(requestId: 'r-1', code: '123456');
      final f2 = cubit.verify(requestId: 'r-1', code: '123456');
      await Future.wait([f1, f2]);

      verify(() => mockUseCase(requestId: 'r-1', code: '123456')).called(1);
    });

    test('39. VerifyOldPhoneCubit safe when closed during execution', () async {
      when(() => mockUseCase(requestId: any(named: 'requestId'), code: any(named: 'code'))).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return const ApiResult.success(null);
      });

      final f = cubit.verify(requestId: 'r-1', code: '123456');
      await cubit.close();
      await f;
      expect(cubit.isClosed, isTrue);
    });
  });

  group('VerifyNewPhoneCubit Tests', () {
    late MockVerifyNewPhoneUseCase mockUseCase;
    late VerifyNewPhoneCubit cubit;

    setUp(() {
      mockUseCase = MockVerifyNewPhoneUseCase();
      cubit = VerifyNewPhoneCubit(verifyNewPhoneUseCase: mockUseCase);
    });

    tearDown(() => cubit.close());

    test('40. Initial state is VerifyNewPhoneInitial', () {
      expect(cubit.state, const VerifyNewPhoneState.initial());
    });

    test('41. verify emits [loading, success]', () async {
      const res = VerifyNewPhoneResponseModel(success: true, newPhoneNumber: '+201012345678');
      when(() => mockUseCase(requestId: 'r-1', code: '123456')).thenAnswer((_) async => const ApiResult.success(res));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const VerifyNewPhoneState.loading(),
          const VerifyNewPhoneState.success(res),
        ]),
      );

      await cubit.verify(requestId: 'r-1', code: '123456');
    });

    test('42. verify emits [loading, error] on failure', () async {
      when(() => mockUseCase(requestId: 'r-1', code: '123456')).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.phone_taken')),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const VerifyNewPhoneState.loading(),
          const VerifyNewPhoneState.error('errors.phone_taken'),
        ]),
      );

      await cubit.verify(requestId: 'r-1', code: '123456');
    });

    test('43. verify is ignored when in loading state', () async {
      const res = VerifyNewPhoneResponseModel(success: true, newPhoneNumber: '+201012345678');
      when(() => mockUseCase(requestId: 'r-1', code: '123456')).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 30));
        return const ApiResult.success(res);
      });

      final f1 = cubit.verify(requestId: 'r-1', code: '123456');
      final f2 = cubit.verify(requestId: 'r-1', code: '123456');
      await Future.wait([f1, f2]);

      verify(() => mockUseCase(requestId: 'r-1', code: '123456')).called(1);
    });

    test('44. VerifyNewPhoneCubit safe when closed during execution', () async {
      when(() => mockUseCase(requestId: any(named: 'requestId'), code: any(named: 'code'))).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return const ApiResult.success(VerifyNewPhoneResponseModel(success: true, newPhoneNumber: '1'));
      });

      final f = cubit.verify(requestId: 'r-1', code: '123456');
      await cubit.close();
      await f;
      expect(cubit.isClosed, isTrue);
    });
  });

  group('RecoverPhoneCubit Tests', () {
    late MockRecoverPhoneUseCase mockUseCase;
    late RecoverPhoneCubit cubit;

    setUp(() {
      mockUseCase = MockRecoverPhoneUseCase();
      cubit = RecoverPhoneCubit(recoverPhoneUseCase: mockUseCase);
    });

    tearDown(() => cubit.close());

    test('45. Initial state is RecoverPhoneInitial', () {
      expect(cubit.state, const RecoverPhoneState.initial());
    });

    test('46. recover emits [loading, success]', () async {
      when(() => mockUseCase('rec-tok')).thenAnswer((_) async => const ApiResult.success(null));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const RecoverPhoneState.loading(),
          const RecoverPhoneState.success(),
        ]),
      );

      await cubit.recover('rec-tok');
    });

    test('47. recover emits [loading, error] on failure', () async {
      when(() => mockUseCase('rec-tok')).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.expired_link')),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const RecoverPhoneState.loading(),
          const RecoverPhoneState.error('errors.expired_link'),
        ]),
      );

      await cubit.recover('rec-tok');
    });

    test('48. recover is ignored when in loading state', () async {
      when(() => mockUseCase('rec-tok')).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 30));
        return const ApiResult.success(null);
      });

      final f1 = cubit.recover('rec-tok');
      final f2 = cubit.recover('rec-tok');
      await Future.wait([f1, f2]);

      verify(() => mockUseCase('rec-tok')).called(1);
    });

    test('49. RecoverPhoneCubit safe when closed during execution', () async {
      when(() => mockUseCase(any())).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return const ApiResult.success(null);
      });

      final f = cubit.recover('rec-tok');
      await cubit.close();
      await f;
      expect(cubit.isClosed, isTrue);
    });
  });

  group('Phone Change State Classes Equatable / Representation Tests', () {
    late MockPhoneChangeRepo mockRepo;
    late MockNormalizePhoneNumberUseCase mockNormalize;
    late MockValidateOtpCodeUseCase mockValidateOtp;
    late MockAuthRepo mockAuthRepo;
    late MockPhoneChangeApiService mockApi;

    setUp(() {
      mockRepo = MockPhoneChangeRepo();
      mockNormalize = MockNormalizePhoneNumberUseCase();
      mockValidateOtp = MockValidateOtpCodeUseCase();
      mockAuthRepo = MockAuthRepo();
      mockApi = MockPhoneChangeApiService();
    });
    test('50. StartPhoneChangeInitial equality', () {
      const s1 = StartPhoneChangeState.initial();
      const s2 = StartPhoneChangeState.initial();
      expect(s1, equals(s2));
    });

    test('51. StartPhoneChangeLoading equality', () {
      const s1 = StartPhoneChangeState.loading();
      const s2 = StartPhoneChangeState.loading();
      expect(s1, equals(s2));
    });

    test('52. StartPhoneChangeSuccess equality', () {
      final res = StartPhoneChangeResponseModel(requestId: 'r1', expiresAtUtc: DateTime.utc(2026));
      final s1 = StartPhoneChangeState.success(res);
      final s2 = StartPhoneChangeState.success(res);
      expect(s1, equals(s2));
    });

    test('53. StartPhoneChangeError message inspection', () {
      const s = StartPhoneChangeState.error('err_msg');
      expect((s as StartPhoneChangeError).message, 'err_msg');
    });

    test('54. VerifyOldPhoneInitial equality', () {
      const s1 = VerifyOldPhoneState.initial();
      const s2 = VerifyOldPhoneState.initial();
      expect(s1, equals(s2));
    });

    test('55. VerifyOldPhoneLoading equality', () {
      const s1 = VerifyOldPhoneState.loading();
      const s2 = VerifyOldPhoneState.loading();
      expect(s1, equals(s2));
    });

    test('56. VerifyOldPhoneSuccess equality', () {
      const s1 = VerifyOldPhoneState.success();
      const s2 = VerifyOldPhoneState.success();
      expect(s1, equals(s2));
    });

    test('57. VerifyOldPhoneError message inspection', () {
      const s = VerifyOldPhoneState.error('old_code_err');
      expect((s as VerifyOldPhoneError).message, 'old_code_err');
    });

    test('58. VerifyNewPhoneInitial equality', () {
      const s1 = VerifyNewPhoneState.initial();
      const s2 = VerifyNewPhoneState.initial();
      expect(s1, equals(s2));
    });

    test('59. VerifyNewPhoneLoading equality', () {
      const s1 = VerifyNewPhoneState.loading();
      const s2 = VerifyNewPhoneState.loading();
      expect(s1, equals(s2));
    });

    test('60. VerifyNewPhoneSuccess equality', () {
      const m = VerifyNewPhoneResponseModel(success: true, newPhoneNumber: '+201012345678');
      const s1 = VerifyNewPhoneState.success(m);
      const s2 = VerifyNewPhoneState.success(m);
      expect(s1, equals(s2));
    });

    test('61. VerifyNewPhoneError message inspection', () {
      const s = VerifyNewPhoneState.error('new_phone_err');
      expect((s as VerifyNewPhoneError).message, 'new_phone_err');
    });

    test('62. RecoverPhoneInitial equality', () {
      const s1 = RecoverPhoneState.initial();
      const s2 = RecoverPhoneState.initial();
      expect(s1, equals(s2));
    });

    test('63. RecoverPhoneLoading equality', () {
      const s1 = RecoverPhoneState.loading();
      const s2 = RecoverPhoneState.loading();
      expect(s1, equals(s2));
    });

    test('64. RecoverPhoneSuccess equality', () {
      const s1 = RecoverPhoneState.success();
      const s2 = RecoverPhoneState.success();
      expect(s1, equals(s2));
    });

    test('65. RecoverPhoneError message inspection', () {
      const s = RecoverPhoneState.error('recover_err');
      expect((s as RecoverPhoneError).message, 'recover_err');
    });

    test('66. StartPhoneChangeResponseModel equality with same data', () {
      final date = DateTime.utc(2026, 5, 1);
      final m1 = StartPhoneChangeResponseModel(requestId: 'r1', expiresAtUtc: date);
      final m2 = StartPhoneChangeResponseModel(requestId: 'r1', expiresAtUtc: date);
      expect(m1.requestId, m2.requestId);
      expect(m1.expiresAtUtc, m2.expiresAtUtc);
    });

    test('67. VerifyNewPhoneResponseModel field equality', () {
      const m1 = VerifyNewPhoneResponseModel(success: true, newPhoneNumber: '123');
      const m2 = VerifyNewPhoneResponseModel(success: true, newPhoneNumber: '123');
      expect(m1.success, m2.success);
      expect(m1.newPhoneNumber, m2.newPhoneNumber);
    });

    test('68. StartPhoneChangeRequestBody constructor values', () {
      const b = StartPhoneChangeRequestBody(newPhoneNumber: 'p', stepUpToken: 's');
      expect(b.newPhoneNumber, 'p');
      expect(b.stepUpToken, 's');
    });

    test('69. PhoneChangeCodeRequestBody constructor values', () {
      const b = PhoneChangeCodeRequestBody(requestId: 'r', code: 'c');
      expect(b.requestId, 'r');
      expect(b.code, 'c');
    });

    test('70. RecoverPhoneRequestBody constructor values', () {
      const b = RecoverPhoneRequestBody(recoveryToken: 'tok');
      expect(b.recoveryToken, 'tok');
    });

    test('71. StartPhoneChangeUseCase normalizePhoneNumberUseCase accessor', () {
      final uc = StartPhoneChangeUseCase(
        phoneChangeRepo: mockRepo,
        normalizePhoneNumberUseCase: mockNormalize,
      );
      expect(uc.phoneChangeRepo, mockRepo);
      expect(uc.normalizePhoneNumberUseCase, mockNormalize);
    });

    test('72. VerifyOldPhoneUseCase accessors', () {
      final uc = VerifyOldPhoneUseCase(
        phoneChangeRepo: mockRepo,
        validateOtpCodeUseCase: mockValidateOtp,
      );
      expect(uc.phoneChangeRepo, mockRepo);
      expect(uc.validateOtpCodeUseCase, mockValidateOtp);
    });

    test('73. VerifyNewPhoneUseCase accessors', () {
      final uc = VerifyNewPhoneUseCase(
        phoneChangeRepo: mockRepo,
        authRepo: mockAuthRepo,
        validateOtpCodeUseCase: mockValidateOtp,
      );
      expect(uc.phoneChangeRepo, mockRepo);
      expect(uc.authRepo, mockAuthRepo);
    });

    test('74. RecoverPhoneUseCase accessors', () {
      final uc = RecoverPhoneUseCase(
        phoneChangeRepo: mockRepo,
        authRepo: mockAuthRepo,
      );
      expect(uc.phoneChangeRepo, mockRepo);
      expect(uc.authRepo, mockAuthRepo);
    });

    test('75. PhoneChangeRepoImpl accessors', () {
      final r = PhoneChangeRepoImpl(phoneChangeApiService: mockApi);
      expect(r.phoneChangeApiService, mockApi);
    });
  });
}
