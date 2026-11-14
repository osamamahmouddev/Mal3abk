@Tags(['integration'])
library;

import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/teams/data/apis/teams_api_service.dart';
import 'package:mal3abk/features/teams/data/models/create_team_request_body.dart';
import 'package:mal3abk/features/teams/data/models/team_detail_model.dart';
import 'package:mal3abk/features/teams/data/models/team_profile_model.dart';
import 'package:mal3abk/features/teams/data/models/team_summary_model.dart';
import 'package:mal3abk/features/teams/data/models/update_team_settings_request_body.dart';
import 'package:mal3abk/features/teams/data/repos/teams_repo_impl.dart';
import 'package:mal3abk/features/teams/domain/use_cases/create_team_use_case.dart';
import 'package:mal3abk/features/teams/domain/use_cases/get_team_invite_code_use_case.dart';
import 'package:mal3abk/features/teams/domain/use_cases/join_team_by_code_use_case.dart';

/// The teams feature end to end, several real players at once, through the
/// app's own API service, repo, use cases and error mapping, against the local
/// API. Every player is new, so runs never depend on each other.
///
///     flutter test test/integration/teams_critical_cycle_test.dart
///
/// Defaults to the API on 127.0.0.1:5000 and Mailpit on 127.0.0.1:8025;
/// override with MAL3ABK_API / MAL3ABK_MAILPIT. Skips itself when they are
/// down.
///
/// The `logic-gap` group asserts the behaviour the feature should have and
/// fails while the backend allows otherwise. Exclude it with
/// `--exclude-tags logic-gap` until those are fixed.
void main() {
  final apiUrl = Platform.environment['MAL3ABK_API'] ?? 'http://127.0.0.1:5000';
  final mailpitUrl =
      Platform.environment['MAL3ABK_MAILPIT'] ?? 'http://127.0.0.1:8025';
  final random = Random();
  final runId = DateTime.now().millisecondsSinceEpoch.toRadixString(36);
  var teamCounter = 0;

  final plain = _paced(Dio());

  late bool stackUp;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    // The test binding answers every HTTP request with 400; this suite talks
    // to the real local API.
    HttpOverrides.global = null;
    try {
      await plain.get<dynamic>('$apiUrl/api/v1/ping');
      await plain.get<dynamic>('$mailpitUrl/api/v1/info');
      stackUp = true;
    } on DioException {
      stackUp = false;
    }
  });

  Future<String> otpFor(String phone) async {
    final digits = phone.replaceAll('+', '');
    for (var i = 0; i < 40; i++) {
      final list = await plain.get<Map<String, dynamic>>(
        '$mailpitUrl/api/v1/search',
        queryParameters: {'query': 'to:sms+$digits@malabak.local'},
      );
      final messages = (list.data!['messages'] as List)
          .cast<Map<String, dynamic>>();
      if (messages.isNotEmpty) {
        final detail = await plain.get<Map<String, dynamic>>(
          '$mailpitUrl/api/v1/message/${messages.first['ID']}',
        );
        final code = RegExp(
          r'\b[0-9]{6}\b',
        ).firstMatch(detail.data!['Text'] as String)?.group(0);
        if (code != null) return code;
      }
      await Future<void>.delayed(const Duration(milliseconds: 250));
    }
    throw TestFailure('no OTP reached Mailpit for $phone');
  }

  /// A brand-new player signed in through the real OTP flow.
  Future<_Player> newPlayer(String name) async {
    final phone = '+2010${10000000 + random.nextInt(89999999)}';
    // Sending codes is rate limited per IP; wait as long as the API asks.
    for (var attempt = 1; ; attempt++) {
      try {
        await plain.post<dynamic>(
          '$apiUrl/api/v1/auth/otp/send',
          data: {'phoneNumber': phone, 'turnstileToken': 'dev'},
        );
        break;
      } on DioException catch (e) {
        final wait = int.tryParse(
          e.response?.headers.value('retry-after') ?? '',
        );
        if (e.response?.statusCode != 429 || wait == null || attempt > 5) {
          rethrow;
        }
        await Future<void>.delayed(Duration(seconds: wait + 1));
      }
    }
    final verified = await plain.post<Map<String, dynamic>>(
      '$apiUrl/api/v1/auth/otp/verify',
      data: {
        'phoneNumber': phone,
        'code': await otpFor(phone),
        'fullName': name,
        'restoreAccount': false,
      },
    );
    final dio = _paced(
      Dio(
        BaseOptions(
          baseUrl: apiUrl,
          headers: {'Authorization': 'Bearer ${verified.data!['accessToken']}'},
        ),
      ),
    );
    return _Player(
      name: name,
      id: verified.data!['userId'] as String,
      dio: dio,
      repo: TeamsRepoImpl(teamsApiService: TeamsApiService(dio)),
    );
  }

  T ok<T>(ApiResult<T> result, String step) => result.when(
    success: (data) => data,
    failure: (f) => throw TestFailure('$step failed: ${f.code} ${f.message}'),
  );

  String failureKey<T>(ApiResult<T> result) => result.when(
    success: (_) => throw TestFailure('expected a failure, got success'),
    failure: (f) => f.message,
  );

  Future<TeamDetailModel> createTeam(
    _Player captain, {
    bool isPublic = true,
  }) async {
    teamCounter++;
    final created = ok(
      await CreateTeamUseCase(teamsRepo: captain.repo)(
        CreateTeamRequestBody(
          name: 'Crit $runId $teamCounter',
          city: 'Nasr City',
          governorate: 'Cairo',
        ),
        isPublic: isPublic,
      ),
      'create team',
    );
    expect(created.settingsSaved, isTrue, reason: 'privacy must be saved');
    return created.team;
  }

  Future<TeamDetailModel> join(_Player player, String code) async => ok(
    await JoinTeamByCodeUseCase(teamsRepo: player.repo)(code),
    '${player.name} joins',
  );

  Future<TeamProfileModel> profile(_Player p, String teamId) async =>
      ok(await p.repo.getTeamProfile(teamId), '${p.name} reads profile');

  Future<List<TeamSummaryModel>> myTeams(_Player p) async =>
      ok(await p.repo.getMyTeams(), '${p.name} my teams');

  late _Player captain;
  late _Player member;
  late _Player visitor;
  late _Player other;

  Future<bool> ready() async {
    if (!stackUp) {
      markTestSkipped('local API or Mailpit is not running');
      return false;
    }
    return true;
  }

  group('teams critical cycle', () {
    // Fresh players for every test: team limits (5 per player) and roles
    // must never leak from one scenario into the next.
    setUp(() async {
      if (!stackUp) return;
      final players = await Future.wait([
        newPlayer('Captain $runId'),
        newPlayer('Member $runId'),
        newPlayer('Visitor $runId'),
        newPlayer('Other $runId'),
      ]);
      captain = players[0];
      member = players[1];
      visitor = players[2];
      other = players[3];
    });

    test('a new player is allowed to use teams', () async {
      if (!await ready()) return;
      final perms = await captain.dio.get<Map<String, dynamic>>(
        '/api/v1/me/permissions',
      );
      expect(perms.data!['roles'], contains('Player'));
      expect(perms.data!['permissions'], contains('teams.participate'));
    });

    test(
      'creating a team makes the creator its only member and captain',
      () async {
        if (!await ready()) return;
        final team = await createTeam(captain);

        expect(team.captainId, captain.id);
        expect(team.inviteCode, matches(RegExp(r'^[A-Z0-9]{6}$')));

        final mine = (await myTeams(
          captain,
        )).singleWhere((t) => t.id == team.id);
        expect(mine.myRole, 1);
        expect(mine.memberCount, 1);

        final p = await profile(captain, team.id);
        expect(p.isCaptain, isTrue);
        expect(p.isCallerMember, isTrue);
        expect(p.roster.single.playerId, captain.id);
        expect(p.inviteCode, team.inviteCode);
      },
    );

    test('the privacy chosen at creation is saved', () async {
      if (!await ready()) return;
      final open = await profile(captain, (await createTeam(captain)).id);
      expect(open.isPublic, isTrue);
      expect(open.isOpenForChallenges, isTrue);

      final closed = await profile(
        captain,
        (await createTeam(captain, isPublic: false)).id,
      );
      expect(closed.isPublic, isFalse);
      expect(closed.isOpenForChallenges, isFalse);
      expect(closed.isRecruiting, isTrue);
    });

    test('a player joins by code, typed in lower case', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      final joined = await join(member, team.inviteCode!.toLowerCase());

      expect(joined.id, team.id);
      final mine = (await myTeams(member)).singleWhere((t) => t.id == team.id);
      expect(mine.myRole, 3);
      expect(mine.isLeader, isFalse);

      final roster = (await profile(captain, team.id)).roster;
      expect(
        roster.map((m) => m.playerId),
        containsAll([captain.id, member.id]),
      );
      expect(roster.singleWhere((m) => m.playerId == member.id).role, 3);
    });

    test('joining the same team twice is refused', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      await join(member, team.inviteCode!);
      expect(
        failureKey(await member.repo.acceptInvitation(team.inviteCode!)),
        'errors.teams.player_already_in_team',
      );
      expect(
        (await profile(
          captain,
          team.id,
        )).roster.where((m) => m.playerId == member.id),
        hasLength(1),
      );
    });

    test('a code that matches no team is refused', () async {
      if (!await ready()) return;
      expect(
        failureKey(await visitor.repo.acceptInvitation('ZZZZZZ')),
        'errors.teams.invalid_invite_code',
      );
    });

    test('a visitor sees a public team but not its invite code', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      final p = await profile(visitor, team.id);
      expect(p.isCallerMember, isFalse);
      expect(p.callerRole, isNull);
      expect(p.inviteCode, isNull);
    });

    test('a plain member cannot do any leader action', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      await join(member, team.inviteCode!);
      await join(other, team.inviteCode!);

      expect(
        failureKey(await member.repo.createInvitation(team.id)),
        'errors.teams.not_captain_or_vice_captain',
      );
      expect(
        failureKey(
          await member.repo.updateSettings(
            team.id,
            const UpdateTeamSettingsRequestBody(
              isPublic: false,
              isRecruiting: false,
              isOpenForChallenges: false,
            ),
          ),
        ),
        'errors.teams.not_captain_or_vice_captain',
      );
      expect(
        failureKey(await member.repo.getPendingJoinRequests(team.id)),
        'errors.teams.not_captain_or_vice_captain',
      );
      expect(
        failureKey(await member.repo.removeMember(team.id, other.id)),
        'errors.teams.not_authorized_to_manage_roster',
      );
      expect(
        failureKey(await member.repo.transferCaptaincy(team.id, member.id)),
        'errors.teams.not_captain',
      );

      final after = await profile(captain, team.id);
      expect(after.isPublic, isTrue, reason: 'settings must be unchanged');
      expect(after.roster.map((m) => m.playerId), contains(other.id));
      expect(after.captainId, captain.id);
    });

    test('an outsider cannot do any leader action', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      await join(member, team.inviteCode!);

      expect(
        failureKey(await visitor.repo.createInvitation(team.id)),
        'errors.teams.not_captain_or_vice_captain',
      );
      expect(
        failureKey(await visitor.repo.removeMember(team.id, member.id)),
        'errors.teams.not_authorized_to_manage_roster',
      );
      expect(
        failureKey(await visitor.repo.getPendingJoinRequests(team.id)),
        'errors.teams.not_captain_or_vice_captain',
      );
      expect(
        failureKey(await visitor.repo.transferCaptaincy(team.id, visitor.id)),
        'errors.teams.not_captain',
      );
      expect(
        failureKey(await visitor.repo.leaveTeam(team.id)),
        'errors.teams.member_not_found',
      );
    });

    test('the captain can neither leave nor be removed', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      await join(member, team.inviteCode!);

      expect(
        failureKey(await captain.repo.leaveTeam(team.id)),
        'errors.teams.self_removal_must_transfer_captaincy',
      );
      expect(
        failureKey(await member.repo.removeMember(team.id, captain.id)),
        'errors.teams.cannot_remove_captain',
      );
      expect((await profile(captain, team.id)).captainId, captain.id);
    });

    test('captaincy moves only to a current member', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      await join(member, team.inviteCode!);

      expect(
        failureKey(await captain.repo.transferCaptaincy(team.id, captain.id)),
        'errors.teams.cannot_transfer_to_self',
      );
      expect(
        failureKey(await captain.repo.transferCaptaincy(team.id, visitor.id)),
        'errors.teams.member_not_found',
      );

      ok(
        await captain.repo.transferCaptaincy(team.id, member.id),
        'transfer captaincy',
      );
      final p = await profile(member, team.id);
      expect(p.captainId, member.id);
      expect(p.isCaptain, isTrue);
      expect(p.roster.singleWhere((m) => m.playerId == captain.id).role, 3);

      // The old captain is a plain member now and may leave.
      expect(
        failureKey(await captain.repo.createInvitation(team.id)),
        'errors.teams.not_captain_or_vice_captain',
      );
      ok(await captain.repo.leaveTeam(team.id), 'old captain leaves');
      expect(
        (await myTeams(captain)).map((t) => t.id),
        isNot(contains(team.id)),
      );
    });

    test('opening the invite screen keeps the code players have', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      final invite = GetTeamInviteCodeUseCase(teamsRepo: captain.repo);

      final shown = ok(await invite(team.id), 'open invite screen');
      final shownAgain = ok(await invite(team.id), 'open it again');
      expect(shown.inviteCode, team.inviteCode);
      expect(shownAgain.inviteCode, team.inviteCode);

      // The code shared before opening the screen still works.
      await join(member, team.inviteCode!);
    });

    test('the invite screen shows the newest code after a new one', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      final fresh = ok(await captain.repo.createInvitation(team.id), 'new');
      final shown = ok(
        await GetTeamInviteCodeUseCase(teamsRepo: captain.repo)(team.id),
        'open invite screen',
      );
      expect(shown.inviteCode, fresh.inviteCode);
      expect(shown.expiresAtUtc, isNotNull);
    });

    test('a plain member sees the code but cannot replace it', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      await join(member, team.inviteCode!);
      // Members see the code (server rule), but cannot replace it.
      final shown = ok(
        await GetTeamInviteCodeUseCase(teamsRepo: member.repo)(team.id),
        'member opens invite screen',
      );
      expect(shown.inviteCode, team.inviteCode);
      expect(
        failureKey(await member.repo.createInvitation(team.id)),
        'errors.teams.not_captain_or_vice_captain',
      );
    });

    test('a new invite code kills the old one', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      final oldCode = team.inviteCode!;
      final fresh = ok(
        await captain.repo.createInvitation(team.id),
        'new invite',
      );

      expect(fresh.inviteCode, isNot(oldCode));
      expect(fresh.inviteCode, matches(RegExp(r'^[A-Z0-9]{6}$')));
      expect(fresh.expiresAtUtc, isNotNull, reason: 'the app asks for 7 days');
      expect(
        fresh.expiresAtUtc!.difference(DateTime.now().toUtc()).inDays,
        inInclusiveRange(6, 7),
      );
      expect(
        failureKey(await member.repo.acceptInvitation(oldCode)),
        'errors.teams.invalid_invite_code',
      );
      await join(member, fresh.inviteCode);
    });

    test('join request: ask, no duplicates, approve once', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);

      final request = ok(
        await visitor.repo.requestToJoin(team.id, message: 'جناح أيمن'),
        'request to join',
      );
      expect(request.status, 1);
      expect(
        failureKey(await visitor.repo.requestToJoin(team.id)),
        'errors.teams.duplicate_join_request',
      );

      final pending = ok(
        await captain.repo.getPendingJoinRequests(team.id),
        'pending requests',
      );
      expect(pending.single.id, request.id);
      expect(pending.single.playerName, visitor.name);
      expect(pending.single.message, 'جناح أيمن');

      ok(await captain.repo.approveJoinRequest(team.id, request.id), 'approve');
      expect(
        failureKey(await captain.repo.approveJoinRequest(team.id, request.id)),
        'errors.teams.join_request_already_handled',
      );
      expect(
        failureKey(await captain.repo.declineJoinRequest(team.id, request.id)),
        'errors.teams.join_request_already_handled',
      );
      expect(
        ok(await captain.repo.getPendingJoinRequests(team.id), 'pending'),
        isEmpty,
      );
      expect(
        (await myTeams(visitor)).singleWhere((t) => t.id == team.id).myRole,
        3,
      );
    });

    test('a declined player does not join', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      final request = ok(
        await other.repo.requestToJoin(team.id),
        'request to join',
      );
      ok(await captain.repo.declineJoinRequest(team.id, request.id), 'decline');

      expect((await myTeams(other)).map((t) => t.id), isNot(contains(team.id)));
      expect(
        failureKey(await captain.repo.approveJoinRequest(team.id, request.id)),
        'errors.teams.join_request_already_handled',
      );
      // Declined players may ask again.
      ok(await other.repo.requestToJoin(team.id), 'ask again');
    });

    test('a request for an unknown request id is refused', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      expect(
        failureKey(
          await captain.repo.approveJoinRequest(
            team.id,
            '00000000-0000-0000-0000-000000000001',
          ),
        ),
        'errors.teams.join_request_not_found',
      );
    });

    test('a team that is not recruiting takes no requests', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      ok(
        await captain.repo.updateSettings(
          team.id,
          const UpdateTeamSettingsRequestBody(
            isPublic: true,
            isRecruiting: false,
            isOpenForChallenges: true,
          ),
        ),
        'stop recruiting',
      );
      expect(
        failureKey(await visitor.repo.requestToJoin(team.id)),
        'errors.teams.not_recruiting',
      );
    });

    test('an existing member cannot request to join', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      await join(member, team.inviteCode!);
      expect(
        failureKey(await member.repo.requestToJoin(team.id)),
        'errors.teams.player_already_in_team',
      );
    });

    test('a private team is hidden from outsiders, not from members', () async {
      if (!await ready()) return;
      final team = await createTeam(captain, isPublic: false);
      await join(member, team.inviteCode!);

      expect(
        failureKey(await visitor.repo.getTeamProfile(team.id)),
        'errors.teams.not_found',
      );
      final found = ok(
        await visitor.repo.discoverTeams(search: team.name),
        'discover',
      );
      expect(found.items.map((t) => t.id), isNot(contains(team.id)));
      expect((await profile(member, team.id)).isCallerMember, isTrue);
    });

    test('a public team shows up in discover', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      final found = ok(
        await visitor.repo.discoverTeams(search: team.name),
        'discover',
      );
      expect(found.items.map((t) => t.id), contains(team.id));
    });

    test('a member who leaves loses member access', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      await join(member, team.inviteCode!);
      ok(await member.repo.leaveTeam(team.id), 'leave');

      expect(
        (await myTeams(member)).map((t) => t.id),
        isNot(contains(team.id)),
      );
      final p = await profile(member, team.id);
      expect(p.isCallerMember, isFalse);
      expect(p.inviteCode, isNull, reason: 'a former member loses the code');
      expect(
        failureKey(await member.repo.leaveTeam(team.id)),
        'errors.teams.member_not_found',
      );
    });

    test('a removed member is out of the roster', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      await join(member, team.inviteCode!);
      ok(await captain.repo.removeMember(team.id, member.id), 'remove');

      expect(
        (await profile(captain, team.id)).roster.map((m) => m.playerId),
        isNot(contains(member.id)),
      );
      expect(
        (await myTeams(member)).map((t) => t.id),
        isNot(contains(team.id)),
      );
      expect(
        failureKey(await captain.repo.removeMember(team.id, member.id)),
        'errors.teams.member_not_found',
      );
    });

    test('a vice-captain leads plain members but not the captain', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      await join(member, team.inviteCode!);
      await join(other, team.inviteCode!);

      ok(
        await captain.repo.updateMemberRole(team.id, member.id, 2),
        'appoint vice-captain',
      );
      final vice = member;
      final p = await profile(vice, team.id);
      expect(p.isLeader, isTrue);
      expect(p.isCaptain, isFalse);
      expect(
        p.roster.singleWhere((m) => m.playerId == vice.id).isViceCaptain,
        isTrue,
      );

      // What a vice-captain may do.
      ok(await vice.repo.createInvitation(team.id), 'vice makes a new code');
      final request = ok(
        await visitor.repo.requestToJoin(team.id),
        'visitor asks to join',
      );
      expect(
        ok(
          await vice.repo.getPendingJoinRequests(team.id),
          'vice lists',
        ).map((r) => r.id),
        contains(request.id),
      );
      ok(
        await vice.repo.approveJoinRequest(team.id, request.id),
        'vice approves',
      );
      ok(
        await vice.repo.removeMember(team.id, other.id),
        'vice removes member',
      );

      // What a vice-captain may not do.
      expect(
        failureKey(await vice.repo.removeMember(team.id, captain.id)),
        'errors.teams.cannot_remove_captain',
      );
      expect(
        failureKey(await vice.repo.updateMemberRole(team.id, visitor.id, 2)),
        'errors.teams.not_captain',
      );
      expect(
        failureKey(await vice.repo.transferCaptaincy(team.id, vice.id)),
        'errors.teams.not_captain',
      );
    });

    test('a vice-captain cannot remove another vice-captain', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      await join(member, team.inviteCode!);
      await join(other, team.inviteCode!);
      ok(await captain.repo.updateMemberRole(team.id, member.id, 2), 'vice 1');
      ok(await captain.repo.updateMemberRole(team.id, other.id, 2), 'vice 2');

      expect(
        failureKey(await member.repo.removeMember(team.id, other.id)),
        'errors.teams.not_authorized_to_manage_roster',
      );
    });

    test('only the captain sets roles, and only vice or member', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      await join(member, team.inviteCode!);
      await join(other, team.inviteCode!);

      expect(
        failureKey(await member.repo.updateMemberRole(team.id, other.id, 2)),
        'errors.teams.not_captain',
      );
      expect(
        failureKey(await captain.repo.updateMemberRole(team.id, member.id, 1)),
        'errors.teams.invalid_role',
      );

      ok(await captain.repo.updateMemberRole(team.id, member.id, 2), 'promote');
      ok(await captain.repo.updateMemberRole(team.id, member.id, 3), 'demote');
      final p = await profile(member, team.id);
      expect(p.isLeader, isFalse);
      expect(
        failureKey(await member.repo.createInvitation(team.id)),
        'errors.teams.not_captain_or_vice_captain',
      );
    });

    test('a removed player is told why they cannot rejoin', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      await join(member, team.inviteCode!);
      ok(await captain.repo.removeMember(team.id, member.id), 'remove');

      expect(
        failureKey(await member.repo.acceptInvitation(team.inviteCode!)),
        'errors.teams.removed_from_team',
      );
      // A leader can still let them back through a join request.
      final request = ok(await member.repo.requestToJoin(team.id), 'ask back');
      ok(await captain.repo.approveJoinRequest(team.id, request.id), 'approve');
      expect((await myTeams(member)).map((t) => t.id), contains(team.id));
    });

    test('a player who left by choice can come back with the code', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      await join(member, team.inviteCode!);
      ok(await member.repo.leaveTeam(team.id), 'leave');
      final code = (await profile(captain, team.id)).inviteCode!;
      await join(member, code);
    });

    test('a lone captain closes the team by leaving', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      ok(await captain.repo.leaveTeam(team.id), 'close team');

      expect(
        (await myTeams(captain)).map((t) => t.id),
        isNot(contains(team.id)),
      );
      expect(
        failureKey(await visitor.repo.getTeamProfile(team.id)),
        'errors.teams.not_found',
      );
      final found = ok(
        await visitor.repo.discoverTeams(search: team.name),
        'discover',
      );
      expect(found.items.map((t) => t.id), isNot(contains(team.id)));
      expect(
        await visitor.repo.acceptInvitation(team.inviteCode!),
        isA<ApiFailure<dynamic>>(),
        reason: 'a closed team takes nobody in',
      );
    });

    test('a captain with members still cannot just leave', () async {
      if (!await ready()) return;
      final team = await createTeam(captain);
      await join(member, team.inviteCode!);
      expect(
        failureKey(await captain.repo.leaveTeam(team.id)),
        'errors.teams.self_removal_must_transfer_captaincy',
      );
    });

    test('a player cannot be in more than 5 teams', () async {
      if (!await ready()) return;
      final collector = await newPlayer('Collector $runId');
      for (var i = 0; i < 5; i++) {
        await createTeam(collector);
      }
      expect(await myTeams(collector), hasLength(5));

      final sixth = await CreateTeamUseCase(teamsRepo: collector.repo)(
        CreateTeamRequestBody(
          name: 'Crit $runId sixth',
          city: 'Nasr City',
          governorate: 'Cairo',
        ),
        isPublic: true,
      );
      expect(failureKey(sixth), 'errors.teams.max_player_teams_exceeded');

      final elsewhere = await createTeam(captain);
      expect(
        failureKey(
          await collector.repo.acceptInvitation(elsewhere.inviteCode!),
        ),
        'errors.teams.max_player_teams_exceeded',
      );
      expect(
        failureKey(await collector.repo.requestToJoin(elsewhere.id)),
        'errors.teams.max_player_teams_exceeded',
      );
      expect(await myTeams(collector), hasLength(5));
    });
  });

  group('logic gaps', () {
    test('a removed player cannot come back with the code they had', () async {
      if (!await ready()) return;
      final boss = await newPlayer('GapBoss $runId');
      final kicked = await newPlayer('GapKicked $runId');
      final team = await createTeam(boss);
      await join(kicked, team.inviteCode!);
      ok(await boss.repo.removeMember(team.id, kicked.id), 'remove');

      final back = await kicked.repo.acceptInvitation(team.inviteCode!);
      expect(
        back,
        isA<ApiFailure<dynamic>>(),
        reason: 'the captain removed this player; the same code let them back',
      );
    }, tags: 'logic-gap');

    test('approving a request cannot push a player past 5 teams', () async {
      if (!await ready()) return;
      final boss = await newPlayer('GapBoss2 $runId');
      final busy = await newPlayer('GapBusy $runId');
      final target = await createTeam(boss);
      final request = ok(await busy.repo.requestToJoin(target.id), 'request');
      for (var i = 0; i < 5; i++) {
        await createTeam(busy);
      }
      expect(await myTeams(busy), hasLength(5));

      final approved = await boss.repo.approveJoinRequest(
        target.id,
        request.id,
      );
      final count = (await myTeams(busy)).length;
      expect(
        count,
        lessThanOrEqualTo(5),
        reason:
            'approval succeeded=${approved is Success}; player is in $count teams',
      );
    }, tags: 'logic-gap');

    test('a stale request cannot be approved after joining by code', () async {
      if (!await ready()) return;
      final boss = await newPlayer('GapBoss3 $runId');
      final eager = await newPlayer('GapEager $runId');
      final team = await createTeam(boss);
      final request = ok(await eager.repo.requestToJoin(team.id), 'request');
      await join(eager, team.inviteCode!);

      final pending = ok(
        await boss.repo.getPendingJoinRequests(team.id),
        'pending',
      );
      expect(
        pending.map((r) => r.id),
        isNot(contains(request.id)),
        reason: 'the player is already a member; the request is still pending',
      );
    }, tags: 'logic-gap');

    test('joining two teams at once cannot pass 5 teams', () async {
      if (!await ready()) return;
      final boss = await newPlayer('GapBoss4 $runId');
      final racer = await newPlayer('GapRacer $runId');
      for (var i = 0; i < 4; i++) {
        await createTeam(racer);
      }
      final a = await createTeam(boss);
      final b = await createTeam(boss);
      final c = await createTeam(boss);

      await Future.wait([
        racer.repo.acceptInvitation(a.inviteCode!),
        racer.repo.acceptInvitation(b.inviteCode!),
        racer.repo.acceptInvitation(c.inviteCode!),
      ]);
      final count = (await myTeams(racer)).length;
      expect(
        count,
        lessThanOrEqualTo(5),
        reason: 'racer ended in $count teams',
      );
    }, tags: 'logic-gap');

    test('a team with only its captain can be closed', () async {
      if (!await ready()) return;
      final solo = await newPlayer('GapSolo $runId');
      final team = await createTeam(solo);
      // Without another member there is nobody to hand captaincy to, and
      // there is no endpoint to delete the team.
      final left = await solo.repo.leaveTeam(team.id);
      expect(
        left,
        isA<Success<void>>(),
        reason: 'a lone captain is stuck in the team forever',
      );
    }, tags: 'logic-gap');
  });
}

/// The API allows 100 requests a minute per IP and queues 10 more, and this
/// suite goes past that. Queued requests can wait up to a minute, and one
/// refused with 429 is retried once the window has turned.
Dio _paced(Dio dio) {
  dio.options
    ..connectTimeout = const Duration(seconds: 5)
    ..receiveTimeout = const Duration(seconds: 75);
  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (error, handler) async {
        final options = error.requestOptions;
        final retries = (options.extra['rateLimitRetries'] as int?) ?? 0;
        if (error.response?.statusCode != 429 || retries >= 3) {
          return handler.next(error);
        }
        final wait =
            int.tryParse(error.response?.headers.value('retry-after') ?? '') ??
            61;
        await Future<void>.delayed(Duration(seconds: wait + 1));
        options.extra['rateLimitRetries'] = retries + 1;
        try {
          handler.resolve(await dio.fetch<dynamic>(options));
        } on DioException catch (e) {
          handler.next(e);
        }
      },
    ),
  );
  return dio;
}

class _Player {
  _Player({
    required this.name,
    required this.id,
    required this.dio,
    required this.repo,
  });

  final String name;
  final String id;
  final Dio dio;
  final TeamsRepoImpl repo;
}
