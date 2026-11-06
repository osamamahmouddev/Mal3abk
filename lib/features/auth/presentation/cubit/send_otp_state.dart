import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/send_otp_response_model.dart';

part 'send_otp_state.freezed.dart';

@freezed
class SendOtpState with _$SendOtpState {
  const factory SendOtpState.initial() = SendOtpInitial;
  const factory SendOtpState.loading() = SendOtpLoading;

  /// [sendCount] grows with every resend so the countdown restarts;
  /// [resendError] is set once when a resend failed.
  const factory SendOtpState.success(
    SendOtpResponseModel data, {
    @Default(1) int sendCount,
    @Default(false) bool resending,
    String? resendError,
  }) = SendOtpSuccess;
  const factory SendOtpState.error(String message) = SendOtpError;
}
