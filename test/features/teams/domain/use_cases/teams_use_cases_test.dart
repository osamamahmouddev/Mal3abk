import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/teams/data/models/create_team_request_body.dart';
import 'package:mal3abk/features/teams/data/models/update_team_settings_request_body.dart';
import 'package:mal3abk/features/teams/domain/repos/teams_repo.dart';
import 'package:mal3abk/features/teams/domain/use_cases/create_team_use_case.dart';
import 'package:mal3abk/features/teams/domain/use_cases/get_leaderboard_use_case.dart';
import 'package:mal3abk/features/teams/domain/use_cases/get_team_dashboard_use_case.dart';
import 'package:mal3abk/features/teams/domain/use_cases/join_team_by_code_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/teams_fixtures.dart';

class MockTeamsRepo extends Mock implements TeamsRepo {}

void main() {
  late MockTeamsRepo repo;

  setUpAll(() {
    registerFallbackValue(
      const CreateTeamRequestBody(name: '', city: '', governorate: ''),
    );
    registerFallbackValue(
      const UpdateTeamSettingsRequestBody(
        isPublic: true,
        isRecruiting: true,
        isOpenForChallenges: true,
      ),
    );
  });

  setUp(() => repo = MockTeamsRepo());

  group('GetTeamDashboardUseCase', () {
    test('loads pending join requests for the captain', () async {
      when(
        () => repo.getTeamProfile(testTeamId),
      ).thenAnswer((_) async => ApiResult.success(teamProfile(callerRole: 1)));
      when(
        () => repo.getPendingJoinRequests(testTeamId),
      ).thenAnswer((_) async => ApiResult.success([joinRequest]));

      final result = await GetTeamDashboardUseCase(teamsRepo: repo)(testTeamId);

      expect(result, isA<Success>());
      expect((result as Success).data.pendingJoinRequests, [joinRequest]);
    });

    test('skips join requests for other members', () async {
      when(
        () => repo.getTeamProfile(testTeamId),
      ).thenAnswer((_) async => ApiResult.success(teamProfile(callerRole: 3)));

      await GetTeamDashboardUseCase(teamsRepo: repo)(testTeamId);

      verifyNever(() => repo.getPendingJoinRequests(any()));
    });
  });

  group('CreateTeamUseCase', () {
    test('rejects a too-short name without calling the API', () async {
      final result = await CreateTeamUseCase(teamsRepo: repo)(
        const CreateTeamRequestBody(
          name: 'ab',
          city: 'القاهرة',
          governorate: 'القاهرة',
        ),
        isPublic: true,
      );

      expect(result, isFailureWith('errors.teams.invalid_name'));
      verifyNever(() => repo.createTeam(any()));
    });

    test('creates the team, then applies visibility', () async {
      when(
        () => repo.createTeam(any()),
      ).thenAnswer((_) async => const ApiResult.success(teamDetail));
      when(
        () => repo.updateSettings(any(), any()),
      ).thenAnswer((_) async => const ApiResult.success(null));

      final result = await CreateTeamUseCase(teamsRepo: repo)(
        const CreateTeamRequestBody(
          name: '  فريق النجوم ',
          city: 'القاهرة',
          governorate: 'القاهرة',
        ),
        isPublic: false,
      );

      expect(result, isSuccessWith(teamDetail));
      final sent =
          verify(() => repo.createTeam(captureAny())).captured.single
              as CreateTeamRequestBody;
      expect(sent.name, 'فريق النجوم');
      final settings =
          verify(
                () => repo.updateSettings(testTeamId, captureAny()),
              ).captured.single
              as UpdateTeamSettingsRequestBody;
      expect(settings.isPublic, isFalse);
      expect(settings.isOpenForChallenges, isFalse);
    });
  });

  group('JoinTeamByCodeUseCase', () {
    test('normalises the code before sending it', () async {
      when(
        () => repo.acceptInvitation('ABC234'),
      ).thenAnswer((_) async => const ApiResult.success(teamDetail));

      expect(
        await JoinTeamByCodeUseCase(teamsRepo: repo)(' abc234 '),
        isSuccessWith(teamDetail),
      );
    });

    test('rejects malformed codes locally', () async {
      expect(
        await JoinTeamByCodeUseCase(teamsRepo: repo)('a!'),
        isFailureWith('errors.teams.invalid_invite_code'),
      );
      verifyNever(() => repo.acceptInvitation(any()));
    });
  });

  group('GetLeaderboardUseCase', () {
    test('marks the caller\'s teams', () async {
      when(
        () => repo.getLeaderboard(governorate: null, page: 1),
      ).thenAnswer((_) async => const ApiResult.success(emptyLeaderboard));
      when(
        () => repo.getMyTeams(),
      ).thenAnswer((_) async => const ApiResult.success([myTeam]));

      final result = await GetLeaderboardUseCase(teamsRepo: repo)();

      expect((result as Success).data.myTeamIds, {testTeamId});
    });

    test('still shows the board when my teams fail to load', () async {
      when(
        () => repo.getLeaderboard(governorate: null, page: 1),
      ).thenAnswer((_) async => const ApiResult.success(emptyLeaderboard));
      when(() => repo.getMyTeams()).thenAnswer(
        (_) async =>
            const ApiResult.failure(AppApiFailure(message: 'errors.network')),
      );

      final result = await GetLeaderboardUseCase(teamsRepo: repo)();

      expect((result as Success).data.myTeamIds, isEmpty);
    });
  });
}
