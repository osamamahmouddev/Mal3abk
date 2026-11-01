// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pitch_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PitchDetailsModel _$PitchDetailsModelFromJson(
  Map<String, dynamic> json,
) => PitchDetailsModel(
  pitchId: json['pitchId'] as String,
  name: json['name'] as String,
  pitchType: json['pitchType'] as String,
  playersPerTeam: (json['playersPerTeam'] as num).toInt(),
  surface: LocalizedItemModel.fromJson(json['surface'] as Map<String, dynamic>),
  lengthMeters: (json['lengthMeters'] as num?)?.toDouble(),
  widthMeters: (json['widthMeters'] as num?)?.toDouble(),
  photos:
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  baseHourlyPrice: (json['baseHourlyPrice'] as num?)?.toDouble(),
  currency: json['currency'] as String? ?? 'EGP',
  customHours: (json['customHours'] as List<dynamic>?)
      ?.map((e) => OpeningHoursDayModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PitchDetailsModelToJson(PitchDetailsModel instance) =>
    <String, dynamic>{
      'pitchId': instance.pitchId,
      'name': instance.name,
      'pitchType': instance.pitchType,
      'playersPerTeam': instance.playersPerTeam,
      'surface': instance.surface.toJson(),
      'lengthMeters': instance.lengthMeters,
      'widthMeters': instance.widthMeters,
      'photos': instance.photos,
      'baseHourlyPrice': instance.baseHourlyPrice,
      'currency': instance.currency,
      if (instance.customHours != null)
        'customHours': instance.customHours?.map((e) => e.toJson()).toList(),
    };
