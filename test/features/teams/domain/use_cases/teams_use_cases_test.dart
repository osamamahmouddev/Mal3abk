import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/matches/data/models/team_challenge_model.dart';
import 'package:mal3abk/features/matches/domain/repos/matches_repo.dart';
import 'package:mal3abk/features/teams/data/models/create_team_request_body.dart';
import 'package:mal3abk/features/teams/data/models/created_team_model.dart';
import 'package:mal3abk/features/teams/data/models/update_team_settings_request_body.dart';
import 'package:mal3abk/features/teams/domain/repos/teams_repo.dart';
import 'package:mal3abk/features/teams/domain/use_cases/create_team_use_case.dart';
import 'package:mal3abk/features/teams/domain/use_cases/get_leaderboard_use_case.dart';
import 'package:mal3abk/features/teams/domain/use_cases/get_team_dashboard_use_case.dart';
import 'package:mal3abk/features/teams/domain/use_cases/join_team_by_code_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/matches_fixtures.dart';
import '../../../../helpers/teams_fixtures.dart';

class MockTeamsRepo extends Mock implements TeamsRepo {}

class MockMatchesRepo extends Mock implements MatchesRepo {}

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
    late MockMatchesRepo matchesRepo;
    late GetTeamDashboardUseCase useCase;

    setUp(() {
      matchesRepo = MockMatchesRepo();
      useCase = GetTeamDashboardUseCase(
        teamsRepo: repo,
        matchesRepo: matchesRepo,
      );
      when(
        () => matchesRepo.getUpcomingMatches(teamId: testTeamId),
      ).thenAnswer((_) async => ApiResult.success(pageOf([testMatch()])));
      when(
        () => matchesRepo.getMatchHistory(teamId: testTeamId, pageSize: 5),
      ).thenAnswer((_) async => ApiResult.success(pageOf(const [])));
      when(() => matchesRepo.getTeamChallenges(testTeamId)).thenAnswer(
        (_) async => ApiResult.success([
          testChallenge(),
          testChallenge(id: 'old', status: ChallengeStatus.declined),
        ]),
      );
    });

    test('gives the captain join requests and open challenges', () async {
      when(
        () => repo.getTeamProfile(testTeamId),
      ).thenAnswer((_) async => ApiResult.success(teamProfile(callerRole: 1)));
      when(
        () => repo.getPendingJoinRequests(testTeamId),
      ).thenAnswer((_) async => ApiResult.success([joinRequest]));

      final dashboard = (await useCase(testTeamId) as Success).data;

      expect(dashboard.pendingJoinRequests, [joinRequest]);
      expect(dashboard.openChallenges.map((c) => c.id), ['challenge-1']);
      expect(dashboard.upcomingMatches, hasLength(1));
    });

    test('keeps leader-only data from other members', () async {
      when(
        () => repo.getTeamProfile(testTeamId),
      ).thenAnswer((_) async => ApiResult.success(teamProfile(callerRole: 3)));

      final dashboard = (await useCase(testTeamId) as Success).data;

      expect(dashboard.upcomingMatches, hasLength(1));
      verifyNever(() => repo.getPendingJoinRequests(any()));
      verifyNever(() => matchesRepo.getTeamChallenges(any()));
    });

    test('still shows the profile when matches fail to load', () async {
      when(
        () => repo.getTeamProfile(testTeamId),
      ).thenAnswer((_) async => ApiResult.success(teamProfile()));
      when(() => matchesRepo.getUpcomingMatches(teamId: testTeamId)).thenAnswer(
        (_) async =>
            const ApiResult.failure(AppApiFailure(message: 'errors.network')),
      );

      final result = await useCase(testTeamId);

      expect((result as Success).data.upcomingMatches, isEmpty);
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

      expect(
        result,
        isA<Success<CreatedTeamModel>>()
            .having((r) => r.data.team, 'team', teamDetail)
            .having((r) => r.data.settingsSaved, 'settingsSaved', isTrue),
      );
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
