// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueModel _$VenueModelFromJson(Map<String, dynamic> json) => VenueModel(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String,
  city: json['city'] as String,
  area: json['area'] as String,
  phoneNumber: json['phoneNumber'] as String,
  approvalStatus: json['approvalStatus'] as String,
  isApproved: json['isApproved'] as bool,
  isPublished: json['isPublished'] as bool,
  description: json['description'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  facilities:
      (json['facilities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  photos:
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  pitches:
      (json['pitches'] as List<dynamic>?)
          ?.map((e) => VenuePitchModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pricingModel: json['pricingModel'] as String? ?? 'Commission',
  commissionType: json['commissionType'] as String?,
  commissionRate: (json['commissionRate'] as num?)?.toDouble(),
);
