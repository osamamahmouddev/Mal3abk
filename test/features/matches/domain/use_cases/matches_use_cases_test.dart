import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/matches/data/models/match_details_model.dart';
import 'package:mal3abk/features/matches/data/models/match_model.dart';
import 'package:mal3abk/features/matches/data/models/respond_to_challenge_request_body.dart';
import 'package:mal3abk/features/matches/data/models/send_challenge_request_body.dart';
import 'package:mal3abk/features/matches/domain/repos/matches_repo.dart';
import 'package:mal3abk/features/matches/domain/use_cases/get_challenge_details_use_case.dart';
import 'package:mal3abk/features/matches/domain/use_cases/get_match_details_use_case.dart';
import 'package:mal3abk/features/matches/domain/use_cases/respond_to_challenge_use_case.dart';
import 'package:mal3abk/features/matches/domain/use_cases/send_challenge_use_case.dart';
import 'package:mal3abk/features/teams/data/models/team_summary_model.dart';
import 'package:mal3abk/features/teams/domain/repos/teams_repo.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/matches_fixtures.dart';

class MockMatchesRepo extends Mock implements MatchesRepo {}

class MockTeamsRepo extends Mock implements TeamsRepo {}

TeamSummaryModel teamWithRole(String id, int role) => TeamSummaryModel(
  id: id,
  name: id,
  city: 'القاهرة',
  governorate: 'القاهرة',
  captainId: 'captain',
  memberCount: 5,
  rating: 1500,
  matchesPlayed: 0,
  isRecruiting: true,
  isOpenForChallenges: true,
  myRole: role,
);

void main() {
  late MockMatchesRepo matchesRepo;
  late MockTeamsRepo teamsRepo;

  setUpAll(() {
    registerFallbackValue(
      SendChallengeRequestBody(
        challengerTeamId: '',
        challengedTeamId: '',
        proposedDateUtc: testNow,
        durationMinutes: 90,
      ),
    );
    registerFallbackValue(
      const RespondToChallengeRequestBody(
        respondingTeamId: '',
        action: ChallengeResponseAction.accept,
      ),
    );
  });

  setUp(() {
    matchesRepo = MockMatchesRepo();
    teamsRepo = MockTeamsRepo();
  });

  group('SendChallengeUseCase', () {
    SendChallengeUseCase useCase() =>
        SendChallengeUseCase(matchesRepo: matchesRepo, clock: () => testNow);

    SendChallengeRequestBody body({
      required DateTime at,
      int duration = 90,
      String? notes,
    }) => SendChallengeRequestBody(
      challengerTeamId: 'team-1',
      challengedTeamId: otherTeamId,
      proposedDateUtc: at,
      durationMinutes: duration,
      notes: notes,
    );

    test('rejects a kick-off in the past', () async {
      expect(
        await useCase()(body(at: testNow.subtract(const Duration(hours: 1)))),
        isFailureWith('errors.matches.date_in_past'),
      );
      verifyNever(() => matchesRepo.sendChallenge(any()));
    });

    test('rejects a duration the server would refuse', () async {
      expect(
        await useCase()(
          body(at: testNow.add(const Duration(days: 1)), duration: 200),
        ),
        isFailureWith('errors.matches.invalid_duration'),
      );
    });

    test('drops blank notes before sending', () async {
      final challenge = testChallenge();
      when(
        () => matchesRepo.sendChallenge(any()),
      ).thenAnswer((_) async => ApiResult.success(challenge));

      final result = await useCase()(
        body(at: testNow.add(const Duration(days: 1)), notes: '   '),
      );

      expect(result, isSuccessWith(challenge));
      final sent =
          verify(() => matchesRepo.sendChallenge(captureAny())).captured.single
              as SendChallengeRequestBody;
      expect(sent.notes, isNull);
    });
  });

  group('RespondToChallengeUseCase', () {
    test('validates a counter-proposal before sending it', () async {
      final useCase = RespondToChallengeUseCase(
        matchesRepo: matchesRepo,
        clock: () => testNow,
      );

      expect(
        await useCase.counterPropose(
          'challenge-1',
          'team-1',
          proposedUtc: testNow.subtract(const Duration(days: 1)),
          durationMinutes: 90,
        ),
        isFailureWith('errors.matches.date_in_past'),
      );
      verifyNever(() => matchesRepo.respondToChallenge(any(), any()));
    });
  });

  group('GetChallengeDetailsUseCase', () {
    test('lets the leader whose turn it is respond', () async {
      when(
        () => matchesRepo.getChallenge('challenge-1'),
      ).thenAnswer((_) async => ApiResult.success(testChallenge()));
      when(
        () => teamsRepo.getMyTeams(),
      ).thenAnswer((_) async => ApiResult.success([teamWithRole('team-1', 2)]));

      final result = await GetChallengeDetailsUseCase(
        matchesRepo: matchesRepo,
        teamsRepo: teamsRepo,
      )('challenge-1');

      expect((result as Success).data.canRespond, isTrue);
    });

    test('ordinary members only watch', () async {
      when(
        () => matchesRepo.getChallenge('challenge-1'),
      ).thenAnswer((_) async => ApiResult.success(testChallenge()));
      when(
        () => teamsRepo.getMyTeams(),
      ).thenAnswer((_) async => ApiResult.success([teamWithRole('team-1', 3)]));

      final result = await GetChallengeDetailsUseCase(
        matchesRepo: matchesRepo,
        teamsRepo: teamsRepo,
      )('challenge-1');

      expect((result as Success).data.canRespond, isFalse);
    });
  });

  group('GetMatchDetailsUseCase', () {
    test('acts for the team the caller leads in this match', () async {
      when(
        () => matchesRepo.getMatch('match-1'),
      ).thenAnswer((_) async => ApiResult.success(testMatch()));
      when(() => teamsRepo.getMyTeams()).thenAnswer(
        (_) async => ApiResult.success([
          teamWithRole('team-1', 3),
          teamWithRole(otherTeamId, 1),
          teamWithRole('unrelated', 1),
        ]),
      );

      final result = await GetMatchDetailsUseCase(
        matchesRepo: matchesRepo,
        teamsRepo: teamsRepo,
      )('match-1');

      expect((result as Success).data.myTeam?.id, otherTeamId);
    });
  });

  group('MatchDetailsModel', () {
    test('the result can be reported only once the match started', () {
      final details = MatchDetailsModel(
        match: testMatch(startUtc: testNow),
        myTeam: teamWithRole('team-1', 1),
      );

      expect(
        details.canSubmitResult(testNow.subtract(const Duration(minutes: 1))),
        isFalse,
      );
      expect(details.canSubmitResult(testNow), isTrue);
    });

    test('only the opponent of the reporting team verifies', () {
      final pending = testMatch(
        status: MatchModel.inProgress,
        resultStatus: MatchModel.resultPending,
        submittedBy: 'team-1',
      );

      expect(
        MatchDetailsModel(
          match: pending,
          myTeam: teamWithRole('team-1', 1),
        ).canVerifyResult,
        isFalse,
      );
      expect(
        MatchDetailsModel(
          match: pending,
          myTeam: teamWithRole(otherTeamId, 1),
        ).canVerifyResult,
        isTrue,
      );
    });
  });

  test('a confirmed result counts from the team\'s side', () {
    final match = testMatch(
      status: MatchModel.completed,
      homeScore: 1,
      awayScore: 3,
    );

    expect(match.resultFor('team-1'), MatchResultForTeam.loss);
    expect(match.resultFor(otherTeamId), MatchResultForTeam.win);
  });
}
