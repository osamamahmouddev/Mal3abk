import '../../../matches/data/models/match_model.dart';
import '../../../matches/data/models/team_challenge_model.dart';
import 'team_join_request_model.dart';
import 'team_profile_model.dart';

class TeamDashboardModel {
  const TeamDashboardModel({
    required this.profile,
    this.upcomingMatches = const [],
    this.recentMatches = const [],
    this.pendingJoinRequests = const [],
    this.openChallenges = const [],
  });

  final TeamProfileModel profile;
  final List<MatchModel> upcomingMatches;
  final List<MatchModel> recentMatches;
  final List<TeamJoinRequestModel> pendingJoinRequests;
  final List<TeamChallengeModel> openChallenges;
}
