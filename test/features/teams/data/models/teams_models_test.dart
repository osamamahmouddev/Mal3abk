import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/teams/data/models/team_detail_model.dart';
import 'package:mal3abk/features/teams/data/models/team_discovery_page_model.dart';
import 'package:mal3abk/features/teams/data/models/team_invitation_model.dart';
import 'package:mal3abk/features/teams/data/models/team_join_request_model.dart';
import 'package:mal3abk/features/teams/data/models/team_leaderboard_page_model.dart';
import 'package:mal3abk/features/teams/data/models/team_member_model.dart';
import 'package:mal3abk/features/teams/data/models/team_profile_model.dart';
import 'package:mal3abk/features/teams/data/models/team_summary_model.dart';

import '../../../../helpers/teams_fixtures.dart';

TeamSummaryModel _summary(int? role) => TeamSummaryModel(
  id: testTeamId,
  name: 'x',
  city: 'c',
  governorate: 'g',
  captainId: 'cap',
  memberCount: 1,
  rating: 1500,
  matchesPlayed: 0,
  isRecruiting: true,
  isOpenForChallenges: true,
  myRole: role,
);

TeamMemberModel _member(int role) => TeamMemberModel(
  id: 'm',
  playerId: 'p',
  role: role,
  joinedAtUtc: DateTime.utc(2026),
);

void main() {
  // Server roles: Captain = 1, ViceCaptain = 2, Member = 3, none = visitor.
  group('who leads a team', () {
    final cases = {
      1: (captain: true, leader: true),
      2: (captain: false, leader: true),
      3: (captain: false, leader: false),
      null: (captain: false, leader: false),
      0: (captain: false, leader: false),
      4: (captain: false, leader: false),
    };

    cases.forEach((role, expected) {
      test('profile callerRole $role', () {
        final p = teamProfile(callerRole: role);
        expect(p.isCaptain, expected.captain);
        expect(p.isLeader, expected.leader);
      });
      test('summary myRole $role', () {
        final s = _summary(role);
        expect(s.isCaptain, expected.captain);
        expect(s.isLeader, expected.leader);
      });
    });

    test('member role 1 is the captain only', () {
      expect(_member(1).isCaptain, isTrue);
      expect(_member(1).isViceCaptain, isFalse);
    });
    test('member role 2 is the vice-captain only', () {
      expect(_member(2).isCaptain, isFalse);
      expect(_member(2).isViceCaptain, isTrue);
    });
    test('member role 3 is neither', () {
      expect(_member(3).isCaptain, isFalse);
      expect(_member(3).isViceCaptain, isFalse);
    });
  });

  group('paging', () {
    final cases = {
      (page: 1, size: 20, total: 0): false,
      (page: 1, size: 20, total: 20): false,
      (page: 1, size: 20, total: 21): true,
      (page: 2, size: 20, total: 40): false,
      (page: 2, size: 20, total: 41): true,
      (page: 3, size: 10, total: 25): false,
    };
    cases.forEach((p, hasMore) {
      test('discovery page ${p.page}×${p.size} of ${p.total}', () {
        expect(
          TeamDiscoveryPageModel(
            totalCount: p.total,
            page: p.page,
            pageSize: p.size,
          ).hasMore,
          hasMore,
        );
      });
      test('leaderboard page ${p.page}×${p.size} of ${p.total}', () {
        expect(
          TeamLeaderboardPageModel(
            totalCount: p.total,
            page: p.page,
            pageSize: p.size,
          ).hasMore,
          hasMore,
        );
      });
    });
  });

  group('server payloads parse', () {
    test('team detail from create / accept', () {
      final d = TeamDetailModel.fromJson({
        'id': 'a7718a77-13bd-4616-a18d-4629c008d240',
        'name': 'Test FC',
        'slug': 'test-fc',
        'city': 'Cairo',
        'governorate': 'Cairo',
        'captainId': 'c1',
        'inviteCode': 'LFSBPH',
        'inviteCodeExpiresAtUtc': null,
        'members': <Object>[],
      });
      expect(d.inviteCode, 'LFSBPH');
      expect(d.inviteCodeExpiresAtUtc, isNull);
    });

    test('team detail for a non-member hides the code', () {
      final d = TeamDetailModel.fromJson({
        'id': 't',
        'name': 'n',
        'city': 'c',
        'governorate': 'g',
        'captainId': 'cap',
        'inviteCode': null,
      });
      expect(d.inviteCode, isNull);
    });

    test('invitation with an expiry', () {
      final i = TeamInvitationModel.fromJson({
        'teamId': 't',
        'inviteCode': 'ABC234',
        'expiresAtUtc': '2026-11-21T10:00:00Z',
      });
      expect(i.expiresAtUtc, DateTime.utc(2026, 11, 21, 10));
    });

    test('join request with reviewer fields the app ignores', () {
      final r = TeamJoinRequestModel.fromJson({
        'id': 'r',
        'teamId': 't',
        'playerId': 'p',
        'message': null,
        'status': 1,
        'createdAtUtc': '2026-11-14T08:00:00Z',
        'reviewedAtUtc': null,
        'reviewedByPlayerId': null,
        'playerName': 'عمر',
      });
      expect(r.status, 1);
      expect(r.playerName, 'عمر');
    });

    test('profile of a visitor has no role and no code', () {
      final p = TeamProfileModel.fromJson({
        ...teamProfile().toJson(),
        'callerRole': null,
        'inviteCode': null,
        'isCallerMember': false,
        'stats': teamStats.toJson(),
        'roster': <Object>[],
      });
      expect(p.isLeader, isFalse);
      expect(p.inviteCode, isNull);
    });

    test('profile round-trips through json', () {
      final original = teamProfile(callerRole: 2);
      final copy = TeamProfileModel.fromJson({
        ...original.toJson(),
        'stats': original.stats.toJson(),
        'roster': [for (final m in original.roster) m.toJson()],
      });
      expect(copy.callerRole, 2);
      expect(copy.roster.map((m) => m.playerId), ['captain-1', 'player-2']);
    });
  });
}
