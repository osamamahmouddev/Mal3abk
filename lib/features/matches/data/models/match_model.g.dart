// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchModel _$MatchModelFromJson(Map<String, dynamic> json) => MatchModel(
  id: json['id'] as String,
  challengeId: json['challengeId'] as String?,
  homeTeamId: json['homeTeamId'] as String,
  homeTeamName: json['homeTeamName'] as String,
  awayTeamId: json['awayTeamId'] as String,
  awayTeamName: json['awayTeamName'] as String,
  venueName: json['venueName'] as String?,
  scheduledStartUtc: DateTime.parse(json['scheduledStartUtc'] as String),
  scheduledEndUtc: DateTime.parse(json['scheduledEndUtc'] as String),
  durationMinutes: (json['durationMinutes'] as num).toInt(),
  bookingId: json['bookingId'] as String?,
  status: json['status'] as String,
  outcome: json['outcome'] as String,
  homeScore: (json['homeScore'] as num?)?.toInt(),
  awayScore: (json['awayScore'] as num?)?.toInt(),
  resultStatus: json['resultStatus'] as String,
  resultSubmittedByTeamId: json['resultSubmittedByTeamId'] as String?,
  disputeReason: json['disputeReason'] as String?,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$MatchModelToJson(MatchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'challengeId': instance.challengeId,
      'homeTeamId': instance.homeTeamId,
      'homeTeamName': instance.homeTeamName,
      'awayTeamId': instance.awayTeamId,
      'awayTeamName': instance.awayTeamName,
      'venueName': instance.venueName,
      'scheduledStartUtc': instance.scheduledStartUtc.toIso8601String(),
      'scheduledEndUtc': instance.scheduledEndUtc.toIso8601String(),
      'durationMinutes': instance.durationMinutes,
      'bookingId': instance.bookingId,
      'status': instance.status,
      'outcome': instance.outcome,
      'homeScore': instance.homeScore,
      'awayScore': instance.awayScore,
      'resultStatus': instance.resultStatus,
      'resultSubmittedByTeamId': instance.resultSubmittedByTeamId,
      'disputeReason': instance.disputeReason,
      'notes': instance.notes,
    };
