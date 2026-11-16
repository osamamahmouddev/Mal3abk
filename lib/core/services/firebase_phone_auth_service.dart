import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

/// What happened when Firebase was asked to text a sign-in code.
sealed class FirebaseCodeResult {
  const FirebaseCodeResult();
}

/// The SMS is on its way; the code the player types is checked against
/// [verificationId]. [resendToken] lets the next resend skip the captcha.
final class FirebaseCodeSent extends FirebaseCodeResult {
  const FirebaseCodeSent({required this.verificationId, this.resendToken});

  final String verificationId;
  final int? resendToken;
}

/// Android verified the number by itself (instant verification), so no code
/// needs to be typed.
final class FirebaseAutoVerified extends FirebaseCodeResult {
  const FirebaseAutoVerified(this.credential);

  final PhoneAuthCredential credential;
}

/// Firebase could not send a code; [code] is Firebase's error code
/// (`quota-exceeded`, `too-many-requests`, `timeout`, ...).
final class FirebaseCodeFailed extends FirebaseCodeResult {
  const FirebaseCodeFailed(this.code);

  final String code;
}

/// Service managing Firebase Phone Authentication and ID token generation.
class FirebasePhoneAuthService {
  FirebasePhoneAuthService({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth;

  final FirebaseAuth? _firebaseAuth;

  /// Resolved on first use, so building the service never needs Firebase.
  FirebaseAuth get _auth => _firebaseAuth ?? FirebaseAuth.instance;

  /// Longest wait for Firebase to answer, captcha included.
  static const Duration sendTimeout = Duration(minutes: 2);

  /// Asks Firebase to text a code to [phoneNumber] (E.164) and waits for the
  /// first answer. When Android reads the SMS by itself after the code was
  /// already sent, [onAutoVerified] receives the credential.
  Future<FirebaseCodeResult> sendCode({
    required String phoneNumber,
    int? resendToken,
    void Function(PhoneAuthCredential credential)? onAutoVerified,
  }) async {
    final completer = Completer<FirebaseCodeResult>();
    void finish(FirebaseCodeResult result) {
      if (!completer.isCompleted) completer.complete(result);
    }

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        forceResendingToken: resendToken,
        verificationCompleted: (credential) {
          if (completer.isCompleted) {
            onAutoVerified?.call(credential);
          } else {
            finish(FirebaseAutoVerified(credential));
          }
        },
        verificationFailed: (error) => finish(FirebaseCodeFailed(error.code)),
        codeSent: (verificationId, token) => finish(
          FirebaseCodeSent(verificationId: verificationId, resendToken: token),
        ),
        codeAutoRetrievalTimeout: (_) {},
      );
    } on FirebaseAuthException catch (error) {
      finish(FirebaseCodeFailed(error.code));
    } on Exception {
      finish(const FirebaseCodeFailed('unavailable'));
    }

    return completer.future.timeout(
      sendTimeout,
      onTimeout: () => const FirebaseCodeFailed('timeout'),
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

    final userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user?.getIdToken();
  }

  /// Retrieves the ID token directly from an auto-completed phone credential.
  Future<String?> getIdTokenForCredential(
    PhoneAuthCredential credential,
  ) async {
    final userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user?.getIdToken();
  }
}
