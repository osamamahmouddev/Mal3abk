import 'package:json_annotation/json_annotation.dart';

import 'match_model.dart';

part 'match_page_model.g.dart';

@JsonSerializable()
class MatchPageModel {
  const MatchPageModel({
    this.items = const [],
    required this.totalCount,
    required this.page,
    required this.pageSize,
  });

  final List<MatchModel> items;
  final int totalCount;
  final int page;
  final int pageSize;

  factory MatchPageModel.fromJson(Map<String, dynamic> json) =>
      _$MatchPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchPageModelToJson(this);
}
