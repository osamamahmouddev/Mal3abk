import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

/// Service managing Firebase Phone Authentication and ID token generation.
class FirebasePhoneAuthService {
  FirebasePhoneAuthService({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  /// Verifies a phone number by sending an SMS code via Firebase.
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(FirebaseAuthException error) onVerificationFailed,
    void Function(PhoneAuthCredential credential)? onVerificationCompleted,
    void Function(String verificationId)? onCodeAutoRetrievalTimeout,
    int? resendToken,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: timeout,
      forceResendingToken: resendToken,
      verificationCompleted: (PhoneAuthCredential credential) {
        onVerificationCompleted?.call(credential);
      },
      verificationFailed: onVerificationFailed,
      codeSent: (String verificationId, int? token) {
        onCodeSent(verificationId, token);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        onCodeAutoRetrievalTimeout?.call(verificationId);
      },
    );
  }

  /// Exchanges the SMS code for a Firebase user credential and retrieves the JWT ID token.
  Future<String?> getIdTokenForCode({
    required String verificationId,
    required String smsCode,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user?.getIdToken();
  }

  /// Retrieves the ID token directly from an auto-completed phone credential.
  Future<String?> getIdTokenForCredential(PhoneAuthCredential credential) async {
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user?.getIdToken();
  }
}
