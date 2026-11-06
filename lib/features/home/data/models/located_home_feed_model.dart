import 'home_feed_model.dart';

/// The home feed together with the place it was loaded for; [area] and
/// [city] are null when the player hasn't set one.
class LocatedHomeFeedModel {
  const LocatedHomeFeedModel({required this.feed, this.city, this.area});

  final HomeFeedModel feed;
  final String? city;
  final String? area;
}
