// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_discovery_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamDiscoveryModel _$TeamDiscoveryModelFromJson(Map<String, dynamic> json) =>
    TeamDiscoveryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      logoUrl: json['logoUrl'] as String?,
      city: json['city'] as String,
      governorate: json['governorate'] as String,
      district: json['district'] as String?,
      rating: (json['rating'] as num).toDouble(),
      memberCount: (json['memberCount'] as num).toInt(),
      matchesPlayed: (json['matchesPlayed'] as num).toInt(),
      isRecruiting: json['isRecruiting'] as bool,
      isOpenForChallenges: json['isOpenForChallenges'] as bool,
      canBeChallenged: json['canBeChallenged'] as bool,
    );

Map<String, dynamic> _$TeamDiscoveryModelToJson(TeamDiscoveryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'logoUrl': instance.logoUrl,
      'city': instance.city,
      'governorate': instance.governorate,
      'district': instance.district,
      'rating': instance.rating,
      'memberCount': instance.memberCount,
      'matchesPlayed': instance.matchesPlayed,
      'isRecruiting': instance.isRecruiting,
      'isOpenForChallenges': instance.isOpenForChallenges,
      'canBeChallenged': instance.canBeChallenged,
    };
