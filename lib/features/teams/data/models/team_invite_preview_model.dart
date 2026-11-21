import 'package:json_annotation/json_annotation.dart';

part 'team_invite_preview_model.g.dart';

/// The team behind an invite code, shown before the player chooses to join.
@JsonSerializable()
class TeamInvitePreviewModel {
  const TeamInvitePreviewModel({
    required this.teamId,
    required this.name,
    required this.city,
    required this.governorate,
    this.logoUrl,
    this.district,
    this.memberCount = 0,
    this.maxMembers = 25,
    this.expiresAtUtc,
    this.isAlreadyMember = false,
  });

  final String teamId;
  final String name;
  final String? logoUrl;
  final String city;
  final String governorate;
  final String? district;
  final int memberCount;
  final int maxMembers;
  final DateTime? expiresAtUtc;
  final bool isAlreadyMember;

  bool get isFull => memberCount >= maxMembers;

  factory TeamInvitePreviewModel.fromJson(Map<String, dynamic> json) =>
      _$TeamInvitePreviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamInvitePreviewModelToJson(this);
}
