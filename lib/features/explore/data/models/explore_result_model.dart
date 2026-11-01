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
  });

  final List<ExploreVenueCardModel> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasMore;

  factory ExploreResultModel.fromJson(Map<String, dynamic> json) =>
      _$ExploreResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExploreResultModelToJson(this);
}
