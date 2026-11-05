import 'team_leaderboard_page_model.dart';

class LeaderboardViewModel {
  const LeaderboardViewModel({required this.page, required this.myTeamIds});

  final TeamLeaderboardPageModel page;
  final Set<String> myTeamIds;
}
