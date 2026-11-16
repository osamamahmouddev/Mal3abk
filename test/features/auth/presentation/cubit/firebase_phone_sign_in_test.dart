import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/services/firebase_phone_auth_service.dart';
import 'package:mal3abk/features/auth/domain/use_cases/authenticate_with_firebase_use_case.dart';
import 'package:mal3abk/features/auth/domain/use_cases/normalize_phone_number_use_case.dart';
import 'package:mal3abk/features/auth/domain/use_cases/send_otp_use_case.dart';
import 'package:mal3abk/features/auth/domain/use_cases/verify_otp_use_case.dart';
import 'package:mal3abk/features/auth/presentation/cubit/send_otp_cubit.dart';
import 'package:mal3abk/features/auth/presentation/cubit/send_otp_state.dart';
import 'package:mal3abk/features/auth/presentation/cubit/verify_otp_cubit.dart';
import 'package:mal3abk/features/auth/presentation/cubit/verify_otp_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/auth_fixtures.dart';

class MockSendOtpUseCase extends Mock implements SendOtpUseCase {}

class MockVerifyOtpUseCase extends Mock implements VerifyOtpUseCase {}

class MockAuthenticateWithFirebaseUseCase extends Mock
    implements AuthenticateWithFirebaseUseCase {}

class MockFirebasePhoneAuthService extends Mock
    implements FirebasePhoneAuthService {}

class FakePhoneAuthCredential extends Fake implements PhoneAuthCredential {}

