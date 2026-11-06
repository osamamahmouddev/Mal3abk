import 'package:json_annotation/json_annotation.dart';
import '../../../explore/data/models/explore_venue_card_model.dart';

part 'home_feed_model.g.dart';

@JsonSerializable()
class HomeSectionModel {
  const HomeSectionModel({required this.status, this.items = const []});

  final String status;
  final List<ExploreVenueCardModel> items;

  factory HomeSectionModel.fromJson(Map<String, dynamic> json) =>
      _$HomeSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeSectionModelToJson(this);
}

@JsonSerializable()
class HomeFeedModel {
  const HomeFeedModel({
    required this.nearby,
    required this.popularNearYou,
    required this.recentlyViewed,
    required this.generatedAtUtc,
  });

  final HomeSectionModel nearby;
  final HomeSectionModel popularNearYou;
  final HomeSectionModel recentlyViewed;
  final String generatedAtUtc;

  factory HomeFeedModel.fromJson(Map<String, dynamic> json) =>
      _$HomeFeedModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeFeedModelToJson(this);
}
