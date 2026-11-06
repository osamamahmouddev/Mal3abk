import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/team_detail_model.dart';

part 'join_team_state.freezed.dart';

@freezed
sealed class JoinTeamState with _$JoinTeamState {
  const factory JoinTeamState.initial() = JoinTeamInitial;
  const factory JoinTeamState.loading() = JoinTeamLoading;
  const factory JoinTeamState.success(TeamDetailModel team) = JoinTeamSuccess;
  const factory JoinTeamState.error(String message) = JoinTeamError;
}
