import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/team_dashboard_model.dart';

part 'team_dashboard_state.freezed.dart';

@freezed
sealed class TeamDashboardState with _$TeamDashboardState {
  const factory TeamDashboardState.initial() = TeamDashboardInitial;
  const factory TeamDashboardState.loading() = TeamDashboardLoading;
  const factory TeamDashboardState.success(TeamDashboardModel dashboard) =
      TeamDashboardSuccess;
  const factory TeamDashboardState.error(String message) = TeamDashboardError;
}
