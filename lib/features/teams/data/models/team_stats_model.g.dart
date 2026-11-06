// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamStatsModel _$TeamStatsModelFromJson(Map<String, dynamic> json) =>
    TeamStatsModel(
      matchesPlayed: (json['matchesPlayed'] as num).toInt(),
      wins: (json['wins'] as num).toInt(),
      draws: (json['draws'] as num).toInt(),
      losses: (json['losses'] as num).toInt(),
      goalsFor: (json['goalsFor'] as num).toInt(),
      goalsAgainst: (json['goalsAgainst'] as num).toInt(),
      goalDifference: (json['goalDifference'] as num).toInt(),
      winPercentage: (json['winPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      rank: (json['rank'] as num).toInt(),
    );

Map<String, dynamic> _$TeamStatsModelToJson(TeamStatsModel instance) =>
    <String, dynamic>{
      'matchesPlayed': instance.matchesPlayed,
      'wins': instance.wins,
      'draws': instance.draws,
      'losses': instance.losses,
      'goalsFor': instance.goalsFor,
      'goalsAgainst': instance.goalsAgainst,
      'goalDifference': instance.goalDifference,
      'winPercentage': instance.winPercentage,
      'rating': instance.rating,
      'rank': instance.rank,
    };
