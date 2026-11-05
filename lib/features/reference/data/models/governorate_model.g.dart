// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'governorate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GovernorateModel _$GovernorateModelFromJson(Map<String, dynamic> json) =>
    GovernorateModel(
      code: json['code'] as String,
      nameAr: json['nameAr'] as String,
      nameEn: json['nameEn'] as String,
      areas:
          (json['areas'] as List<dynamic>?)
              ?.map(
                (e) => LocalizedItemModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GovernorateModelToJson(GovernorateModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'nameAr': instance.nameAr,
      'nameEn': instance.nameEn,
      'areas': instance.areas,
    };
