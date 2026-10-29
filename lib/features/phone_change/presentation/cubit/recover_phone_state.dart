import 'package:freezed_annotation/freezed_annotation.dart';

part 'recover_phone_state.freezed.dart';

@freezed
class RecoverPhoneState with _$RecoverPhoneState {
  const factory RecoverPhoneState.initial() = RecoverPhoneInitial;
  const factory RecoverPhoneState.loading() = RecoverPhoneLoading;
  const factory RecoverPhoneState.success() = RecoverPhoneSuccess;
  const factory RecoverPhoneState.error(String message) = RecoverPhoneError;
}
