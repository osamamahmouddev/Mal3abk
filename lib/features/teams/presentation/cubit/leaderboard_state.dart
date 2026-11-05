import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/team_leaderboard_entry_model.dart';

part 'leaderboard_state.freezed.dart';

@freezed
sealed class LeaderboardState with _$LeaderboardState {
  const factory LeaderboardState.initial() = LeaderboardInitial;
  const factory LeaderboardState.loading() = LeaderboardLoading;
  const factory LeaderboardState.success(
    List<TeamLeaderboardEntryModel> entries,
    bool hasMore,
    int page,
    String? governorate,
    Set<String> myTeamIds,
  ) = LeaderboardSuccess;
  const factory LeaderboardState.error(String message) = LeaderboardError;
}
