// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamProfileModel _$TeamProfileModelFromJson(
  Map<String, dynamic> json,
) => TeamProfileModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  logoUrl: json['logoUrl'] as String?,
  city: json['city'] as String,
  governorate: json['governorate'] as String,
  district: json['district'] as String?,
  captainId: json['captainId'] as String,
  isPublic: json['isPublic'] as bool,
  isRecruiting: json['isRecruiting'] as bool,
  isOpenForChallenges: json['isOpenForChallenges'] as bool,
  canBeChallenged: json['canBeChallenged'] as bool,
  isCallerMember: json['isCallerMember'] as bool,
  callerRole: (json['callerRole'] as num?)?.toInt(),
  inviteCode: json['inviteCode'] as String?,
  stats: TeamStatsModel.fromJson(json['stats'] as Map<String, dynamic>),
  roster:
      (json['roster'] as List<dynamic>?)
          ?.map((e) => TeamMemberModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  recentMatches:
      (json['recentMatches'] as List<dynamic>?)
          ?.map((e) => MatchSummaryModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  upcomingMatches:
      (json['upcomingMatches'] as List<dynamic>?)
          ?.map((e) => MatchSummaryModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$TeamProfileModelToJson(TeamProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'logoUrl': instance.logoUrl,
      'city': instance.city,
      'governorate': instance.governorate,
      'district': instance.district,
      'captainId': instance.captainId,
      'isPublic': instance.isPublic,
      'isRecruiting': instance.isRecruiting,
      'isOpenForChallenges': instance.isOpenForChallenges,
      'canBeChallenged': instance.canBeChallenged,
      'isCallerMember': instance.isCallerMember,
      'callerRole': instance.callerRole,
      'inviteCode': instance.inviteCode,
      'stats': instance.stats,
      'roster': instance.roster,
      'recentMatches': instance.recentMatches,
      'upcomingMatches': instance.upcomingMatches,
    };
