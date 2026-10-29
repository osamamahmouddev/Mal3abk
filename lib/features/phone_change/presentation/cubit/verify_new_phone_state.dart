import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/verify_new_phone_response_model.dart';

part 'verify_new_phone_state.freezed.dart';

@freezed
class VerifyNewPhoneState with _$VerifyNewPhoneState {
  const factory VerifyNewPhoneState.initial() = VerifyNewPhoneInitial;
  const factory VerifyNewPhoneState.loading() = VerifyNewPhoneLoading;
  const factory VerifyNewPhoneState.success(VerifyNewPhoneResponseModel data) =
      VerifyNewPhoneSuccess;
  const factory VerifyNewPhoneState.error(String message) = VerifyNewPhoneError;
}
