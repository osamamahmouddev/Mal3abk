import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/services/firebase_phone_auth_service.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
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

  Future<void> verifyOtp({
    required String phoneNumber,
    required String code,
    bool? restoreAccount,
  }) async {
    if (state is VerifyOtpLoading) return;
    emitIfOpen(const VerifyOtpState.loading());
    final shouldRestore = restoreAccount ?? _restoreAccount;

    if (_verificationId != null && authenticateWithFirebaseUseCase != null) {
      try {
        final phoneAuth =
            firebasePhoneAuthService ?? FirebasePhoneAuthService();
        final idToken = await phoneAuth.getIdTokenForCode(
          verificationId: _verificationId!,
          smsCode: code,
        );

        if (idToken != null && idToken.isNotEmpty) {
          final result = await authenticateWithFirebaseUseCase!(
            idToken: idToken,
            restoreAccount: shouldRestore,
          );

          result.when(
            success: (data) {
              _restoreAccount = false;
              _verificationId = null;
              emitIfOpen(VerifyOtpState.success(data));
            },
            failure: (failure) {
              if (failure.code == 'Identity.AccountPendingDeletion' ||
                  failure.message ==
                      'errors.identity.account_pending_deletion') {
                emitIfOpen(const VerifyOtpState.accountPendingDeletion());
              } else {
                emitIfOpen(VerifyOtpState.error(failure.message));
              }
            },
          );
          return;
        }
      } catch (error, stackTrace) {
        // Never show the raw exception text: map it to a translation key.
        emitIfOpen(
          VerifyOtpState.error(ApiFailureMapper.map(error, stackTrace).message),
        );
        return;
      }
    }

    final result = await verifyOtpUseCase(
      phoneNumber: phoneNumber,
      code: code,
      restoreAccount: shouldRestore ? true : null,
    );
    result.when(
      success: (data) {
        _restoreAccount = false;
        emitIfOpen(VerifyOtpState.success(data));
      },
      failure: (failure) {
        if (failure.code == 'Identity.AccountPendingDeletion' ||
            failure.message == 'errors.identity.account_pending_deletion') {
          emitIfOpen(const VerifyOtpState.accountPendingDeletion());
        } else {
          emitIfOpen(VerifyOtpState.error(failure.message));
        }
      },
    );
  }
}
