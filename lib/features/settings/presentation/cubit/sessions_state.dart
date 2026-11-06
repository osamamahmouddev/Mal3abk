import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/session_model.dart';

part 'sessions_state.freezed.dart';

@freezed
sealed class SessionsState with _$SessionsState {
  const factory SessionsState.initial() = SessionsInitial;
  const factory SessionsState.loading() = SessionsLoading;

  /// [busy] while a revoke is in flight; [failure] is set once when it fails.
  const factory SessionsState.success(
    List<SessionModel> sessions, {
    @Default(false) bool busy,
    String? failure,
  }) = SessionsSuccess;
  const factory SessionsState.error(String message) = SessionsError;
}
