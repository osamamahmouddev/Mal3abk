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

  Future<void> verifyOtp({
    required String phoneNumber,
    required String code,
  }) async {
    if (state is VerifyOtpLoading) return;
    emitIfOpen(const VerifyOtpState.loading());
    final result = await verifyOtpUseCase(phoneNumber: phoneNumber, code: code);
    result.when(
      success: (data) => emitIfOpen(VerifyOtpState.success(data)),
      failure: (failure) => emitIfOpen(VerifyOtpState.error(failure.message)),
    );
  }
}