/// Signing in with a code Firebase texts: the code step gets Firebase's
/// verification id, the typed code is checked by Firebase and the resulting
/// ID token is traded with the API; the API's own code is the fallback.
void main() {
  late MockSendOtpUseCase sendOtp;
  late MockFirebasePhoneAuthService firebase;
  late SendOtpCubit sendCubit;

  setUpAll(() => registerFallbackValue(FakePhoneAuthCredential()));

  setUp(() {
    sendOtp = MockSendOtpUseCase();
    firebase = MockFirebasePhoneAuthService();
    sendCubit = SendOtpCubit(
      sendOtpUseCase: sendOtp,
      normalizePhoneNumberUseCase: NormalizePhoneNumberUseCase(),
      firebasePhoneAuth: firebase,
    );
  });

  tearDown(() => sendCubit.close());

  void firebaseAnswers(FirebaseCodeResult result) {
    when(
      () => firebase.sendCode(
        phoneNumber: any(named: 'phoneNumber'),
        resendToken: any(named: 'resendToken'),
        onAutoVerified: any(named: 'onAutoVerified'),
      ),
    ).thenAnswer((_) async => result);
  }

  group('SendOtpCubit with Firebase', () {
    test('Firebase texts the code to the normalized number', () async {
      firebaseAnswers(
        const FirebaseCodeSent(verificationId: 'vid-1', resendToken: 7),
      );

      await sendCubit.sendOtp('01012345678');

      final state = sendCubit.state as SendOtpSuccess;
      expect(state.data.normalizedPhoneNumber, testPhoneNumber);
      expect(state.verificationId, 'vid-1');
      expect(state.resendToken, 7);
      verify(
        () => firebase.sendCode(
          phoneNumber: testPhoneNumber,
          resendToken: null,
          onAutoVerified: any(named: 'onAutoVerified'),
        ),
      ).called(1);
      verifyNever(() => sendOtp(any()));
    });

    test('falls back to the API code when Firebase cannot send', () async {
      firebaseAnswers(const FirebaseCodeFailed('quota-exceeded'));
      when(
        () => sendOtp(any()),
      ).thenAnswer((_) async => const ApiResult.success(sendOtpResponse));

      await sendCubit.sendOtp('01012345678');

      expect(sendCubit.state, const SendOtpState.success(sendOtpResponse));
      verify(() => sendOtp('01012345678')).called(1);
    });

    test('rejects an invalid number without asking Firebase', () async {
      await sendCubit.sendOtp('123');

      expect(sendCubit.state, isA<SendOtpError>());
      verifyNever(
        () => firebase.sendCode(
          phoneNumber: any(named: 'phoneNumber'),
          resendToken: any(named: 'resendToken'),
          onAutoVerified: any(named: 'onAutoVerified'),
        ),
      );
    });

    test('resend goes through Firebase with the resend token', () async {
      firebaseAnswers(
        const FirebaseCodeSent(verificationId: 'vid-1', resendToken: 7),
      );
      await sendCubit.sendOtp('01012345678');
      firebaseAnswers(
        const FirebaseCodeSent(verificationId: 'vid-2', resendToken: 8),
      );

      await sendCubit.resend();

      final state = sendCubit.state as SendOtpSuccess;
      expect(state.verificationId, 'vid-2');
      expect(state.sendCount, 2);
      verify(
        () => firebase.sendCode(
          phoneNumber: testPhoneNumber,
          resendToken: 7,
          onAutoVerified: any(named: 'onAutoVerified'),
        ),
      ).called(1);
    });

    test('carries the credential when Android verifies by itself', () async {
      final credential = FakePhoneAuthCredential();
      firebaseAnswers(FirebaseAutoVerified(credential));

      await sendCubit.sendOtp('01012345678');

      final state = sendCubit.state as SendOtpSuccess;
      expect(state.autoCredential, same(credential));
      expect(state.verificationId, isNull);
    });

    test('without Firebase the API sends the code as before', () async {
      final apiOnly = SendOtpCubit(sendOtpUseCase: sendOtp);
      addTearDown(apiOnly.close);
      when(
        () => sendOtp(any()),
      ).thenAnswer((_) async => const ApiResult.success(sendOtpResponse));

      await apiOnly.sendOtp('01012345678');

      expect(apiOnly.state, const SendOtpState.success(sendOtpResponse));
    });
  });

  group('VerifyOtpCubit with Firebase', () {
    late MockVerifyOtpUseCase verifyOtp;
    late MockAuthenticateWithFirebaseUseCase authenticate;
    late VerifyOtpCubit verifyCubit;

    setUp(() {
      verifyOtp = MockVerifyOtpUseCase();
      authenticate = MockAuthenticateWithFirebaseUseCase();
      verifyCubit = VerifyOtpCubit(
        verifyOtpUseCase: verifyOtp,
        authenticateWithFirebaseUseCase: authenticate,
        firebasePhoneAuthService: firebase,
      );
      when(
        () => authenticate(
          idToken: any(named: 'idToken'),
          restoreAccount: any(named: 'restoreAccount'),
        ),
      ).thenAnswer((_) async => const ApiResult.success(verifyOtpResponse));
    });

    tearDown(() => verifyCubit.close());

    test('checks the code with Firebase and signs in with its token', () async {
      when(
        () => firebase.getIdTokenForCode(
          verificationId: 'vid-1',
          smsCode: testCode,
        ),
      ).thenAnswer((_) async => 'firebase-id-token');

      await verifyCubit.verifyOtp(
        phoneNumber: testPhoneNumber,
        code: testCode,
        verificationId: 'vid-1',
      );

      expect(
        verifyCubit.state,
        const VerifyOtpState.success(verifyOtpResponse),
      );
      verify(
        () => authenticate(idToken: 'firebase-id-token', restoreAccount: false),
      ).called(1);
      verifyNever(
        () => verifyOtp(
          phoneNumber: any(named: 'phoneNumber'),
          code: any(named: 'code'),
          restoreAccount: any(named: 'restoreAccount'),
        ),
      );
    });

    test('a wrong code shows a translated error, not Firebase text', () async {
      when(
        () => firebase.getIdTokenForCode(
          verificationId: any(named: 'verificationId'),
          smsCode: any(named: 'smsCode'),
        ),
      ).thenThrow(FirebaseAuthException(code: 'invalid-verification-code'));

      await verifyCubit.verifyOtp(
        phoneNumber: testPhoneNumber,
        code: '000000',
        verificationId: 'vid-1',
      );

      final state = verifyCubit.state as VerifyOtpError;
      expect(state.message, startsWith('errors.'));
      verifyNever(
        () => authenticate(
          idToken: any(named: 'idToken'),
          restoreAccount: any(named: 'restoreAccount'),
        ),
      );
    });

    test('a restore request is passed with the Firebase token', () async {
      when(
        () => firebase.getIdTokenForCode(
          verificationId: any(named: 'verificationId'),
          smsCode: any(named: 'smsCode'),
        ),
      ).thenAnswer((_) async => 'firebase-id-token');
      verifyCubit.enableRestoreAccount();

      await verifyCubit.verifyOtp(
        phoneNumber: testPhoneNumber,
        code: testCode,
        verificationId: 'vid-1',
      );

      verify(
        () => authenticate(idToken: 'firebase-id-token', restoreAccount: true),
      ).called(1);
    });

    test('an auto-verified credential signs in without a code', () async {
      final credential = FakePhoneAuthCredential();
      when(
        () => firebase.getIdTokenForCredential(credential),
      ).thenAnswer((_) async => 'firebase-id-token');

      await verifyCubit.verifyWithCredential(credential);

      expect(
        verifyCubit.state,
        const VerifyOtpState.success(verifyOtpResponse),
      );
    });

    test('without a verification id the API checks the code', () async {
      when(
        () => verifyOtp(
          phoneNumber: any(named: 'phoneNumber'),
          code: any(named: 'code'),
          restoreAccount: any(named: 'restoreAccount'),
        ),
      ).thenAnswer((_) async => const ApiResult.success(verifyOtpResponse));

      await verifyCubit.verifyOtp(phoneNumber: testPhoneNumber, code: testCode);

      verify(
        () => verifyOtp(
          phoneNumber: testPhoneNumber,
          code: testCode,
          restoreAccount: null,
        ),
      ).called(1);
      verifyNever(
        () => firebase.getIdTokenForCode(
          verificationId: any(named: 'verificationId'),
          smsCode: any(named: 'smsCode'),
        ),
      );
    });
  });
}
