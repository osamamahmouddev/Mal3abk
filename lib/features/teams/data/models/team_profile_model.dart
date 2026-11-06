import 'package:json_annotation/json_annotation.dart';

import 'match_summary_model.dart';
import 'team_member_model.dart';
import 'team_stats_model.dart';

part 'team_profile_model.g.dart';

@JsonSerializable()
class TeamProfileModel {
  const TeamProfileModel({
    required this.id,
    required this.name,
    this.description,
    this.logoUrl,
    required this.city,
    required this.governorate,
    this.district,
    required this.captainId,
    required this.isPublic,
    required this.isRecruiting,
    required this.isOpenForChallenges,
    required this.canBeChallenged,
    required this.isCallerMember,
    this.callerRole,
    this.inviteCode,
    required this.stats,
    this.roster = const [],
    this.recentMatches = const [],
    this.upcomingMatches = const [],
  });

  final String id;
  final String name;
  final String? description;
  final String? logoUrl;
  final String city;
  final String governorate;
  final String? district;
  final String captainId;
  final bool isPublic;
  final bool isRecruiting;
  final bool isOpenForChallenges;
  final bool canBeChallenged;
  final bool isCallerMember;
  final int? callerRole;
  final String? inviteCode;
  final TeamStatsModel stats;
  final List<TeamMemberModel> roster;
  final List<MatchSummaryModel> recentMatches;
  final List<MatchSummaryModel> upcomingMatches;

  bool get isCaptain => callerRole == 1;
  bool get isLeader => callerRole == 1 || callerRole == 2;

  factory TeamProfileModel.fromJson(Map<String, dynamic> json) =>
      _$TeamProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamProfileModelToJson(this);
}
