// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_venue_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExploreVenueCardModel _$ExploreVenueCardModelFromJson(
  Map<String, dynamic> json,
) => ExploreVenueCardModel(
  venueId: json['venueId'] as String,
  name: json['name'] as String,
  slug: json['slug'] as String,
  city: json['city'] as String,
  area: json['area'] as String,
  coverPhotoUrl: json['coverPhotoUrl'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  distanceKm: (json['distanceKm'] as num?)?.toDouble(),
  fromHourlyPrice: (json['fromHourlyPrice'] as num?)?.toDouble(),
  currency: json['currency'] as String? ?? 'EGP',
  pitchTypes:
      (json['pitchTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  surfaces:
      (json['surfaces'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  facilities:
      (json['facilities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  favoritesCount: (json['favoritesCount'] as num?)?.toInt() ?? 0,
  nextAvailableStartUtc: json['nextAvailableStartUtc'] as String?,
  isFavorite: json['isFavorite'] as bool? ?? false,
  offer: json['offer'] == null
      ? null
      : VenueOfferModel.fromJson(json['offer'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ExploreVenueCardModelToJson(
  ExploreVenueCardModel instance,
) => <String, dynamic>{
  'venueId': instance.venueId,
  'name': instance.name,
  'slug': instance.slug,
  'city': instance.city,
  'area': instance.area,
  'coverPhotoUrl': instance.coverPhotoUrl,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'distanceKm': instance.distanceKm,
  'fromHourlyPrice': instance.fromHourlyPrice,
  'currency': instance.currency,
  'pitchTypes': instance.pitchTypes,
  'surfaces': instance.surfaces,
  'facilities': instance.facilities,
  'favoritesCount': instance.favoritesCount,
  'nextAvailableStartUtc': instance.nextAvailableStartUtc,
  'isFavorite': instance.isFavorite,
  'offer': instance.offer,
};
