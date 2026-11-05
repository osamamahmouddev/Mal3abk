// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_leaderboard_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamLeaderboardEntryModel _$TeamLeaderboardEntryModelFromJson(
  Map<String, dynamic> json,
) => TeamLeaderboardEntryModel(
  rank: (json['rank'] as num).toInt(),
  teamId: json['teamId'] as String,
  name: json['name'] as String,
  logoUrl: json['logoUrl'] as String?,
  city: json['city'] as String,
  governorate: json['governorate'] as String,
  rating: (json['rating'] as num).toDouble(),
  matchesPlayed: (json['matchesPlayed'] as num).toInt(),
  wins: (json['wins'] as num).toInt(),
  draws: (json['draws'] as num).toInt(),
  losses: (json['losses'] as num).toInt(),
  points: (json['points'] as num).toInt(),
  goalDifference: (json['goalDifference'] as num).toInt(),
  winPercentage: (json['winPercentage'] as num).toDouble(),
);

Map<String, dynamic> _$TeamLeaderboardEntryModelToJson(
  TeamLeaderboardEntryModel instance,
) => <String, dynamic>{
  'rank': instance.rank,
  'teamId': instance.teamId,
  'name': instance.name,
  'logoUrl': instance.logoUrl,
  'city': instance.city,
  'governorate': instance.governorate,
  'rating': instance.rating,
  'matchesPlayed': instance.matchesPlayed,
  'wins': instance.wins,
  'draws': instance.draws,
  'losses': instance.losses,
  'points': instance.points,
  'goalDifference': instance.goalDifference,
  'winPercentage': instance.winPercentage,
};
