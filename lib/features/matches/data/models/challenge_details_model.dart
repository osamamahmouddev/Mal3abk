import '../../../teams/data/models/team_summary_model.dart';
import 'team_challenge_model.dart';

/// A challenge seen from the caller's side: [myTeam] is the caller's team in
/// it, if any.
class ChallengeDetailsModel {
  const ChallengeDetailsModel({required this.challenge, this.myTeam});

  final TeamChallengeModel challenge;
  final TeamSummaryModel? myTeam;

  bool get canRespond =>
      challenge.isOpen &&
      challenge.isMyTurn &&
      (myTeam?.isLeader ?? false) &&
      myTeam?.id == challenge.currentTurnTeamId;
}
