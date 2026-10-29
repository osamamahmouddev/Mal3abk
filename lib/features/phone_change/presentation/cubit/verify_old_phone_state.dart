import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_old_phone_state.freezed.dart';

@freezed
class VerifyOldPhoneState with _$VerifyOldPhoneState {
  const factory VerifyOldPhoneState.initial() = VerifyOldPhoneInitial;
  const factory VerifyOldPhoneState.loading() = VerifyOldPhoneLoading;
  const factory VerifyOldPhoneState.success() = VerifyOldPhoneSuccess;
  const factory VerifyOldPhoneState.error(String message) = VerifyOldPhoneError;
}
