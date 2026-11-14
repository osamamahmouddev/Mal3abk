import '../../../../core/location/location_service.dart';
import 'home_feed_model.dart';

/// The home feed together with the place it was loaded for. [city] and [area]
/// are null for all of Egypt; [near] is set when it is for the player's own
/// location.
class LocatedHomeFeedModel {
  const LocatedHomeFeedModel({
    required this.feed,
    this.city,
    this.area,
    this.near,
  });

  final HomeFeedModel feed;
  final String? city;
  final String? area;
  final GeoPoint? near;
}
