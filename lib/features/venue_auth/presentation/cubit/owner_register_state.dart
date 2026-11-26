import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner_register_state.freezed.dart';

@freezed
sealed class OwnerRegisterState with _$OwnerRegisterState {
  const factory OwnerRegisterState.initial() = OwnerRegisterInitial;
  const factory OwnerRegisterState.loading() = OwnerRegisterLoading;

  /// The account exists and waits for its activation link. [phoneNumber] is
  /// where the link went; [resent] once it was sent again.
  const factory OwnerRegisterState.success({
    required String email,
    required String phoneNumber,
    @Default(false) bool resending,
    @Default(false) bool resent,
  }) = OwnerRegisterSuccess;
  const factory OwnerRegisterState.error(String message) = OwnerRegisterError;
}
