import 'package:json_annotation/json_annotation.dart';

part 'map_venue_pin_model.g.dart';

@JsonSerializable()
class MapVenuePinModel {
  const MapVenuePinModel({
    required this.venueId,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.coverPhotoUrl,
    this.fromHourlyPrice,
    this.currency = 'EGP',
    this.nextAvailableStartUtc,
    this.isFavorite = false,
  });

  final String venueId;
  final String name;
  final double latitude;
  final double longitude;
  final String? coverPhotoUrl;
  final double? fromHourlyPrice;
  final String currency;
  final String? nextAvailableStartUtc;
  final bool isFavorite;

  factory MapVenuePinModel.fromJson(Map<String, dynamic> json) =>
      _$MapVenuePinModelFromJson(json);

  Map<String, dynamic> toJson() => _$MapVenuePinModelToJson(this);
}

@JsonSerializable()
class MapSearchResultModel {
  const MapSearchResultModel({
    this.pins = const [],
    required this.totalCount,
    required this.truncated,
  });

  final List<MapVenuePinModel> pins;
  final int totalCount;

  /// More venues match than the map shows; the player should zoom in.
  final bool truncated;

  factory MapSearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$MapSearchResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$MapSearchResultModelToJson(this);
}
