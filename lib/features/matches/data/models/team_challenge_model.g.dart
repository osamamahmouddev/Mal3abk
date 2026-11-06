// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamChallengeModel _$TeamChallengeModelFromJson(Map<String, dynamic> json) =>
    TeamChallengeModel(
      id: json['id'] as String,
      challengerTeamId: json['challengerTeamId'] as String,
      challengerTeamName: json['challengerTeamName'] as String?,
      challengedTeamId: json['challengedTeamId'] as String,
      challengedTeamName: json['challengedTeamName'] as String?,
      proposedDateUtc: DateTime.parse(json['proposedDateUtc'] as String),
      proposedDurationMinutes: (json['proposedDurationMinutes'] as num).toInt(),
      proposedVenueName: json['proposedVenueName'] as String?,
      notes: json['notes'] as String?,
      status: $enumDecode(_$ChallengeStatusEnumMap, json['status']),
      currentTurnTeamId: json['currentTurnTeamId'] as String,
      isMyTurn: json['isMyTurn'] as bool,
      declinedReason: json['declinedReason'] as String?,
      matchId: json['matchId'] as String?,
    );

Map<String, dynamic> _$TeamChallengeModelToJson(TeamChallengeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'challengerTeamId': instance.challengerTeamId,
      'challengerTeamName': instance.challengerTeamName,
      'challengedTeamId': instance.challengedTeamId,
      'challengedTeamName': instance.challengedTeamName,
      'proposedDateUtc': instance.proposedDateUtc.toIso8601String(),
      'proposedDurationMinutes': instance.proposedDurationMinutes,
      'proposedVenueName': instance.proposedVenueName,
      'notes': instance.notes,
      'status': _$ChallengeStatusEnumMap[instance.status]!,
      'currentTurnTeamId': instance.currentTurnTeamId,
      'isMyTurn': instance.isMyTurn,
      'declinedReason': instance.declinedReason,
      'matchId': instance.matchId,
    };

const _$ChallengeStatusEnumMap = {
  ChallengeStatus.pending: 1,
  ChallengeStatus.counterProposed: 2,
  ChallengeStatus.accepted: 3,
  ChallengeStatus.declined: 4,
  ChallengeStatus.cancelled: 5,
  ChallengeStatus.expired: 6,
};
