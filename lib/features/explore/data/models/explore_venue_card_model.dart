import 'package:json_annotation/json_annotation.dart';

part 'explore_venue_card_model.g.dart';

@JsonSerializable()
class ExploreVenueCardModel {
  const ExploreVenueCardModel({
    required this.venueId,
    required this.name,
    required this.slug,
    required this.city,
    required this.area,
    this.coverPhotoUrl,
    this.latitude,
    this.longitude,
    this.distanceKm,
    this.fromHourlyPrice,
    this.currency = 'EGP',
    this.pitchTypes = const [],
    this.surfaces = const [],
    this.facilities = const [],
    this.favoritesCount = 0,
    this.nextAvailableStartUtc,
    this.isFavorite = false,
  });

  final String venueId;
  final String name;
  final String slug;
  final String city;
  final String area;
  final String? coverPhotoUrl;
  final double? latitude;
  final double? longitude;
  final double? distanceKm;
  final double? fromHourlyPrice;
  final String currency;
  final List<String> pitchTypes;
  final List<String> surfaces;
  final List<String> facilities;
  final int favoritesCount;
  final String? nextAvailableStartUtc;
  final bool isFavorite;

  factory ExploreVenueCardModel.fromJson(Map<String, dynamic> json) =>
      _$ExploreVenueCardModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExploreVenueCardModelToJson(this);
}
