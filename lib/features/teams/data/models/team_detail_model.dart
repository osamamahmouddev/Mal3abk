import 'package:json_annotation/json_annotation.dart';

part 'team_detail_model.g.dart';

@JsonSerializable()
class TeamDetailModel {
  const TeamDetailModel({
    required this.id,
    required this.name,
    required this.city,
    required this.governorate,
    required this.captainId,
    this.inviteCode,
    this.inviteCodeExpiresAtUtc,
  });

  final String id;
  final String name;
  final String city;
  final String governorate;
  final String captainId;
  final String? inviteCode;
  final DateTime? inviteCodeExpiresAtUtc;

  factory TeamDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TeamDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamDetailModelToJson(this);
}
