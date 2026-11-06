// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respond_to_challenge_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RespondToChallengeRequestBody _$RespondToChallengeRequestBodyFromJson(
  Map<String, dynamic> json,
) => RespondToChallengeRequestBody(
  respondingTeamId: json['respondingTeamId'] as String,
  action: $enumDecode(_$ChallengeResponseActionEnumMap, json['action']),
  newProposedDateUtc: json['newProposedDateUtc'] == null
      ? null
      : DateTime.parse(json['newProposedDateUtc'] as String),
  newDurationMinutes: (json['newDurationMinutes'] as num?)?.toInt(),
  declineReason: json['declineReason'] as String?,
);

Map<String, dynamic> _$RespondToChallengeRequestBodyToJson(
  RespondToChallengeRequestBody instance,
) => <String, dynamic>{
  'respondingTeamId': instance.respondingTeamId,
  'action': _$ChallengeResponseActionEnumMap[instance.action]!,
  'newProposedDateUtc': ?instance.newProposedDateUtc?.toIso8601String(),
  'newDurationMinutes': ?instance.newDurationMinutes,
  'declineReason': ?instance.declineReason,
};

const _$ChallengeResponseActionEnumMap = {
  ChallengeResponseAction.accept: 1,
  ChallengeResponseAction.decline: 2,
  ChallengeResponseAction.counterPropose: 3,
};
