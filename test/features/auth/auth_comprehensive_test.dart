import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/auth/data/models/logout_request_body.dart';
import 'package:mal3abk/features/auth/data/models/send_otp_request_body.dart';
import 'package:mal3abk/features/auth/data/models/send_otp_response_model.dart';
import 'package:mal3abk/features/auth/data/models/verify_otp_request_body.dart';
import 'package:mal3abk/features/auth/data/models/verify_otp_response_model.dart';
import 'package:mal3abk/features/auth/domain/repos/auth_repo.dart';
import 'package:mal3abk/features/auth/domain/use_cases/logout_all_use_case.dart';
import 'package:mal3abk/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:mal3abk/features/auth/domain/use_cases/normalize_phone_number_use_case.dart';
import 'package:mal3abk/features/auth/domain/use_cases/send_otp_use_case.dart';
import 'package:mal3abk/features/auth/domain/use_cases/validate_otp_code_use_case.dart';
import 'package:mal3abk/features/auth/domain/use_cases/verify_otp_use_case.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  setUpAll(() {
    registerFallbackValue(const VerifyOtpRequestBody(phoneNumber: '', code: ''));
  });

  group('Auth Models Serialization Tests', () {
    test('1. LogoutRequestBody to json with refresh token', () {
      const body = LogoutRequestBody(refreshToken: 'rt-123');
      expect(body.refreshToken, 'rt-123');
      expect(body.toJson()['refreshToken'], 'rt-123');
    });

    test('2. SendOtpRequestBody to json with phone and turnstile', () {
      const body = SendOtpRequestBody(phoneNumber: '+201012345678', turnstileToken: 't-tok');
      expect(body.phoneNumber, '+201012345678');
      expect(body.turnstileToken, 't-tok');
      expect(body.toJson()['phoneNumber'], '+201012345678');
    });

    test('3. SendOtpResponseModel fromJson parses properly', () {
      final json = {'normalizedPhoneNumber': '+201012345678', 'expiresInSeconds': 120};
      final model = SendOtpResponseModel.fromJson(json);
      expect(model.normalizedPhoneNumber, '+201012345678');
      expect(model.expiresInSeconds, 120);
      expect(model.toJson()['expiresInSeconds'], 120);
    });

    test('4. VerifyOtpRequestBody parses with code and phone', () {
      const body = VerifyOtpRequestBody(phoneNumber: '+201012345678', code: '123456');
      expect(body.phoneNumber, '+201012345678');
      expect(body.code, '123456');
      expect(body.toJson()['code'], '123456');
    });

    test('5. VerifyOtpResponseModel parses tokens and user details', () {
      final json = {
        'userId': 'u-1',
        'phoneNumber': '+201012345678',
        'fullName': 'Mohamed Salah',
        'roles': ['Player'],
        'isNewUser': false,
        'accessToken': 'at-xyz',
        'refreshToken': 'rt-xyz',
        'expiresIn': 3600,
      };
      final model = VerifyOtpResponseModel.fromJson(json);
      expect(model.userId, 'u-1');
      expect(model.fullName, 'Mohamed Salah');
      expect(model.isNewUser, isFalse);
      expect(model.accessToken, 'at-xyz');
      expect(model.expiresIn, 3600);
      expect(model.toJson()['userId'], 'u-1');
    });

    test('6. VerifyOtpResponseModel parses for new user without tokens', () {
      final json = {
        'userId': 'u-2',
        'phoneNumber': '+201112345678',
        'fullName': '',
        'roles': [],
        'isNewUser': true,
      };
      final model = VerifyOtpResponseModel.fromJson(json);
      expect(model.isNewUser, isTrue);
      expect(model.accessToken, isNull);
    });
  });

  group('NormalizePhoneNumberUseCase Comprehensive Tests', () {
    final useCase = NormalizePhoneNumberUseCase();

    test('7. normalizes Vodafone Egypt prefix 010', () {
      final res = useCase('01012345678');
      expect(res.whenOrNull(success: (d) => d), '+201012345678');
    });

    test('8. normalizes Etisalat Egypt prefix 011', () {
      final res = useCase('01112345678');
      expect(res.whenOrNull(success: (d) => d), '+201112345678');
    });

    test('9. normalizes Orange Egypt prefix 012', () {
      final res = useCase('01212345678');
      expect(res.whenOrNull(success: (d) => d), '+201212345678');
    });

    test('10. normalizes WE Egypt prefix 015', () {
      final res = useCase('01512345678');
      expect(res.whenOrNull(success: (d) => d), '+201512345678');
    });

    test('11. normalizes already prefixed +20010...', () {
      final res = useCase('+201012345678');
      expect(res.whenOrNull(success: (d) => d), '+201012345678');
    });

    test('12. normalizes prefixed 002010...', () {
      final res = useCase('00201012345678');
      expect(res.whenOrNull(success: (d) => d), '+201012345678');
    });

    test('13. normalizes prefixed 2010...', () {
      final res = useCase('201012345678');
      expect(res.whenOrNull(success: (d) => d), '+201012345678');
    });

    test('14. ignores dashes and spaces in input', () {
      final res = useCase('010-1234-5678');
      expect(res.whenOrNull(success: (d) => d), '+201012345678');
    });

    test('15. accepts Arabic-Indic numerals', () {
      final res = useCase('٠١٠٩٨٧٦٥٤٣٢');
      expect(res.whenOrNull(success: (d) => d), '+201098765432');
    });

    test('16. rejects 10-digit number without operator prefix', () {
      final res = useCase('01312345678');
      expect(res, isA<ApiFailure>());
    });

    test('17. rejects too short number', () {
      final res = useCase('01012345');
      expect(res, isA<ApiFailure>());
    });

    test('18. rejects too long number', () {
      final res = useCase('01012345678999');
      expect(res, isA<ApiFailure>());
    });

    test('19. rejects non-numeric input', () {
      final res = useCase('0101234abcd');
      expect(res, isA<ApiFailure>());
    });

    test('20. rejects blank string', () {
      final res = useCase('');
      expect(res, isA<ApiFailure>());
    });

    test('21. rejects whitespaces only', () {
      final res = useCase('   ');
      expect(res, isA<ApiFailure>());
    });
  });

  group('ValidateOtpCodeUseCase Comprehensive Tests', () {
    final useCase = ValidateOtpCodeUseCase();

    test('22. accepts standard 6-digit numeric OTP', () {
      final res = useCase('123456');
      expect(res.whenOrNull(success: (d) => d), '123456');
    });

    test('23. accepts all zeros 000000', () {
      final res = useCase('000000');
      expect(res.whenOrNull(success: (d) => d), '000000');
    });

    test('24. accepts all nines 999999', () {
      final res = useCase('999999');
      expect(res.whenOrNull(success: (d) => d), '999999');
    });

    test('25. normalizes Arabic-Indic digits to ASCII', () {
      final res = useCase('١٢٣٤٥٦');
      expect(res.whenOrNull(success: (d) => d), '123456');
    });

    test('26. rejects 5-digit OTP', () {
      final res = useCase('12345');
      expect(res, isA<ApiFailure>());
    });

    test('27. rejects 7-digit OTP', () {
      final res = useCase('1234567');
      expect(res, isA<ApiFailure>());
    });

    test('28. rejects alphabetic characters in OTP', () {
      final res = useCase('12345A');
      expect(res, isA<ApiFailure>());
    });

    test('29. rejects empty string OTP', () {
      final res = useCase('');
      expect(res, isA<ApiFailure>());
    });

    test('30. trims surrounding whitespace', () {
      final res = useCase('  123456  ');
      expect(res.whenOrNull(success: (d) => d), '123456');
    });
  });

  group('Auth UseCases Delegations & Error Handling Tests', () {
    late MockAuthRepo mockRepo;
    final normUseCase = NormalizePhoneNumberUseCase();
    final valOtpUseCase = ValidateOtpCodeUseCase();

    setUp(() {
      mockRepo = MockAuthRepo();
    });

    test('31. SendOtpUseCase delegates normalized phone to repo', () async {
      final useCase = SendOtpUseCase(authRepo: mockRepo, normalizePhoneNumberUseCase: normUseCase);
      when(() => mockRepo.sendOtp(any()))
          .thenAnswer((_) async => const ApiResult.success(SendOtpResponseModel(normalizedPhoneNumber: '+201012345678', expiresInSeconds: 120)));

      final res = await useCase('01012345678');
      expect(res, isA<Success<SendOtpResponseModel>>());
      verify(() => mockRepo.sendOtp('+201012345678')).called(1);
    });

    test('32. SendOtpUseCase fails locally for invalid phone number', () async {
      final useCase = SendOtpUseCase(authRepo: mockRepo, normalizePhoneNumberUseCase: normUseCase);
      final res = await useCase('invalid');
      expect(res, isA<ApiFailure>());
      verifyNever(() => mockRepo.sendOtp(any()));
    });

    test('33. VerifyOtpUseCase delegates verification to repo', () async {
      final useCase = VerifyOtpUseCase(authRepo: mockRepo, validateOtpCodeUseCase: valOtpUseCase);
      const resModel = VerifyOtpResponseModel(
        userId: 'u-1',
        phoneNumber: '+201012345678',
        fullName: 'Test',
        roles: [],
        isNewUser: false,
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
      );
      when(() => mockRepo.verifyOtp(any())).thenAnswer((_) async => const ApiResult.success(resModel));
      when(() => mockRepo.saveSession(
            accessToken: any(named: 'accessToken'),
            refreshToken: any(named: 'refreshToken'),
          )).thenAnswer((_) async => const ApiResult.success(null));

      final res = await useCase(phoneNumber: '+201012345678', code: '123456');
      expect(res, isA<Success<VerifyOtpResponseModel>>());
      verify(() => mockRepo.saveSession(
            accessToken: 'access-token',
            refreshToken: 'refresh-token',
          )).called(1);
    });

    test('34. VerifyOtpUseCase rejects invalid code locally', () async {
      final useCase = VerifyOtpUseCase(authRepo: mockRepo, validateOtpCodeUseCase: valOtpUseCase);
      final res = await useCase(phoneNumber: '+201012345678', code: '12');
      expect(res, isA<ApiFailure>());
      verifyNever(() => mockRepo.verifyOtp(any()));
    });

    test('35. LogoutUseCase calls logout on repo and clears session', () async {
      final useCase = LogoutUseCase(authRepo: mockRepo);
      when(() => mockRepo.logout()).thenAnswer((_) async => const ApiResult.success(null));
      when(() => mockRepo.clearSession()).thenAnswer((_) async => const ApiResult.success(null));

      final res = await useCase();
      expect(res, isA<Success<void>>());
      verify(() => mockRepo.logout()).called(1);
      verify(() => mockRepo.clearSession()).called(1);
    });

    test('36. LogoutUseCase returns failure when clearSession fails', () async {
      final useCase = LogoutUseCase(authRepo: mockRepo);
      when(() => mockRepo.logout()).thenAnswer((_) async => const ApiResult.success(null));
      when(() => mockRepo.clearSession())
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'error')));

      final res = await useCase();
      expect(res, isA<ApiFailure>());
    });

    test('37. LogoutAllUseCase calls logoutAll on repo', () async {
      final useCase = LogoutAllUseCase(authRepo: mockRepo);
      when(() => mockRepo.logoutAll()).thenAnswer((_) async => const ApiResult.success(null));
      when(() => mockRepo.clearSession()).thenAnswer((_) async => const ApiResult.success(null));

      final res = await useCase();
      expect(res, isA<Success<void>>());
      verify(() => mockRepo.logoutAll()).called(1);
      verify(() => mockRepo.clearSession()).called(1);
    });

    test('38. LogoutAllUseCase returns failure on server error', () async {
      final useCase = LogoutAllUseCase(authRepo: mockRepo);
      when(() => mockRepo.logoutAll()).thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.server')));

      final res = await useCase();
      expect(res, isA<ApiFailure>());
    });

    test('39. SendOtpUseCase propagates rate limit failure from repo', () async {
      final useCase = SendOtpUseCase(authRepo: mockRepo, normalizePhoneNumberUseCase: normUseCase);
      when(() => mockRepo.sendOtp(any()))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'common.too_many_requests')));

      final res = await useCase('01012345678');
      expect(res, isA<ApiFailure>());
    });

    test('40. VerifyOtpUseCase propagates expired OTP failure from repo', () async {
      final useCase = VerifyOtpUseCase(authRepo: mockRepo, validateOtpCodeUseCase: valOtpUseCase);
      when(() => mockRepo.verifyOtp(any()))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.identity.otp_expired')));

      final res = await useCase(phoneNumber: '+201012345678', code: '123456');
      expect(res, isA<ApiFailure>());
    });

    test('41. VerifyOtpUseCase propagates max attempts exceeded failure', () async {
      final useCase = VerifyOtpUseCase(authRepo: mockRepo, validateOtpCodeUseCase: valOtpUseCase);
      when(() => mockRepo.verifyOtp(any()))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.identity.otp_max_attempts')));

      final res = await useCase(phoneNumber: '+201012345678', code: '123456');
      expect(res, isA<ApiFailure>());
    });

    test('42. VerifyOtpUseCase propagates turnstile failed error', () async {
      final useCase = VerifyOtpUseCase(authRepo: mockRepo, validateOtpCodeUseCase: valOtpUseCase);
      when(() => mockRepo.verifyOtp(any()))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.identity.turnstile_failed')));

      final res = await useCase(phoneNumber: '+201012345678', code: '123456');
      expect(res, isA<ApiFailure>());
    });

    test('43. VerifyOtpUseCase propagates user not found error', () async {
      final useCase = VerifyOtpUseCase(authRepo: mockRepo, validateOtpCodeUseCase: valOtpUseCase);
      when(() => mockRepo.verifyOtp(any()))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.identity.user_not_found')));

      final res = await useCase(phoneNumber: '+201012345678', code: '123456');
      expect(res, isA<ApiFailure>());
    });

    test('44. SendOtpUseCase propagates network connection error', () async {
      final useCase = SendOtpUseCase(authRepo: mockRepo, normalizePhoneNumberUseCase: normUseCase);
      when(() => mockRepo.sendOtp(any()))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.network')));

      final res = await useCase('01012345678');
      expect(res, isA<ApiFailure>());
    });

    test('45. SendOtpUseCase propagates timeout error', () async {
      final useCase = SendOtpUseCase(authRepo: mockRepo, normalizePhoneNumberUseCase: normUseCase);
      when(() => mockRepo.sendOtp(any()))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.timeout')));

      final res = await useCase('01012345678');
      expect(res, isA<ApiFailure>());
    });

    test('46. VerifyOtpUseCase handles network timeout error', () async {
      final useCase = VerifyOtpUseCase(authRepo: mockRepo, validateOtpCodeUseCase: valOtpUseCase);
      when(() => mockRepo.verifyOtp(any()))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.timeout')));

      final res = await useCase(phoneNumber: '+201012345678', code: '123456');
      expect(res, isA<ApiFailure>());
    });

    test('47. LogoutUseCase still clears session when logout has network error', () async {
      final useCase = LogoutUseCase(authRepo: mockRepo);
      when(() => mockRepo.logout())
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.network')));
      when(() => mockRepo.clearSession()).thenAnswer((_) async => const ApiResult.success(null));

      final res = await useCase();
      expect(res, isA<Success<void>>());
      verify(() => mockRepo.clearSession()).called(1);
    });

    test('48. LogoutAllUseCase handles unauthorized 401 response', () async {
      final useCase = LogoutAllUseCase(authRepo: mockRepo);
      when(() => mockRepo.logoutAll())
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.unauthorized')));

      final res = await useCase();
      expect(res, isA<ApiFailure>());
    });

    test('49. SendOtpUseCase normalizes spaces before sending to repo', () async {
      final useCase = SendOtpUseCase(authRepo: mockRepo, normalizePhoneNumberUseCase: normUseCase);
      when(() => mockRepo.sendOtp(any()))
          .thenAnswer((_) async => const ApiResult.success(SendOtpResponseModel(normalizedPhoneNumber: '+201012345678', expiresInSeconds: 120)));

      await useCase('  010 1234 5678  ');
      verify(() => mockRepo.sendOtp('+201012345678')).called(1);
    });

    test('50. VerifyOtpUseCase trims OTP whitespace before sending to repo', () async {
      final useCase = VerifyOtpUseCase(authRepo: mockRepo, validateOtpCodeUseCase: valOtpUseCase);
      const resModel = VerifyOtpResponseModel(userId: 'u-1', phoneNumber: '+201012345678', fullName: 'Test', roles: [], isNewUser: false);
      when(() => mockRepo.verifyOtp(any())).thenAnswer((_) async => const ApiResult.success(resModel));

      await useCase(phoneNumber: '+201012345678', code: ' 123456 ');
      verify(() => mockRepo.verifyOtp(any(that: isA<VerifyOtpRequestBody>().having((b) => b.code, 'code', '123456')))).called(1);
    });
  });
}
