import 'package:json_annotation/json_annotation.dart';

import 'team_leaderboard_entry_model.dart';

part 'team_leaderboard_page_model.g.dart';

@JsonSerializable()
class TeamLeaderboardPageModel {
  const TeamLeaderboardPageModel({
    this.items = const [],
    required this.totalCount,
    required this.page,
    required this.pageSize,
  });

  final List<TeamLeaderboardEntryModel> items;
  final int totalCount;
  final int page;
  final int pageSize;

  bool get hasMore => page * pageSize < totalCount;

  factory TeamLeaderboardPageModel.fromJson(Map<String, dynamic> json) =>
      _$TeamLeaderboardPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamLeaderboardPageModelToJson(this);
}
