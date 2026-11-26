// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_pitch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenuePitchModel _$VenuePitchModelFromJson(
  Map<String, dynamic> json,
) => VenuePitchModel(
  id: json['id'] as String,
  venueId: json['venueId'] as String,
  name: json['name'] as String,
  turfType: json['turfType'] as String,
  capacity: (json['capacity'] as num).toInt(),
  format: json['format'] as String,
  isActive: json['isActive'] as bool,
  surfaceArabicDisplayName: json['surfaceArabicDisplayName'] as String? ?? '',
  surfaceDisplayName: json['surfaceDisplayName'] as String? ?? '',
  lengthMeters: (json['lengthMeters'] as num?)?.toDouble(),
  widthMeters: (json['widthMeters'] as num?)?.toDouble(),
  photos:
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);
