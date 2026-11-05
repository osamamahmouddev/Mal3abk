import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/home/domain/use_cases/get_home_team_activity_use_case.dart';
import 'package:mal3abk/features/matches/data/models/match_model.dart';
import 'package:mal3abk/features/matches/domain/repos/matches_repo.dart';
import 'package:mal3abk/features/teams/domain/repos/teams_repo.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/matches_fixtures.dart';
import '../../../../helpers/teams_fixtures.dart';

class MockTeamsRepo extends Mock implements TeamsRepo {}

class MockMatchesRepo extends Mock implements MatchesRepo {}

void main() {
  late MockTeamsRepo teamsRepo;
  late MockMatchesRepo matchesRepo;
  late GetHomeTeamActivityUseCase useCase;

  setUp(() {
    teamsRepo = MockTeamsRepo();
    matchesRepo = MockMatchesRepo();
    useCase = GetHomeTeamActivityUseCase(
      teamsRepo: teamsRepo,
      matchesRepo: matchesRepo,
      clock: () => testNow,
    );
  });

  test('reports that the player has no team', () async {
    when(
      () => teamsRepo.getMyTeams(),
    ).thenAnswer((_) async => const ApiResult.success([]));

    final result = await useCase();

    expect((result as Success).data.hasTeams, isFalse);
    verifyNever(
      () => matchesRepo.getUpcomingMatches(teamId: any(named: 'teamId')),
    );
  });

  test(
    'surfaces the challenge, the unreported match and the next one',
    () async {
      final played = testMatch(
        id: 'played',
        startUtc: testNow.subtract(const Duration(hours: 3)),
      );
      final next = testMatch(id: 'next');
      when(
        () => teamsRepo.getMyTeams(),
      ).thenAnswer((_) async => const ApiResult.success([myTeam]));
      when(
        () => matchesRepo.getUpcomingMatches(teamId: testTeamId),
      ).thenAnswer((_) async => ApiResult.success(pageOf([next, played])));
      when(() => matchesRepo.getTeamChallenges(testTeamId)).thenAnswer(
        (_) async => ApiResult.success([
          testChallenge(id: 'theirs', isMyTurn: false),
          testChallenge(id: 'mine'),
        ]),
      );

      final activity = (await useCase() as Success).data;

      expect(activity.challengeAwaitingReply?.id, 'mine');
      expect(activity.matchAwaitingResult?.match.id, 'played');
      expect((activity.nextMatch as MatchModel).id, 'next');
    },
  );
}
