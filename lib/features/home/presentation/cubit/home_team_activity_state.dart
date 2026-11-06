import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/home_team_activity_model.dart';

part 'home_team_activity_state.freezed.dart';

@freezed
sealed class HomeTeamActivityState with _$HomeTeamActivityState {
  const factory HomeTeamActivityState.initial() = HomeTeamActivityInitial;
  const factory HomeTeamActivityState.loading() = HomeTeamActivityLoading;
  const factory HomeTeamActivityState.success(HomeTeamActivityModel activity) =
      HomeTeamActivitySuccess;
  const factory HomeTeamActivityState.error(String message) =
      HomeTeamActivityError;
}
