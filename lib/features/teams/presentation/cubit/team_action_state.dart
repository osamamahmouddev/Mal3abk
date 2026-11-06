import 'package:freezed_annotation/freezed_annotation.dart';

import 'team_action_type.dart';

part 'team_action_state.freezed.dart';

@freezed
sealed class TeamActionState with _$TeamActionState {
  const factory TeamActionState.initial() = TeamActionInitial;
  const factory TeamActionState.loading() = TeamActionLoading;
  const factory TeamActionState.success(TeamActionType action) =
      TeamActionSuccess;
  const factory TeamActionState.error(String message) = TeamActionError;
}
