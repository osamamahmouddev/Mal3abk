// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueDetailsModel _$VenueDetailsModelFromJson(
  Map<String, dynamic> json,
) => VenueDetailsModel(
  venueId: json['venueId'] as String,
  name: json['name'] as String,
  slug: json['slug'] as String,
  description: json['description'] as String?,
  address: json['address'] as String,
  city: json['city'] as String,
  area: json['area'] as String,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  photos:
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  facilities:
      (json['facilities'] as List<dynamic>?)
          ?.map((e) => LocalizedItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  openingHours:
      (json['openingHours'] as List<dynamic>?)
          ?.map((e) => OpeningHoursDayModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  fromHourlyPrice: (json['fromHourlyPrice'] as num?)?.toDouble(),
  currency: json['currency'] as String? ?? 'EGP',
  depositPolicy: json['depositPolicy'] == null
      ? null
      : PublicDepositPolicyModel.fromJson(
          json['depositPolicy'] as Map<String, dynamic>,
        ),
  pitchCount: (json['pitchCount'] as num?)?.toInt() ?? 0,
  pitchTypes:
      (json['pitchTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  favoritesCount: (json['favoritesCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$VenueDetailsModelToJson(VenueDetailsModel instance) =>
    <String, dynamic>{
      'venueId': instance.venueId,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'address': instance.address,
      'city': instance.city,
      'area': instance.area,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'photos': instance.photos,
      'facilities': instance.facilities.map((e) => e.toJson()).toList(),
      'openingHours': instance.openingHours.map((e) => e.toJson()).toList(),
      'fromHourlyPrice': instance.fromHourlyPrice,
      'currency': instance.currency,
      'depositPolicy': instance.depositPolicy?.toJson(),
      'pitchCount': instance.pitchCount,
      'pitchTypes': instance.pitchTypes,
      'favoritesCount': instance.favoritesCount,
    };
