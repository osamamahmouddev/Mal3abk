// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_challenge_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendChallengeRequestBody _$SendChallengeRequestBodyFromJson(
  Map<String, dynamic> json,
) => SendChallengeRequestBody(
  challengerTeamId: json['challengerTeamId'] as String,
  challengedTeamId: json['challengedTeamId'] as String,
  proposedDateUtc: DateTime.parse(json['proposedDateUtc'] as String),
  durationMinutes: (json['durationMinutes'] as num).toInt(),
  proposedVenueName: json['proposedVenueName'] as String?,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$SendChallengeRequestBodyToJson(
  SendChallengeRequestBody instance,
) => <String, dynamic>{
  'challengerTeamId': instance.challengerTeamId,
  'challengedTeamId': instance.challengedTeamId,
  'proposedDateUtc': instance.proposedDateUtc.toIso8601String(),
  'durationMinutes': instance.durationMinutes,
  'proposedVenueName': ?instance.proposedVenueName,
  'notes': ?instance.notes,
};
