import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/team_detail_model.dart';

part 'create_team_state.freezed.dart';

@freezed
sealed class CreateTeamState with _$CreateTeamState {
  const factory CreateTeamState.initial() = CreateTeamInitial;
  const factory CreateTeamState.loading() = CreateTeamLoading;

  /// [settingsSaved] is false when the team exists but its privacy choice
  /// could not be saved; the player is told to change it from settings.
  const factory CreateTeamState.success(
    TeamDetailModel team, {
    @Default(true) bool settingsSaved,
  }) = CreateTeamSuccess;
  const factory CreateTeamState.error(String message) = CreateTeamError;
}
