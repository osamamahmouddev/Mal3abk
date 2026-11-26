// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_venue_pin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapVenuePinModel _$MapVenuePinModelFromJson(Map<String, dynamic> json) =>
    MapVenuePinModel(
      venueId: json['venueId'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      coverPhotoUrl: json['coverPhotoUrl'] as String?,
      fromHourlyPrice: (json['fromHourlyPrice'] as num?)?.toDouble(),
      currency: json['currency'] as String? ?? 'EGP',
      nextAvailableStartUtc: json['nextAvailableStartUtc'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$MapVenuePinModelToJson(MapVenuePinModel instance) =>
    <String, dynamic>{
      'venueId': instance.venueId,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'coverPhotoUrl': instance.coverPhotoUrl,
      'fromHourlyPrice': instance.fromHourlyPrice,
      'currency': instance.currency,
      'nextAvailableStartUtc': instance.nextAvailableStartUtc,
      'isFavorite': instance.isFavorite,
    };

MapSearchResultModel _$MapSearchResultModelFromJson(
  Map<String, dynamic> json,
) => MapSearchResultModel(
  pins:
      (json['pins'] as List<dynamic>?)
          ?.map((e) => MapVenuePinModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  totalCount: (json['totalCount'] as num).toInt(),
  truncated: json['truncated'] as bool,
);

Map<String, dynamic> _$MapSearchResultModelToJson(
  MapSearchResultModel instance,
) => <String, dynamic>{
  'pins': instance.pins,
  'totalCount': instance.totalCount,
  'truncated': instance.truncated,
};
