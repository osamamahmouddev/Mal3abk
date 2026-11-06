import '../../../teams/data/models/team_summary_model.dart';
import 'match_model.dart';

/// A match seen from the caller's side: [myTeam] is the caller's team in it,
/// if any.
class MatchDetailsModel {
  const MatchDetailsModel({required this.match, this.myTeam});

  final MatchModel match;
  final TeamSummaryModel? myTeam;

  bool get canLead => myTeam?.isLeader ?? false;

  bool canSubmitResult(DateTime nowUtc) =>
      canLead &&
      match.isAwaitingResult &&
      !nowUtc.isBefore(match.scheduledStartUtc);

  bool get canVerifyResult =>
      canLead &&
      match.isPendingVerification &&
      match.resultSubmittedByTeamId != myTeam?.id;
}
