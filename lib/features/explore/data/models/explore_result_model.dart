import 'package:json_annotation/json_annotation.dart';
import 'explore_venue_card_model.dart';

part 'explore_result_model.g.dart';

@JsonSerializable()
class ExploreResultModel {
  const ExploreResultModel({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasMore,
    this.suggestions = const [],
  });

  final List<ExploreVenueCardModel> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasMore;

  /// Sent when nothing matched: each relaxes one filter and says how many
  /// venues it would bring back, most first.
  @JsonKey(defaultValue: <ExploreSuggestionModel>[])
  final List<ExploreSuggestionModel> suggestions;

  factory ExploreResultModel.fromJson(Map<String, dynamic> json) =>
      _$ExploreResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExploreResultModelToJson(this);
}

/// One way out of an empty search, from the API (`code`: widen_radius,
/// any_time, any_date, any_budget, any_pitch, fewer_facilities, any_area).
@JsonSerializable()
class ExploreSuggestionModel {
  const ExploreSuggestionModel({required this.code, required this.matchCount});

  final String code;
  final int matchCount;

  factory ExploreSuggestionModel.fromJson(Map<String, dynamic> json) =>
      _$ExploreSuggestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExploreSuggestionModelToJson(this);
}
