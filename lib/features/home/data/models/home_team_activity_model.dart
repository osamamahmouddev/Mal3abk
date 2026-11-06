import '../../../matches/data/models/match_details_model.dart';
import '../../../matches/data/models/match_model.dart';
import '../../../matches/data/models/team_challenge_model.dart';

/// What needs the player's attention across their teams, most urgent first.
class HomeTeamActivityModel {
  const HomeTeamActivityModel({
    required this.hasTeams,
    this.challengeAwaitingReply,
    this.matchAwaitingResult,
    this.nextMatch,
  });

  final bool hasTeams;
  final TeamChallengeModel? challengeAwaitingReply;
  final MatchDetailsModel? matchAwaitingResult;
  final MatchModel? nextMatch;

  bool get isQuiet =>
      challengeAwaitingReply == null &&
      matchAwaitingResult == null &&
      nextMatch == null;
}
