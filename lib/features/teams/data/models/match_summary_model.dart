import 'package:json_annotation/json_annotation.dart';

part 'match_summary_model.g.dart';

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

  factory MatchSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$MatchSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchSummaryModelToJson(this);
}
