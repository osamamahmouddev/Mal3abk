import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/send_otp_response_model.dart';

part 'send_otp_state.freezed.dart';

@freezed
class SendOtpState with _$SendOtpState {
  const factory SendOtpState.initial() = SendOtpInitial;
  const factory SendOtpState.loading() = SendOtpLoading;
  const factory SendOtpState.success(SendOtpResponseModel data) =
      SendOtpSuccess;
  const factory SendOtpState.error(String message) = SendOtpError;
}
