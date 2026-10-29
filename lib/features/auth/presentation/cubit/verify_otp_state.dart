import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/verify_otp_response_model.dart';

part 'verify_otp_state.freezed.dart';

@freezed
class VerifyOtpState with _$VerifyOtpState {
  const factory VerifyOtpState.initial() = VerifyOtpInitial;
  const factory VerifyOtpState.loading() = VerifyOtpLoading;
  const factory VerifyOtpState.success(VerifyOtpResponseModel data) =
      VerifyOtpSuccess;
  const factory VerifyOtpState.error(String message) = VerifyOtpError;
}
