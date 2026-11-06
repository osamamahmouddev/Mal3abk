import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'account_action.dart';

part 'account_action_state.freezed.dart';

@freezed
sealed class AccountActionState with _$AccountActionState {
  const factory AccountActionState.initial() = AccountActionInitial;
  const factory AccountActionState.loading(AccountAction action) =
      AccountActionLoading;
  const factory AccountActionState.languageChanged(String languageCode) =
      AccountLanguageChanged;
  const factory AccountActionState.exported(Uint8List data) = AccountExported;
  const factory AccountActionState.deleted() = AccountDeleted;
  const factory AccountActionState.error(String message) = AccountActionError;
}
