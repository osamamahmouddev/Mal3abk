// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamSummaryModel _$TeamSummaryModelFromJson(Map<String, dynamic> json) =>
    TeamSummaryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      logoUrl: json['logoUrl'] as String?,
      city: json['city'] as String,
      governorate: json['governorate'] as String,
      captainId: json['captainId'] as String,
      memberCount: (json['memberCount'] as num).toInt(),
      rating: (json['rating'] as num).toDouble(),
      matchesPlayed: (json['matchesPlayed'] as num).toInt(),
      isRecruiting: json['isRecruiting'] as bool,
      isOpenForChallenges: json['isOpenForChallenges'] as bool,
      myRole: (json['myRole'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TeamSummaryModelToJson(TeamSummaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logoUrl': instance.logoUrl,
      'city': instance.city,
      'governorate': instance.governorate,
      'captainId': instance.captainId,
      'memberCount': instance.memberCount,
      'rating': instance.rating,
      'matchesPlayed': instance.matchesPlayed,
      'isRecruiting': instance.isRecruiting,
      'isOpenForChallenges': instance.isOpenForChallenges,
      'myRole': instance.myRole,
    };
