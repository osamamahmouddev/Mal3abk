import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/teams/data/apis/teams_api_service.dart';
import 'package:mal3abk/features/teams/data/models/accept_team_invitation_request_body.dart';
import 'package:mal3abk/features/teams/data/repos/teams_repo_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/dio_errors.dart';
import '../../../../helpers/teams_fixtures.dart';

class MockTeamsApiService extends Mock implements TeamsApiService {}

void main() {
  late MockTeamsApiService api;
  late TeamsRepoImpl repo;

  setUpAll(() {
    registerFallbackValue(
      const AcceptTeamInvitationRequestBody(inviteCode: ''),
    );
  });

  setUp(() {
    api = MockTeamsApiService();
    repo = TeamsRepoImpl(teamsApiService: api);
  });

  group('TeamsRepoImpl', () {
    test('returns my teams', () async {
      when(() => api.getMyTeams()).thenAnswer((_) async => [myTeam]);

      expect(await repo.getMyTeams(), isSuccessWith([myTeam]));
    });

    test('maps an expired invite code to its message', () async {
      when(
        () => api.acceptInvitation(any()),
      ).thenThrow(badResponse(400, {'title': 'Team.InviteCodeExpired'}));

      expect(
        await repo.acceptInvitation('ABC234'),
        isFailureWith('errors.teams.invite_code_expired'),
      );
    });

    test('asks only for pending join requests', () async {
      when(
        () => api.getJoinRequests(testTeamId, status: 1),
      ).thenAnswer((_) async => [joinRequest]);

      expect(
        await repo.getPendingJoinRequests(testTeamId),
        isSuccessWith([joinRequest]),
      );
    });

    test('maps leaving as captain to the transfer-first message', () async {
      when(() => api.leaveTeam(testTeamId)).thenThrow(
        badResponse(400, {'title': 'Team.SelfRemovalMustTransferCaptaincy'}),
      );

      expect(
        await repo.leaveTeam(testTeamId),
        isFailureWith('errors.teams.self_removal_must_transfer_captaincy'),
      );
    });
  });
}
