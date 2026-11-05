import 'package:mal3abk/features/teams/data/models/team_detail_model.dart';
import 'package:mal3abk/features/teams/data/models/team_join_request_model.dart';
import 'package:mal3abk/features/teams/data/models/team_leaderboard_page_model.dart';
import 'package:mal3abk/features/teams/data/models/team_member_model.dart';
import 'package:mal3abk/features/teams/data/models/team_profile_model.dart';
import 'package:mal3abk/features/teams/data/models/team_stats_model.dart';
import 'package:mal3abk/features/teams/data/models/team_summary_model.dart';

const testTeamId = 'team-1';

const teamStats = TeamStatsModel(
  matchesPlayed: 3,
  wins: 2,
  draws: 1,
  losses: 0,
  goalsFor: 9,
  goalsAgainst: 4,
  goalDifference: 5,
  winPercentage: 66.7,
  rating: 1540,
  rank: 4,
);

TeamProfileModel teamProfile({int? callerRole}) => TeamProfileModel(
  id: testTeamId,
  name: 'فريق النجوم',
  city: 'القاهرة',
  governorate: 'القاهرة',
  captainId: 'captain-1',
  isPublic: true,
  isRecruiting: true,
  isOpenForChallenges: true,
  canBeChallenged: callerRole == null,
  isCallerMember: callerRole != null,
  callerRole: callerRole,
  stats: teamStats,
  roster: [
    TeamMemberModel(
      id: 'm-1',
      playerId: 'captain-1',
      role: 1,
      joinedAtUtc: DateTime.utc(2026, 1, 1),
      playerName: 'أحمد سامي',
    ),
    TeamMemberModel(
      id: 'm-2',
      playerId: 'player-2',
      role: 3,
      joinedAtUtc: DateTime.utc(2026, 1, 2),
      playerName: 'كريم عادل',
    ),
  ],
);

final joinRequest = TeamJoinRequestModel(
  id: 'req-1',
  teamId: testTeamId,
  playerId: 'player-9',
  status: 1,
  createdAtUtc: DateTime.utc(2026, 1, 3),
  playerName: 'عمر خالد',
);

const teamDetail = TeamDetailModel(
  id: testTeamId,
  name: 'فريق النجوم',
  city: 'القاهرة',
  governorate: 'القاهرة',
  captainId: 'captain-1',
  inviteCode: 'ABC234',
);

const myTeam = TeamSummaryModel(
  id: testTeamId,
  name: 'فريق النجوم',
  city: 'القاهرة',
  governorate: 'القاهرة',
  captainId: 'captain-1',
  memberCount: 2,
  rating: 1540,
  matchesPlayed: 3,
  isRecruiting: true,
  isOpenForChallenges: true,
  myRole: 1,
);

const emptyLeaderboard = TeamLeaderboardPageModel(
  totalCount: 0,
  page: 1,
  pageSize: 20,
);
