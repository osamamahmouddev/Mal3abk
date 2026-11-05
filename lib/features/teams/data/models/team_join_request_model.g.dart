// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_join_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamJoinRequestModel _$TeamJoinRequestModelFromJson(
  Map<String, dynamic> json,
) => TeamJoinRequestModel(
  id: json['id'] as String,
  teamId: json['teamId'] as String,
  playerId: json['playerId'] as String,
  message: json['message'] as String?,
  status: (json['status'] as num).toInt(),
  createdAtUtc: DateTime.parse(json['createdAtUtc'] as String),
  playerName: json['playerName'] as String?,
);

Map<String, dynamic> _$TeamJoinRequestModelToJson(
  TeamJoinRequestModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'teamId': instance.teamId,
  'playerId': instance.playerId,
  'message': instance.message,
  'status': instance.status,
  'createdAtUtc': instance.createdAtUtc.toIso8601String(),
  'playerName': instance.playerName,
};
