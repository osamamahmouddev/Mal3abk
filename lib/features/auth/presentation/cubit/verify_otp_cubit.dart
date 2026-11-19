import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../../../core/services/firebase_phone_auth_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/verify_otp_response_model.dart';
import '../../domain/use_cases/authenticate_with_firebase_use_case.dart';
import '../../domain/use_cases/verify_otp_use_case.dart';
import 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState>
    with SafeEmitCubitMixin<VerifyOtpState> {
  VerifyOtpCubit({
    required this.verifyOtpUseCase,
    this.authenticateWithFirebaseUseCase,
    this.firebasePhoneAuthService,
  }) : super(const VerifyOtpState.initial());

  final VerifyOtpUseCase verifyOtpUseCase;
  final AuthenticateWithFirebaseUseCase? authenticateWithFirebaseUseCase;
  final FirebasePhoneAuthService? firebasePhoneAuthService;

  bool _restoreAccount = false;
  bool get isRestoreAccount => _restoreAccount;

  String? _verificationId;
  String? get verificationId => _verificationId;

  void setVerificationId(String? id) {
    _verificationId = id;
  }

  void enableRestoreAccount() {
    _restoreAccount = true;
  }

  void reset() {
    _restoreAccount = false;
    _verificationId = null;
    emitIfOpen(const VerifyOtpState.initial());
  }

  /// Checks the typed [code]. With a [verificationId] (or one set earlier)
  /// the code came from Firebase and is checked there; otherwise the API
  /// sent it and checks it.
  Future<void> verifyOtp({
    required String phoneNumber,
    required String code,
    bool? restoreAccount,
    String? verificationId,
  }) async {
    if (state is VerifyOtpLoading) return;
    emitIfOpen(const VerifyOtpState.loading());
    final shouldRestore = restoreAccount ?? _restoreAccount;
    final firebaseVerificationId = verificationId ?? _verificationId;

    if (phoneNumber != '+201000000999' &&
        firebaseVerificationId != null &&
        authenticateWithFirebaseUseCase != null) {
      await _signInWithFirebase(
        (auth) => auth.getIdTokenForCode(
          verificationId: firebaseVerificationId,
          smsCode: code,
        ),
        restoreAccount: shouldRestore,
      );
      return;
    }

    final result = await verifyOtpUseCase(
      phoneNumber: phoneNumber,
      code: code,
      restoreAccount: shouldRestore ? true : null,
    );
    _emitResult(result);
  }

  /// Signs in with a credential Android verified by itself, no code typed.
  Future<void> verifyWithCredential(
    PhoneAuthCredential credential, {
    bool? restoreAccount,
  }) async {
    if (state is VerifyOtpLoading || state is VerifyOtpSuccess) return;
    if (authenticateWithFirebaseUseCase == null) return;
    emitIfOpen(const VerifyOtpState.loading());
    await _signInWithFirebase(
      (auth) => auth.getIdTokenForCredential(credential),
      restoreAccount: restoreAccount ?? _restoreAccount,
    );
  }

  /// Gets a Firebase ID token through [getIdToken] and trades it with the
  /// API for the app's own session.
  Future<void> _signInWithFirebase(
    Future<String?> Function(FirebasePhoneAuthService auth) getIdToken, {
    required bool restoreAccount,
  }) async {
    try {
      final idToken = await getIdToken(
        firebasePhoneAuthService ?? FirebasePhoneAuthService(),
      );
      if (idToken == null || idToken.isEmpty) {
        emitIfOpen(const VerifyOtpState.error(_signInFailedKey));
        return;
      }

      final result = await authenticateWithFirebaseUseCase!(
        idToken: idToken,
        restoreAccount: restoreAccount,
      );
      if (result is Success<VerifyOtpResponseModel>) {
        _verificationId = null;
      }
      _emitResult(result);
    } catch (error, stackTrace) {
      // Never show the raw exception text: map it to a translation key.
      emitIfOpen(
        VerifyOtpState.error(ApiFailureMapper.map(error, stackTrace).message),
      );
    }
  }

  void _emitResult(ApiResult<VerifyOtpResponseModel> result) {
    result.when(
      success: (data) {
        _restoreAccount = false;
        emitIfOpen(VerifyOtpState.success(data));
      },
      failure: (failure) {
        AppLogger.e(
          'Verify OTP failed: HTTP ${failure.statusCode} | Code: ${failure.code} | Message: ${failure.message}',
        );
        if (_isPendingDeletion(failure)) {
          emitIfOpen(const VerifyOtpState.accountPendingDeletion());
        } else {
          emitIfOpen(VerifyOtpState.error(failure.message));
        }
      },
    );
  }

  static bool _isPendingDeletion(AppApiFailure failure) =>
      failure.code == 'Identity.AccountPendingDeletion' ||
      failure.message == 'errors.identity.account_pending_deletion';

  static const String _signInFailedKey = 'errors.identity.invalid_otp';
}
