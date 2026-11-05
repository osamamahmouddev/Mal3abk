import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/team_detail_model.dart';

part 'create_team_state.freezed.dart';

@freezed
sealed class CreateTeamState with _$CreateTeamState {
  const factory CreateTeamState.initial() = CreateTeamInitial;
  const factory CreateTeamState.loading() = CreateTeamLoading;
  const factory CreateTeamState.success(TeamDetailModel team) =
      CreateTeamSuccess;
  const factory CreateTeamState.error(String message) = CreateTeamError;
}
