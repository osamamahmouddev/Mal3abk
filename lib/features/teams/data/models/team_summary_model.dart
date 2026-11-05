import 'package:json_annotation/json_annotation.dart';

part 'team_summary_model.g.dart';

@JsonSerializable()
class TeamSummaryModel {
  const TeamSummaryModel({
    required this.id,
    required this.name,
    this.logoUrl,
    required this.city,
    required this.governorate,
    required this.captainId,
    required this.memberCount,
    required this.rating,
    required this.matchesPlayed,
    required this.isRecruiting,
    required this.isOpenForChallenges,
    this.myRole,
  });

  final String id;
  final String name;
  final String? logoUrl;
  final String city;
  final String governorate;
  final String captainId;
  final int memberCount;
  final double rating;
  final int matchesPlayed;
  final bool isRecruiting;
  final bool isOpenForChallenges;
  final int? myRole;

  bool get isCaptain => myRole == 1;
  bool get isLeader => myRole == 1 || myRole == 2;

  factory TeamSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$TeamSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamSummaryModelToJson(this);
}
