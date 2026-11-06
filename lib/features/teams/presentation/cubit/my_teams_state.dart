import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/team_summary_model.dart';

part 'my_teams_state.freezed.dart';

@freezed
sealed class MyTeamsState with _$MyTeamsState {
  const factory MyTeamsState.initial() = MyTeamsInitial;
  const factory MyTeamsState.loading() = MyTeamsLoading;
  const factory MyTeamsState.success(List<TeamSummaryModel> teams) =
      MyTeamsSuccess;
  const factory MyTeamsState.error(String message) = MyTeamsError;
}
