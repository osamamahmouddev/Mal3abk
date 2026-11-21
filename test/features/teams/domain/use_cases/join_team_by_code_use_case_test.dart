import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/teams/domain/repos/teams_repo.dart';
import 'package:mal3abk/features/teams/domain/use_cases/join_team_by_code_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/teams_fixtures.dart';

class MockTeamsRepo extends Mock implements TeamsRepo {}

void main() {
  late MockTeamsRepo repo;
  late JoinTeamByCodeUseCase joinByCode;

  setUp(() {
    repo = MockTeamsRepo();
    joinByCode = JoinTeamByCodeUseCase(teamsRepo: repo);
    when(
      () => repo.acceptInvitation(any()),
    ).thenAnswer((_) async => const ApiResult.success(teamDetail));
  });

  group('JoinTeamByCodeUseCase accepts a well-formed code', () {
    const validCodes = {
      'ABC234': 'ABC234',
      'abc234': 'ABC234',
      'AbC234': 'ABC234',
      '  ABC234  ': 'ABC234',
      '\tabc234\n': 'ABC234',
      '234567': '234567',
      'ZZZZZZ': 'ZZZZZZ',
      'A2B3C4': 'A2B3C4',
    };

    validCodes.forEach((typed, sent) {
      test('"${typed.replaceAll('\t', r'\t').replaceAll('\n', r'\n')}" is '
          'sent as $sent', () async {
        final result = await joinByCode(typed);

        expect(result, isSuccessWith(teamDetail));
        verify(() => repo.acceptInvitation(sent)).called(1);
      });
    });
  });

  group('JoinTeamByCodeUseCase rejects a malformed code without a request', () {
    const invalidCodes = {
      'empty': '',
      'only spaces': '      ',
      'too short (3)': 'AB2',
      'one short (5)': 'ABC23',
      'one long (7)': 'ABC2345',
      'a 12-letter phrase': 'Mal3abkEg123',
      'too long (13)': 'ABCDEFGHJKLMN',
      'space inside': 'ABC 234',
      'dash inside': 'ABC-234',
      'symbol': 'ABC23!',
      'arabic letters': 'ابجدهو',
      'a 1 (never in a code)': 'ABC231',
      'a 0 (never in a code)': 'ABC230',
      'an I (never in a code)': 'ABCI23',
      'an O (never in a code)': 'ABCO23',
      'arabic digits': '١٢٣٤٥٦',
      'emoji': 'ABC23⚽',
      'invite link instead of code': 'https://malabak.app/t/ABC234',
      'dot inside': 'ABC.23',
    };

    invalidCodes.forEach((label, typed) {
      test(label, () async {
        final result = await joinByCode(typed);

        expect(result, isFailureWith('errors.teams.invalid_invite_code'));
        verifyNever(() => repo.acceptInvitation(any()));
      });
    });
  });

  group('JoinTeamByCodeUseCase passes the server answer through', () {
    const serverFailures = [
      'errors.teams.invalid_invite_code',
      'errors.teams.invite_code_expired',
      'errors.teams.player_already_in_team',
      'errors.teams.roster_full',
      'errors.teams.max_player_teams_exceeded',
      'errors.forbidden',
    ];

    for (final key in serverFailures) {
      test(key, () async {
        when(() => repo.acceptInvitation(any())).thenAnswer(
          (_) async => ApiResult.failure(AppApiFailure(message: key)),
        );

        expect(await joinByCode('ABC234'), isFailureWith(key));
      });
    }
  });
}
