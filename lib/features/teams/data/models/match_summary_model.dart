import 'package:json_annotation/json_annotation.dart';

part 'match_summary_model.g.dart';

enum MatchResultForTeam { win, draw, loss, pending }

@JsonSerializable()
class MatchSummaryModel {
  const MatchSummaryModel({
    required this.matchId,
    required this.homeTeamId,
    required this.homeTeamName,
    required this.awayTeamId,
    required this.awayTeamName,
    this.homeScore,
    this.awayScore,
    required this.status,
    required this.scheduledAtUtc,
  });

  final String matchId;
  final String homeTeamId;
  final String homeTeamName;
  final String awayTeamId;
  final String awayTeamName;
  final int? homeScore;
  final int? awayScore;
  final String status;
  final DateTime scheduledAtUtc;

  /// Result from [teamId]'s side; pending until the result is confirmed.
  MatchResultForTeam resultFor(String teamId) {
    final home = homeScore;
    final away = awayScore;
    if (status != 'Completed' || home == null || away == null) {
      return MatchResultForTeam.pending;
    }
    final mine = teamId == homeTeamId ? home : away;
    final theirs = teamId == homeTeamId ? away : home;
    if (mine == theirs) return MatchResultForTeam.draw;
    return mine > theirs ? MatchResultForTeam.win : MatchResultForTeam.loss;
  }

  String opponentName(String teamId) =>
      teamId == homeTeamId ? awayTeamName : homeTeamName;

  factory MatchSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$MatchSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchSummaryModelToJson(this);
}
