import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/matches/data/models/team_challenge_model.dart';
import 'package:mal3abk/features/matches/domain/repos/matches_repo.dart';
import 'package:mal3abk/features/teams/data/models/leaderboard_view_model.dart';
import 'package:mal3abk/features/teams/data/models/team_dashboard_model.dart';
import 'package:mal3abk/features/teams/data/models/team_summary_model.dart';
import 'package:mal3abk/features/teams/domain/repos/teams_repo.dart';
import 'package:mal3abk/features/teams/domain/use_cases/get_leaderboard_use_case.dart';
import 'package:mal3abk/features/teams/domain/use_cases/get_team_dashboard_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/matches_fixtures.dart';
import '../../../../helpers/teams_fixtures.dart';

class MockTeamsRepo extends Mock implements TeamsRepo {}

class MockMatchesRepo extends Mock implements MatchesRepo {}

const _failure = AppApiFailure(message: 'errors.server');

void main() {
  late MockTeamsRepo teams;
  late MockMatchesRepo matches;
  late GetTeamDashboardUseCase dashboard;

  setUp(() {
    teams = MockTeamsRepo();
    matches = MockMatchesRepo();
    dashboard = GetTeamDashboardUseCase(teamsRepo: teams, matchesRepo: matches);
    when(
      () => matches.getUpcomingMatches(teamId: testTeamId),
    ).thenAnswer((_) async => ApiResult.success(pageOf([testMatch()])));
    when(
      () => matches.getMatchHistory(teamId: testTeamId, pageSize: 5),
    ).thenAnswer(
      (_) async => ApiResult.success(pageOf([testMatch(id: 'old')])),
    );
    when(
      () => teams.getPendingJoinRequests(testTeamId),
    ).thenAnswer((_) async => ApiResult.success([joinRequest]));
    when(() => matches.getTeamChallenges(testTeamId)).thenAnswer(
      (_) async => ApiResult.success([
        testChallenge(),
        testChallenge(id: 'c2', status: ChallengeStatus.counterProposed),
        testChallenge(id: 'c3', status: ChallengeStatus.accepted),
        testChallenge(id: 'c4', status: ChallengeStatus.declined),
        testChallenge(id: 'c5', status: ChallengeStatus.expired),
      ]),
    );
  });

  void profileAs(int? role) => when(
    () => teams.getTeamProfile(testTeamId),
  ).thenAnswer((_) async => ApiResult.success(teamProfile(callerRole: role)));

  Future<TeamDashboardModel> load() async => (await dashboard(testTeamId)).when(
    success: (d) => d,
    failure: (f) => throw TestFailure('unexpected failure ${f.message}'),
  );

  group('GetTeamDashboardUseCase by role', () {
    test('the captain sees join requests and open challenges', () async {
      profileAs(1);
      final d = await load();
      expect(d.pendingJoinRequests, [joinRequest]);
      expect(d.openChallenges.map((c) => c.id), ['challenge-1', 'c2']);
    });

    test('the vice-captain sees join requests and challenges', () async {
      profileAs(2);
      final d = await load();
      expect(d.pendingJoinRequests, [joinRequest]);
      expect(d.openChallenges, hasLength(2));
    });

    test('a plain member sees neither', () async {
      profileAs(3);
      final d = await load();
      expect(d.pendingJoinRequests, isEmpty);
      expect(d.openChallenges, isEmpty);
      verifyNever(() => teams.getPendingJoinRequests(any()));
      verifyNever(() => matches.getTeamChallenges(any()));
    });

    test('a visitor sees neither', () async {
      profileAs(null);
      final d = await load();
      expect(d.pendingJoinRequests, isEmpty);
      expect(d.openChallenges, isEmpty);
      verifyNever(() => teams.getPendingJoinRequests(any()));
      verifyNever(() => matches.getTeamChallenges(any()));
    });

    test('everyone sees upcoming and recent matches', () async {
      profileAs(null);
      final d = await load();
      expect(d.upcomingMatches.single.id, 'match-1');
      expect(d.recentMatches.single.id, 'old');
    });

    test('only the last 5 results are asked for', () async {
      profileAs(3);
      await load();
      verify(
        () => matches.getMatchHistory(
          teamId: testTeamId,
          pageSize: GetTeamDashboardUseCase.recentMatchesCount,
        ),
      ).called(1);
      expect(GetTeamDashboardUseCase.recentMatchesCount, 5);
    });
  });

  group('GetTeamDashboardUseCase failures', () {
    test('a failing profile fails the whole dashboard', () async {
      when(
        () => teams.getTeamProfile(testTeamId),
      ).thenAnswer((_) async => const ApiResult.failure(_failure));
      expect(await dashboard(testTeamId), isFailureWith('errors.server'));
      verifyNever(
        () => matches.getUpcomingMatches(teamId: any(named: 'teamId')),
      );
    });

    test('a hidden private team (404) fails the dashboard', () async {
      when(() => teams.getTeamProfile(testTeamId)).thenAnswer(
        (_) async => const ApiResult.failure(
          AppApiFailure(message: 'errors.teams.not_found'),
        ),
      );
      expect(
        await dashboard(testTeamId),
        isFailureWith('errors.teams.not_found'),
      );
    });

    test('failing upcoming matches still show the profile', () async {
      profileAs(1);
      when(
        () => matches.getUpcomingMatches(teamId: testTeamId),
      ).thenAnswer((_) async => const ApiResult.failure(_failure));
      final d = await load();
      expect(d.upcomingMatches, isEmpty);
      expect(d.profile.id, testTeamId);
    });

    test('failing match history still shows the profile', () async {
      profileAs(1);
      when(
        () => matches.getMatchHistory(teamId: testTeamId, pageSize: 5),
      ).thenAnswer((_) async => const ApiResult.failure(_failure));
      expect((await load()).recentMatches, isEmpty);
    });

    test('failing join requests still show the profile', () async {
      profileAs(1);
      when(
        () => teams.getPendingJoinRequests(testTeamId),
      ).thenAnswer((_) async => const ApiResult.failure(_failure));
      expect((await load()).pendingJoinRequests, isEmpty);
    });

    test('failing challenges still show the profile', () async {
      profileAs(1);
      when(
        () => matches.getTeamChallenges(testTeamId),
      ).thenAnswer((_) async => const ApiResult.failure(_failure));
      expect((await load()).openChallenges, isEmpty);
    });
  });

  group('GetLeaderboardUseCase', () {
    late GetLeaderboardUseCase leaderboard;

    setUp(() {
      leaderboard = GetLeaderboardUseCase(teamsRepo: teams);
      when(
        () => teams.getLeaderboard(
          governorate: any(named: 'governorate'),
          page: any(named: 'page'),
        ),
      ).thenAnswer((_) async => const ApiResult.success(emptyLeaderboard));
    });

    Future<LeaderboardViewModel> load({String? governorate}) async =>
        (await leaderboard(governorate: governorate)).when(
          success: (v) => v,
          failure: (f) => throw TestFailure(f.message),
        );

    test('marks the teams the player belongs to', () async {
      when(() => teams.getMyTeams()).thenAnswer(
        (_) async => const ApiResult.success([
          myTeam,
          TeamSummaryModel(
            id: 'team-7',
            name: 'Seven',
            city: 'Giza',
            governorate: 'Giza',
            captainId: 'x',
            memberCount: 6,
            rating: 1500,
            matchesPlayed: 0,
            isRecruiting: true,
            isOpenForChallenges: true,
            myRole: 3,
          ),
        ]),
      );
      expect((await load()).myTeamIds, {testTeamId, 'team-7'});
    });

    test('a player with no teams has nothing marked', () async {
      when(
        () => teams.getMyTeams(),
      ).thenAnswer((_) async => const ApiResult.success([]));
      expect((await load()).myTeamIds, isEmpty);
    });

    test('failing my-teams still shows the leaderboard', () async {
      when(
        () => teams.getMyTeams(),
      ).thenAnswer((_) async => const ApiResult.failure(_failure));
      final view = await load();
      expect(view.myTeamIds, isEmpty);
      expect(view.page, emptyLeaderboard);
    });

    test('a failing leaderboard fails', () async {
      when(
        () => teams.getMyTeams(),
      ).thenAnswer((_) async => const ApiResult.success([myTeam]));
      when(
        () => teams.getLeaderboard(
          governorate: any(named: 'governorate'),
          page: any(named: 'page'),
        ),
      ).thenAnswer((_) async => const ApiResult.failure(_failure));
      expect(await leaderboard(), isFailureWith('errors.server'));
    });

    test('the governorate filter reaches the repo', () async {
      when(
        () => teams.getMyTeams(),
      ).thenAnswer((_) async => const ApiResult.success([]));
      await load(governorate: 'Giza');
      verify(
        () => teams.getLeaderboard(governorate: 'Giza', page: 1),
      ).called(1);
    });
  });
}
