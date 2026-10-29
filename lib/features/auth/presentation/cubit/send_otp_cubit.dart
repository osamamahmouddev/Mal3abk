import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/send_otp_use_case.dart';
import 'send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState>
    with SafeEmitCubitMixin<SendOtpState> {
  SendOtpCubit({required this.sendOtpUseCase})
    : super(const SendOtpState.initial());

  final SendOtpUseCase sendOtpUseCase;

  Future<void> sendOtp(String phoneNumber) async {
    if (state is SendOtpLoading) return;
    emitIfOpen(const SendOtpState.loading());
    final result = await sendOtpUseCase(phoneNumber);
    result.when(
      success: (data) => emitIfOpen(SendOtpState.success(data)),
      failure: (failure) => emitIfOpen(SendOtpState.error(failure.message)),
    );
  }

  void reset() => emitIfOpen(const SendOtpState.initial());
}
