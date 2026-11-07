import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/send_otp_use_case.dart';
import 'send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState>
    with SafeEmitCubitMixin<SendOtpState> {
  SendOtpCubit({required this.sendOtpUseCase})
    : super(const SendOtpState.initial());

  final SendOtpUseCase sendOtpUseCase;

  Future<void> sendOtp(String phoneNumber) async {
    final current = state;
    if (current is SendOtpLoading) return;
    if (current is SendOtpError && _isFuture(current.retryAt)) return;
    emitIfOpen(const SendOtpState.loading());
    final result = await sendOtpUseCase(phoneNumber);
    result.when(
      success: (data) => emitIfOpen(SendOtpState.success(data)),
      failure: (failure) => emitIfOpen(
        SendOtpState.error(failure.message, retryAt: _retryAt(failure)),
      ),
    );
  }

  /// Sends a new code to the number already shown, staying on the code step.
  Future<void> resend() async {
    final current = state;
    if (current is! SendOtpSuccess || current.resending) return;
    emitIfOpen(current.copyWith(resending: true, resendError: null));
    final result = await sendOtpUseCase(current.data.normalizedPhoneNumber);
    result.when(
      success: (data) => emitIfOpen(
        SendOtpState.success(data, sendCount: current.sendCount + 1),
      ),
      failure: (failure) => emitIfOpen(
        current.copyWith(
          resending: false,
          resendError: failure.message,
          resendBlockedUntil: _retryAt(failure),
        ),
      ),
    );
  }

  /// When the server says how long to wait (429 + Retry-After), the moment
  /// the next code may be requested.
  DateTime? _retryAt(AppApiFailure failure) {
    final seconds = failure.extraData['retryAfterSeconds'];
    if (failure.statusCode != 429 || seconds is! int || seconds <= 0) {
      return null;
    }
    return DateTime.now().add(Duration(seconds: seconds));
  }

  bool _isFuture(DateTime? at) => at != null && at.isAfter(DateTime.now());

  void reset() => emitIfOpen(const SendOtpState.initial());
}
