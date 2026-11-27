import 'package:json_annotation/json_annotation.dart';

import 'explore_venue_card_model.dart';

part 'sponsored_item_model.g.dart';

/// A venue the platform team is promoting (home feed or the top of explore).
/// It must always be shown with the sponsored label so players can tell it
/// apart from the organic results.
@JsonSerializable()
class SponsoredItemModel {
  const SponsoredItemModel({
    required this.label,
    required this.title,
    required this.venue,
  });

  /// Always `sponsored` today; kept so the server can name other kinds later.
  final String label;

  /// The promotional line set by the admin (e.g. «خصم ٢٠٪ للصبح»), or the
  /// venue's name when none was set.
  final String title;
  final ExploreVenueCardModel venue;

  factory SponsoredItemModel.fromJson(Map<String, dynamic> json) =>
      _$SponsoredItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$SponsoredItemModelToJson(this);
}

/// The sponsored block of the home feed: absent (null) while it is switched off.
@JsonSerializable()
class SponsoredSectionModel {
  const SponsoredSectionModel({required this.status, this.items = const []});

  final String status;
  final List<SponsoredItemModel> items;

  factory SponsoredSectionModel.fromJson(Map<String, dynamic> json) =>
      _$SponsoredSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SponsoredSectionModelToJson(this);
}
