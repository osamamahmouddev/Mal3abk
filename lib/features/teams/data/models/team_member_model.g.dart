// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamMemberModel _$TeamMemberModelFromJson(Map<String, dynamic> json) =>
    TeamMemberModel(
      id: json['id'] as String,
      playerId: json['playerId'] as String,
      role: (json['role'] as num).toInt(),
      jerseyNumber: (json['jerseyNumber'] as num?)?.toInt(),
      position: json['position'] as String?,
      joinedAtUtc: DateTime.parse(json['joinedAtUtc'] as String),
      playerName: json['playerName'] as String?,
    );

Map<String, dynamic> _$TeamMemberModelToJson(TeamMemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerId': instance.playerId,
      'role': instance.role,
      'jerseyNumber': instance.jerseyNumber,
      'position': instance.position,
      'joinedAtUtc': instance.joinedAtUtc.toIso8601String(),
      'playerName': instance.playerName,
    };
