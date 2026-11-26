import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner_login_state.freezed.dart';

@freezed
sealed class OwnerLoginState with _$OwnerLoginState {
  const factory OwnerLoginState.initial() = OwnerLoginInitial;
  const factory OwnerLoginState.loading() = OwnerLoginLoading;

  /// The account has two-factor sign-in on: ask for the authenticator code.
  const factory OwnerLoginState.totpRequired() = OwnerLoginTotpRequired;
  const factory OwnerLoginState.success() = OwnerLoginSuccess;
  const factory OwnerLoginState.error(String message) = OwnerLoginError;
}
