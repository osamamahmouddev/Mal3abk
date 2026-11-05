import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/matches/data/models/verify_match_result_request_body.dart';
import 'package:mal3abk/features/matches/domain/repos/matches_repo.dart';
import 'package:mal3abk/features/matches/presentation/cubit/match_result_action.dart';
import 'package:mal3abk/features/matches/presentation/cubit/match_result_cubit.dart';
import 'package:mal3abk/features/matches/presentation/cubit/match_result_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/matches_fixtures.dart';

class MockMatchesRepo extends Mock implements MatchesRepo {}

void main() {
  late MockMatchesRepo repo;
  late MatchResultCubit cubit;

  setUpAll(() => registerFallbackValue(MatchVerificationAction.confirm));

  setUp(() {
    repo = MockMatchesRepo();
    cubit = MatchResultCubit(matchesRepo: repo);
  });

  tearDown(() => cubit.close());

  test('confirms the result for the caller\'s team', () async {
    final match = testMatch();
    when(
      () => repo.verifyResult(
        'match-1',
        teamId: otherTeamId,
        action: MatchVerificationAction.confirm,
      ),
    ).thenAnswer((_) async => ApiResult.success(match));

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        const MatchResultState.loading(),
        MatchResultState.success(match, MatchResultAction.confirmed),
      ]),
    );
    await cubit.confirm('match-1', teamId: otherTeamId);
    await expectation;
  });

  test('asks for a reason before disputing', () async {
    final expectation = expectLater(
      cubit.stream,
      emits(
        const MatchResultState.error('errors.matches.dispute_reason_required'),
      ),
    );
    await cubit.dispute('match-1', teamId: otherTeamId, reason: ' no ');
    await expectation;
    verifyNever(
      () => repo.verifyResult(
        any(),
        teamId: any(named: 'teamId'),
        action: any(named: 'action'),
        disputeReason: any(named: 'disputeReason'),
      ),
    );
  });
}
