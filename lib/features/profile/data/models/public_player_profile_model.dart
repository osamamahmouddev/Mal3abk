import 'package:json_annotation/json_annotation.dart';

part 'public_player_profile_model.g.dart';

@JsonSerializable()
class PlayerStatsSummaryModel {
  const PlayerStatsSummaryModel({
    required this.matchesPlayed,
    required this.teamsCount,
  });

  final int matchesPlayed;
  final int teamsCount;

  factory PlayerStatsSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatsSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerStatsSummaryModelToJson(this);
}

@JsonSerializable()
class PublicPlayerProfileModel {
  const PublicPlayerProfileModel({
    required this.userId,
    required this.fullName,
    this.avatarUrl,
    this.city,
    this.positions = const [],
    this.skillLevel,
    this.stats,
  });

  final String userId;
  final String fullName;
  final String? avatarUrl;
  final String? city;
  final List<String> positions;
  final String? skillLevel;
  final PlayerStatsSummaryModel? stats;

  factory PublicPlayerProfileModel.fromJson(Map<String, dynamic> json) =>
      _$PublicPlayerProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$PublicPlayerProfileModelToJson(this);
}
