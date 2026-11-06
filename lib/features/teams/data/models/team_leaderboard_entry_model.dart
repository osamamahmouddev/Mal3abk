import 'package:json_annotation/json_annotation.dart';

part 'team_leaderboard_entry_model.g.dart';

@JsonSerializable()
class TeamLeaderboardEntryModel {
  const TeamLeaderboardEntryModel({
    required this.rank,
    required this.teamId,
    required this.name,
    this.logoUrl,
    required this.city,
    required this.governorate,
    required this.rating,
    required this.matchesPlayed,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.points,
    required this.goalDifference,
    required this.winPercentage,
  });

  final int rank;
  final String teamId;
  final String name;
  final String? logoUrl;
  final String city;
  final String governorate;
  final double rating;
  final int matchesPlayed;
  final int wins;
  final int draws;
  final int losses;
  final int points;
  final int goalDifference;
  final double winPercentage;

  factory TeamLeaderboardEntryModel.fromJson(Map<String, dynamic> json) =>
      _$TeamLeaderboardEntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamLeaderboardEntryModelToJson(this);
}
