// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchSummaryModel _$MatchSummaryModelFromJson(Map<String, dynamic> json) =>
    MatchSummaryModel(
      matchId: json['matchId'] as String,
      homeTeamId: json['homeTeamId'] as String,
      homeTeamName: json['homeTeamName'] as String,
      awayTeamId: json['awayTeamId'] as String,
      awayTeamName: json['awayTeamName'] as String,
      homeScore: (json['homeScore'] as num?)?.toInt(),
      awayScore: (json['awayScore'] as num?)?.toInt(),
      status: json['status'] as String,
      scheduledAtUtc: DateTime.parse(json['scheduledAtUtc'] as String),
    );

Map<String, dynamic> _$MatchSummaryModelToJson(MatchSummaryModel instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'homeTeamId': instance.homeTeamId,
      'homeTeamName': instance.homeTeamName,
      'awayTeamId': instance.awayTeamId,
      'awayTeamName': instance.awayTeamName,
      'homeScore': instance.homeScore,
      'awayScore': instance.awayScore,
      'status': instance.status,
      'scheduledAtUtc': instance.scheduledAtUtc.toIso8601String(),
    };
