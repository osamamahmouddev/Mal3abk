import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/matches/data/apis/matches_api_service.dart';
import 'package:mal3abk/features/matches/data/models/submit_match_result_request_body.dart';
import 'package:mal3abk/features/matches/data/models/verify_match_result_request_body.dart';
import 'package:mal3abk/features/matches/data/repos/matches_repo_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/dio_errors.dart';
import '../../../../helpers/matches_fixtures.dart';

class MockMatchesApiService extends Mock implements MatchesApiService {}

void main() {
  late MockMatchesApiService api;
  late MatchesRepoImpl repo;

  setUpAll(() {
    registerFallbackValue(
      const SubmitMatchResultRequestBody(homeScore: 0, awayScore: 0),
    );
    registerFallbackValue(
      const VerifyMatchResultRequestBody(
        action: MatchVerificationAction.confirm,
      ),
    );
  });

  setUp(() {
    api = MockMatchesApiService();
    repo = MatchesRepoImpl(matchesApiService: api);
  });

  test('submits the score on behalf of the given team', () async {
    final match = testMatch();
    when(
      () => api.submitResult('match-1', 'team-1', any()),
    ).thenAnswer((_) async => match);

    final result = await repo.submitResult(
      'match-1',
      teamId: 'team-1',
      homeScore: 3,
      awayScore: 2,
    );

    expect(result, isSuccessWith(match));
    final body =
        verify(
              () => api.submitResult('match-1', 'team-1', captureAny()),
            ).captured.single
            as SubmitMatchResultRequestBody;
    expect((body.homeScore, body.awayScore), (3, 2));
  });

  test('maps verifying your own result to its message', () async {
    when(
      () => api.verifyResult('match-1', 'team-1', any()),
    ).thenThrow(badResponse(400, {'title': 'Match.CannotVerifyOwnResult'}));

    expect(
      await repo.verifyResult(
        'match-1',
        teamId: 'team-1',
        action: MatchVerificationAction.confirm,
      ),
      isFailureWith('errors.matches.cannot_verify_own_result'),
    );
  });

  test('maps a challenge that is not our turn to its message', () async {
    when(
      () => api.getChallenge('challenge-1'),
    ).thenThrow(badResponse(403, {'title': 'Challenge.NotYourTurn'}));

    expect(
      await repo.getChallenge('challenge-1'),
      isFailureWith('errors.matches.not_your_turn'),
    );
  });
}
