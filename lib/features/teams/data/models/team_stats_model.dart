import 'package:json_annotation/json_annotation.dart';

part 'team_stats_model.g.dart';

@JsonSerializable()
class TeamStatsModel {
  const TeamStatsModel({
    required this.matchesPlayed,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalDifference,
    required this.winPercentage,
    required this.rating,
    required this.rank,
  });

  final int matchesPlayed;
  final int wins;
  final int draws;
  final int losses;
  final int goalsFor;
  final int goalsAgainst;
  final int goalDifference;
  final double winPercentage;
  final double rating;
  final int rank;

  factory TeamStatsModel.fromJson(Map<String, dynamic> json) =>
      _$TeamStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamStatsModelToJson(this);
}
