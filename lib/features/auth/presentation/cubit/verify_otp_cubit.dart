import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/verify_otp_use_case.dart';
import 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState>
    with SafeEmitCubitMixin<VerifyOtpState> {
  VerifyOtpCubit({required this.verifyOtpUseCase})
    : super(const VerifyOtpState.initial());

  final VerifyOtpUseCase verifyOtpUseCase;

  bool _restoreAccount = false;
  bool get isRestoreAccount => _restoreAccount;

  void enableRestoreAccount() {
    _restoreAccount = true;
  }

  void reset() {
    _restoreAccount = false;
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
