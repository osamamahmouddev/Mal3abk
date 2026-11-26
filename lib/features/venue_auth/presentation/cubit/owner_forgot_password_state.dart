import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner_forgot_password_state.freezed.dart';

@freezed
sealed class OwnerForgotPasswordState with _$OwnerForgotPasswordState {
  const factory OwnerForgotPasswordState.initial() = OwnerForgotPasswordInitial;
  const factory OwnerForgotPasswordState.loading() = OwnerForgotPasswordLoading;

  /// Shown after every valid request, whether or not the email has an
  /// account, so accounts can not be discovered.
  const factory OwnerForgotPasswordState.sent() = OwnerForgotPasswordSent;
  const factory OwnerForgotPasswordState.error(String message) =
      OwnerForgotPasswordError;
}
