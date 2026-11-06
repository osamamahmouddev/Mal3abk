import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/team_discovery_model.dart';

part 'discover_teams_state.freezed.dart';

@freezed
sealed class DiscoverTeamsState with _$DiscoverTeamsState {
  const factory DiscoverTeamsState.initial() = DiscoverTeamsInitial;
  const factory DiscoverTeamsState.loading() = DiscoverTeamsLoading;
  const factory DiscoverTeamsState.success(
    List<TeamDiscoveryModel> teams,
    bool hasMore,
    int page,
  ) = DiscoverTeamsSuccess;
  const factory DiscoverTeamsState.error(String message) = DiscoverTeamsError;
}
