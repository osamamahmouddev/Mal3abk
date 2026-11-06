import 'package:json_annotation/json_annotation.dart';

part 'team_discovery_model.g.dart';

@JsonSerializable()
class TeamDiscoveryModel {
  const TeamDiscoveryModel({
    required this.id,
    required this.name,
    this.description,
    this.logoUrl,
    required this.city,
    required this.governorate,
    this.district,
    required this.rating,
    required this.memberCount,
    required this.matchesPlayed,
    required this.isRecruiting,
    required this.isOpenForChallenges,
    required this.canBeChallenged,
  });

  final String id;
  final String name;
  final String? description;
  final String? logoUrl;
  final String city;
  final String governorate;
  final String? district;
  final double rating;
  final int memberCount;
  final int matchesPlayed;
  final bool isRecruiting;
  final bool isOpenForChallenges;
  final bool canBeChallenged;

  factory TeamDiscoveryModel.fromJson(Map<String, dynamic> json) =>
      _$TeamDiscoveryModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamDiscoveryModelToJson(this);
}
