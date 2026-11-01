// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProfileModel _$MyProfileModelFromJson(Map<String, dynamic> json) =>
    MyProfileModel(
      userId: json['userId'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String?,
      city: json['city'] as String?,
      area: json['area'] as String?,
      positions:
          (json['positions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      skillLevel: json['skillLevel'] as String?,
      language: json['language'] as String? ?? 'ar',
      onboardingComplete: json['onboardingComplete'] as bool? ?? false,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$MyProfileModelToJson(MyProfileModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'city': instance.city,
      'area': instance.area,
      'positions': instance.positions,
      'skillLevel': instance.skillLevel,
      'language': instance.language,
      'onboardingComplete': instance.onboardingComplete,
      'avatarUrl': instance.avatarUrl,
    };
