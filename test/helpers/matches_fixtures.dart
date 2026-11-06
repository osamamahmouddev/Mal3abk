import 'package:mal3abk/features/matches/data/models/match_model.dart';
import 'package:mal3abk/features/matches/data/models/match_page_model.dart';
import 'package:mal3abk/features/matches/data/models/team_challenge_model.dart';

const otherTeamId = 'team-2';
final testNow = DateTime.utc(2026, 11, 5, 12);

MatchModel testMatch({
  String id = 'match-1',
  String homeTeamId = 'team-1',
  String awayTeamId = otherTeamId,
  DateTime? startUtc,
  String status = MatchModel.scheduled,
  String resultStatus = MatchModel.resultNone,
  String? submittedBy,
  int? homeScore,
  int? awayScore,
}) {
  final start = startUtc ?? testNow.add(const Duration(days: 1));
  return MatchModel(
    id: id,
    homeTeamId: homeTeamId,
    homeTeamName: 'فريق النجوم',
    awayTeamId: awayTeamId,
    awayTeamName: 'فريق الصقور',
    scheduledStartUtc: start,
    scheduledEndUtc: start.add(const Duration(minutes: 90)),
    durationMinutes: 90,
    status: status,
    outcome: 'None',
    resultStatus: resultStatus,
    resultSubmittedByTeamId: submittedBy,
    homeScore: homeScore,
    awayScore: awayScore,
  );
}

MatchPageModel pageOf(List<MatchModel> items) => MatchPageModel(
  items: items,
  totalCount: items.length,
  page: 1,
  pageSize: 20,
);

TeamChallengeModel testChallenge({
  String id = 'challenge-1',
  ChallengeStatus status = ChallengeStatus.pending,
  bool isMyTurn = true,
  String currentTurnTeamId = 'team-1',
}) => TeamChallengeModel(
  id: id,
  challengerTeamId: otherTeamId,
  challengerTeamName: 'فريق الصقور',
  challengedTeamId: 'team-1',
  challengedTeamName: 'فريق النجوم',
  proposedDateUtc: testNow.add(const Duration(days: 2)),
  proposedDurationMinutes: 90,
  status: status,
  currentTurnTeamId: currentTurnTeamId,
  isMyTurn: isMyTurn,
);
