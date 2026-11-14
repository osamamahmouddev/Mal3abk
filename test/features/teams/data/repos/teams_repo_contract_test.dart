import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/teams/data/apis/teams_api_service.dart';
import 'package:mal3abk/features/teams/data/models/accept_team_invitation_request_body.dart';
import 'package:mal3abk/features/teams/data/models/create_team_invitation_request_body.dart';
import 'package:mal3abk/features/teams/data/models/create_team_request_body.dart';
import 'package:mal3abk/features/teams/data/models/join_team_request_body.dart';
import 'package:mal3abk/features/teams/data/models/team_discovery_page_model.dart';
import 'package:mal3abk/features/teams/data/models/team_invitation_model.dart';
import 'package:mal3abk/features/teams/data/models/transfer_captaincy_request_body.dart';
import 'package:mal3abk/features/teams/data/models/update_member_role_request_body.dart';
import 'package:mal3abk/features/teams/data/models/update_team_settings_request_body.dart';
import 'package:mal3abk/features/teams/data/repos/teams_repo_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/dio_errors.dart';
import '../../../../helpers/teams_fixtures.dart';

class MockTeamsApiService extends Mock implements TeamsApiService {}

const _createBody = CreateTeamRequestBody(
  name: 'فريق النجوم',
  city: 'Nasr City',
  governorate: 'Cairo',
);

const _settings = UpdateTeamSettingsRequestBody(
  isPublic: false,
  isRecruiting: true,
  isOpenForChallenges: false,
);

