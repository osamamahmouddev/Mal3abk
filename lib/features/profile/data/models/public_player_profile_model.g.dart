// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_player_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerStatsSummaryModel _$PlayerStatsSummaryModelFromJson(
  Map<String, dynamic> json,
) => PlayerStatsSummaryModel(
  matchesPlayed: (json['matchesPlayed'] as num).toInt(),
  teamsCount: (json['teamsCount'] as num).toInt(),
);

Map<String, dynamic> _$PlayerStatsSummaryModelToJson(
  PlayerStatsSummaryModel instance,
) => <String, dynamic>{
  'matchesPlayed': instance.matchesPlayed,
  'teamsCount': instance.teamsCount,
};

PublicPlayerProfileModel _$PublicPlayerProfileModelFromJson(
  Map<String, dynamic> json,
) => PublicPlayerProfileModel(
  userId: json['userId'] as String,
  fullName: json['fullName'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  city: json['city'] as String?,
  positions:
      (json['positions'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  skillLevel: json['skillLevel'] as String?,
  stats: json['stats'] == null
      ? null
      : PlayerStatsSummaryModel.fromJson(json['stats'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PublicPlayerProfileModelToJson(
  PublicPlayerProfileModel instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'fullName': instance.fullName,
  'avatarUrl': instance.avatarUrl,
  'city': instance.city,
  'positions': instance.positions,
  'skillLevel': instance.skillLevel,
  'stats': instance.stats,
};
