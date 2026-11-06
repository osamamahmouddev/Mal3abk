import 'package:json_annotation/json_annotation.dart';

import 'team_discovery_model.dart';

part 'team_discovery_page_model.g.dart';

@JsonSerializable()
class TeamDiscoveryPageModel {
  const TeamDiscoveryPageModel({
    this.items = const [],
    required this.totalCount,
    required this.page,
    required this.pageSize,
  });

  final List<TeamDiscoveryModel> items;
  final int totalCount;
  final int page;
  final int pageSize;

  bool get hasMore => page * pageSize < totalCount;

  factory TeamDiscoveryPageModel.fromJson(Map<String, dynamic> json) =>
      _$TeamDiscoveryPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamDiscoveryPageModelToJson(this);
}