void main() {
  late MockTeamsApiService api;
  late TeamsRepoImpl repo;

  setUpAll(() {
    registerFallbackValue(
      const AcceptTeamInvitationRequestBody(inviteCode: ''),
    );
    registerFallbackValue(const CreateTeamInvitationRequestBody());
    registerFallbackValue(_createBody);
    registerFallbackValue(const JoinTeamRequestBody());
    registerFallbackValue(
      const TransferCaptaincyRequestBody(newCaptainPlayerId: ''),
    );
    registerFallbackValue(_settings);
    registerFallbackValue(const UpdateMemberRoleRequestBody(role: 3));
  });

  setUp(() {
    api = MockTeamsApiService();
    repo = TeamsRepoImpl(teamsApiService: api);
  });

  // Every server error code of the Teams module, as the API sends it in the
  // problem body, must reach the player as its own message.
  group('server team errors reach the player as their own message', () {
    const codes = {
      'Team.NotFound': (404, 'errors.teams.not_found'),
      'Team.InvalidName': (400, 'errors.teams.invalid_name'),
      'Team.InvalidLocation': (400, 'errors.teams.invalid_location'),
      'Team.NameAlreadyExists': (409, 'errors.teams.name_already_exists'),
      'Team.PlayerAlreadyInTeam': (409, 'errors.teams.player_already_in_team'),
      'Team.PlayerNotInTeam': (404, 'errors.teams.player_not_in_team'),
      'Team.MemberNotFound': (404, 'errors.teams.member_not_found'),
      'Team.NotCaptain': (403, 'errors.teams.not_captain'),
      'Team.NotCaptainOrViceCaptain': (
        403,
        'errors.teams.not_captain_or_vice_captain',
      ),
      'Team.NotAuthorizedToManageRoster': (
        403,
        'errors.teams.not_authorized_to_manage_roster',
      ),
      'Team.CannotRemoveCaptain': (409, 'errors.teams.cannot_remove_captain'),
      'Team.SelfRemovalMustTransferCaptaincy': (
        409,
        'errors.teams.self_removal_must_transfer_captaincy',
      ),
      'Team.CannotChangeCaptainRole': (
        409,
        'errors.teams.cannot_change_captain_role',
      ),
      'Team.InvalidInviteCode': (400, 'errors.teams.invalid_invite_code'),
      'Team.InviteCodeExpired': (409, 'errors.teams.invite_code_expired'),
      'Team.CannotTransferToSelf': (
        400,
        'errors.teams.cannot_transfer_to_self',
      ),
      'Team.NotRecruiting': (409, 'errors.teams.not_recruiting'),
      'Team.RosterFull': (409, 'errors.teams.roster_full'),
      'Team.Suspended': (409, 'errors.teams.suspended'),
      'Team.RemovedFromTeam': (403, 'errors.teams.removed_from_team'),
      'Team.InvalidRole': (400, 'errors.teams.invalid_role'),
      'Team.InviteCodeUnavailable': (
        409,
        'errors.teams.invite_code_unavailable',
      ),
      'Team.MaxPlayerTeamsExceeded': (
        409,
        'errors.teams.max_player_teams_exceeded',
      ),
      'Team.DuplicateJoinRequest': (409, 'errors.teams.duplicate_join_request'),
      'Team.JoinRequestNotFound': (404, 'errors.teams.join_request_not_found'),
      'Team.JoinRequestAlreadyHandled': (
        409,
        'errors.teams.join_request_already_handled',
      ),
    };

    codes.forEach((code, expected) {
      final (status, key) = expected;
      test('$code ($status) as errorCode', () async {
        when(
          () => api.acceptInvitation(any()),
        ).thenThrow(badResponse(status, {'errorCode': code}));
        final result = await repo.acceptInvitation('ABC234');
        expect(result, isFailureWith(key));
        expect(
          (result as ApiFailure).failure,
          isA<Object>()
              .having((f) => (f as dynamic).statusCode, 'statusCode', status)
              .having((f) => (f as dynamic).code, 'code', code),
        );
      });
    });

    test('a code sent as the problem title is understood too', () async {
      when(() => api.leaveTeam(testTeamId)).thenThrow(
        badResponse(409, {'title': 'Team.SelfRemovalMustTransferCaptaincy'}),
      );
      expect(
        await repo.leaveTeam(testTeamId),
        isFailureWith('errors.teams.self_removal_must_transfer_captaincy'),
      );
    });
  });

  group('failures without a team code fall back by status', () {
    final cases = {
      'missing role (403, no body)': (badResponse(403), 'errors.forbidden'),
      'unauthorized (401)': (badResponse(401), 'errors.unauthorized'),
      'unknown team id (404)': (badResponse(404), 'errors.not_found'),
      'conflict (409)': (badResponse(409), 'errors.conflict'),
      'rate limited (429)': (badResponse(429), 'common.too_many_requests'),
      'server error (500)': (badResponse(500), 'errors.server'),
      'no connection': (
        DioException.connectionError(
          requestOptions: RequestOptions(path: '/api/v1/me/teams'),
          reason: 'offline',
        ),
        'errors.network',
      ),
      'timeout': (
        DioException.connectionTimeout(
          timeout: const Duration(seconds: 10),
          requestOptions: RequestOptions(path: '/api/v1/me/teams'),
        ),
        'errors.timeout',
      ),
    };

    cases.forEach((label, value) {
      final (error, key) = value;
      test(label, () async {
        when(() => api.getMyTeams()).thenThrow(error);
        expect(await repo.getMyTeams(), isFailureWith(key));
      });
    });
  });

  group('each call sends the right request', () {
    test('createTeam sends the body as is', () async {
      when(() => api.createTeam(any())).thenAnswer((_) async => teamDetail);
      expect(await repo.createTeam(_createBody), isSuccessWith(teamDetail));
      verify(() => api.createTeam(_createBody)).called(1);
    });

    test('acceptInvitation wraps the code in its body', () async {
      when(
        () => api.acceptInvitation(any()),
      ).thenAnswer((_) async => teamDetail);
      await repo.acceptInvitation('XY7Z9Q');
      final sent =
          verify(() => api.acceptInvitation(captureAny())).captured.single
              as AcceptTeamInvitationRequestBody;
      expect(sent.inviteCode, 'XY7Z9Q');
    });

    test('createInvitation asks for a code valid for 7 days', () async {
      when(() => api.createInvitation(any(), any())).thenAnswer(
        (_) async =>
            const TeamInvitationModel(teamId: testTeamId, inviteCode: 'NEW234'),
      );
      final result = await repo.createInvitation(testTeamId);
      expect(
        result,
        isA<Success<TeamInvitationModel>>().having(
          (r) => r.data.inviteCode,
          'inviteCode',
          'NEW234',
        ),
      );
      final sent =
          verify(
                () => api.createInvitation(testTeamId, captureAny()),
              ).captured.single
              as CreateTeamInvitationRequestBody;
      expect(sent.validityDays, 7);
    });

    test('requestToJoin passes the message', () async {
      when(
        () => api.requestToJoin(any(), any()),
      ).thenAnswer((_) async => joinRequest);
      await repo.requestToJoin(testTeamId, message: 'مدافع');
      final sent =
          verify(
                () => api.requestToJoin(testTeamId, captureAny()),
              ).captured.single
              as JoinTeamRequestBody;
      expect(sent.message, 'مدافع');
    });

    test('requestToJoin without a message sends none', () async {
      when(
        () => api.requestToJoin(any(), any()),
      ).thenAnswer((_) async => joinRequest);
      await repo.requestToJoin(testTeamId);
      final sent =
          verify(
                () => api.requestToJoin(testTeamId, captureAny()),
              ).captured.single
              as JoinTeamRequestBody;
      expect(sent.message, isNull);
    });

    test('pending join requests ask only for status 1 (pending)', () async {
      when(
        () => api.getJoinRequests(any(), status: any(named: 'status')),
      ).thenAnswer((_) async => [joinRequest]);
      expect(
        await repo.getPendingJoinRequests(testTeamId),
        isSuccessWith([joinRequest]),
      );
      verify(() => api.getJoinRequests(testTeamId, status: 1)).called(1);
      expect(TeamsRepoImpl.pendingJoinRequestStatus, 1);
    });

    test('approveJoinRequest targets the team and request', () async {
      when(() => api.approveJoinRequest(any(), any())).thenAnswer((_) async {});
      expect(
        await repo.approveJoinRequest(testTeamId, 'req-1'),
        isA<Success<void>>(),
      );
      verify(() => api.approveJoinRequest(testTeamId, 'req-1')).called(1);
    });

    test('declineJoinRequest targets the team and request', () async {
      when(() => api.declineJoinRequest(any(), any())).thenAnswer((_) async {});
      expect(
        await repo.declineJoinRequest(testTeamId, 'req-1'),
        isA<Success<void>>(),
      );
      verify(() => api.declineJoinRequest(testTeamId, 'req-1')).called(1);
    });

    test('removeMember targets the team and player', () async {
      when(() => api.removeMember(any(), any())).thenAnswer((_) async {});
      expect(
        await repo.removeMember(testTeamId, 'player-2'),
        isA<Success<void>>(),
      );
      verify(() => api.removeMember(testTeamId, 'player-2')).called(1);
    });

    test('leaveTeam targets the team', () async {
      when(() => api.leaveTeam(any())).thenAnswer((_) async {});
      expect(await repo.leaveTeam(testTeamId), isA<Success<void>>());
      verify(() => api.leaveTeam(testTeamId)).called(1);
    });

    test('transferCaptaincy names the new captain', () async {
      when(() => api.transferCaptaincy(any(), any())).thenAnswer((_) async {});
      await repo.transferCaptaincy(testTeamId, 'player-2');
      final sent =
          verify(
                () => api.transferCaptaincy(testTeamId, captureAny()),
              ).captured.single
              as TransferCaptaincyRequestBody;
      expect(sent.newCaptainPlayerId, 'player-2');
    });

    test('updateMemberRole sends the role for the player', () async {
      when(
        () => api.updateMemberRole(any(), any(), any()),
      ).thenAnswer((_) async {});
      expect(
        await repo.updateMemberRole(testTeamId, 'player-2', 2),
        isA<Success<void>>(),
      );
      final sent =
          verify(
                () =>
                    api.updateMemberRole(testTeamId, 'player-2', captureAny()),
              ).captured.single
              as UpdateMemberRoleRequestBody;
      expect(sent.role, UpdateMemberRoleRequestBody.viceCaptain);
    });

    test('updateMemberRole maps an invalid role', () async {
      when(
        () => api.updateMemberRole(any(), any(), any()),
      ).thenThrow(badResponse(400, {'errorCode': 'Team.InvalidRole'}));
      expect(
        await repo.updateMemberRole(testTeamId, 'player-2', 1),
        isFailureWith('errors.teams.invalid_role'),
      );
    });

    test('updateSettings sends all three switches', () async {
      when(() => api.updateSettings(any(), any())).thenAnswer((_) async {});
      await repo.updateSettings(testTeamId, _settings);
      verify(() => api.updateSettings(testTeamId, _settings)).called(1);
    });

    test('discoverTeams passes every filter and the page', () async {
      when(
        () => api.discoverTeams(
          search: any(named: 'search'),
          governorate: any(named: 'governorate'),
          isRecruiting: any(named: 'isRecruiting'),
          isOpenForChallenges: any(named: 'isOpenForChallenges'),
          page: any(named: 'page'),
        ),
      ).thenAnswer(
        (_) async =>
            const TeamDiscoveryPageModel(totalCount: 0, page: 3, pageSize: 20),
      );
      await repo.discoverTeams(
        search: 'نجوم',
        governorate: 'Cairo',
        isRecruiting: true,
        isOpenForChallenges: false,
        page: 3,
      );
      verify(
        () => api.discoverTeams(
          search: 'نجوم',
          governorate: 'Cairo',
          isRecruiting: true,
          isOpenForChallenges: false,
          page: 3,
        ),
      ).called(1);
    });

    test('getTeam returns the code and its expiry', () async {
      when(() => api.getTeam(testTeamId)).thenAnswer((_) async => teamDetail);
      expect(await repo.getTeam(testTeamId), isSuccessWith(teamDetail));
    });

    test('getTeam maps a hidden team to not found', () async {
      when(
        () => api.getTeam(testTeamId),
      ).thenThrow(badResponse(404, {'errorCode': 'Team.NotFound'}));
      expect(
        await repo.getTeam(testTeamId),
        isFailureWith('errors.teams.not_found'),
      );
    });

    test('getTeamProfile returns the profile', () async {
      final profile = teamProfile(callerRole: 1);
      when(
        () => api.getTeamProfile(testTeamId),
      ).thenAnswer((_) async => profile);
      expect(await repo.getTeamProfile(testTeamId), isSuccessWith(profile));
    });

    test('getLeaderboard passes governorate and page', () async {
      when(
        () => api.getLeaderboard(
          governorate: any(named: 'governorate'),
          page: any(named: 'page'),
        ),
      ).thenAnswer((_) async => emptyLeaderboard);
      await repo.getLeaderboard(governorate: 'Giza', page: 2);
      verify(() => api.getLeaderboard(governorate: 'Giza', page: 2)).called(1);
    });
  });

  group('void calls map their failures too', () {
    final calls = <String, Future<ApiResult<void>> Function()>{
      'approve': () => repo.approveJoinRequest(testTeamId, 'req-1'),
      'decline': () => repo.declineJoinRequest(testTeamId, 'req-1'),
      'remove': () => repo.removeMember(testTeamId, 'player-2'),
      'leave': () => repo.leaveTeam(testTeamId),
      'transfer': () => repo.transferCaptaincy(testTeamId, 'player-2'),
      'settings': () => repo.updateSettings(testTeamId, _settings),
    };

    setUp(() {
      final forbidden = badResponse(403, {
        'errorCode': 'Team.NotCaptainOrViceCaptain',
      });
      when(() => api.approveJoinRequest(any(), any())).thenThrow(forbidden);
      when(() => api.declineJoinRequest(any(), any())).thenThrow(forbidden);
      when(() => api.removeMember(any(), any())).thenThrow(forbidden);
      when(() => api.leaveTeam(any())).thenThrow(forbidden);
      when(() => api.transferCaptaincy(any(), any())).thenThrow(forbidden);
      when(() => api.updateSettings(any(), any())).thenThrow(forbidden);
    });

    calls.forEach((label, call) {
      test(label, () async {
        expect(
          await call(),
          isFailureWith('errors.teams.not_captain_or_vice_captain'),
        );
      });
    });
  });
}
