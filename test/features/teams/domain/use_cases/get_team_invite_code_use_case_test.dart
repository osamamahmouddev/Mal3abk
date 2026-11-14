import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/teams/data/models/team_detail_model.dart';
import 'package:mal3abk/features/teams/data/models/team_invitation_model.dart';
import 'package:mal3abk/features/teams/domain/repos/teams_repo.dart';
import 'package:mal3abk/features/teams/domain/use_cases/get_team_invite_code_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/teams_fixtures.dart';

class MockTeamsRepo extends Mock implements TeamsRepo {}

final _now = DateTime.utc(2026, 11, 14, 12);

TeamDetailModel _team({String? code = 'ABC234', DateTime? expiresAt}) =>
    TeamDetailModel(
      id: testTeamId,
      name: 'فريق النجوم',
      city: 'Nasr City',
      governorate: 'Cairo',
      captainId: 'captain-1',
      inviteCode: code,
      inviteCodeExpiresAtUtc: expiresAt,
    );

const _fresh = TeamInvitationModel(teamId: testTeamId, inviteCode: 'NEW234');

void main() {
  late MockTeamsRepo repo;
  late GetTeamInviteCodeUseCase getCode;

  setUp(() {
    repo = MockTeamsRepo();
    getCode = GetTeamInviteCodeUseCase(teamsRepo: repo, now: () => _now);
    when(
      () => repo.createInvitation(testTeamId),
    ).thenAnswer((_) async => const ApiResult.success(_fresh));
  });

  void teamIs(TeamDetailModel team) => when(
    () => repo.getTeam(testTeamId),
  ).thenAnswer((_) async => ApiResult.success(team));

  Matcher codeIs(String code) => isA<Success<TeamInvitationModel>>().having(
    (r) => r.data.inviteCode,
    'inviteCode',
    code,
  );

  group('the code players already have keeps working', () {
    test('a code that never expires is shown as is', () async {
      teamIs(_team());
      expect(await getCode(testTeamId), codeIs('ABC234'));
      verifyNever(() => repo.createInvitation(any()));
    });

    test('a code that expires later is shown as is', () async {
      teamIs(_team(expiresAt: _now.add(const Duration(days: 3))));
      final result = await getCode(testTeamId);
      expect(result, codeIs('ABC234'));
      expect(
        (result as Success<TeamInvitationModel>).data.expiresAtUtc,
        _now.add(const Duration(days: 3)),
      );
      verifyNever(() => repo.createInvitation(any()));
    });

    test('a code expiring in one second is still shown', () async {
      teamIs(_team(expiresAt: _now.add(const Duration(seconds: 1))));
      expect(await getCode(testTeamId), codeIs('ABC234'));
    });

    test('the team id comes from the server answer', () async {
      teamIs(_team());
      final result = await getCode(testTeamId);
      expect((result as Success<TeamInvitationModel>).data.teamId, testTeamId);
    });
  });

  group('a new code is made only when needed', () {
    test('an expired code is replaced', () async {
      teamIs(_team(expiresAt: _now.subtract(const Duration(minutes: 1))));
      expect(await getCode(testTeamId), codeIs('NEW234'));
      verify(() => repo.createInvitation(testTeamId)).called(1);
    });

    test('a code expiring exactly now is replaced', () async {
      teamIs(_team(expiresAt: _now));
      expect(await getCode(testTeamId), codeIs('NEW234'));
    });

    test('a missing code (server hides it) is replaced', () async {
      teamIs(_team(code: null));
      expect(await getCode(testTeamId), codeIs('NEW234'));
    });

    test('an empty code is replaced', () async {
      teamIs(_team(code: ''));
      expect(await getCode(testTeamId), codeIs('NEW234'));
    });

    test(
      'a member who cannot make codes gets the leader-only message',
      () async {
        teamIs(_team(code: null));
        when(() => repo.createInvitation(testTeamId)).thenAnswer(
          (_) async => const ApiResult.failure(
            AppApiFailure(message: 'errors.teams.not_captain_or_vice_captain'),
          ),
        );
        expect(
          await getCode(testTeamId),
          isFailureWith('errors.teams.not_captain_or_vice_captain'),
        );
      },
    );
  });

  group('failures', () {
    test('a failing team read fails without making a code', () async {
      when(() => repo.getTeam(testTeamId)).thenAnswer(
        (_) async =>
            const ApiResult.failure(AppApiFailure(message: 'errors.network')),
      );
      expect(await getCode(testTeamId), isFailureWith('errors.network'));
      verifyNever(() => repo.createInvitation(any()));
    });

    test('a hidden team fails with not found', () async {
      when(() => repo.getTeam(testTeamId)).thenAnswer(
        (_) async => const ApiResult.failure(
          AppApiFailure(message: 'errors.teams.not_found'),
        ),
      );
      expect(
        await getCode(testTeamId),
        isFailureWith('errors.teams.not_found'),
      );
    });
  });

  test('defaults to the real clock', () {
    final useCase = GetTeamInviteCodeUseCase(teamsRepo: repo);
    expect(
      useCase.now().difference(DateTime.now().toUtc()).inSeconds.abs(),
      lessThan(5),
    );
    expect(useCase.now().isUtc, isTrue);
  });
}
