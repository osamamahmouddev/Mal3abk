import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/teams/data/models/team_invite_preview_model.dart';
import 'package:mal3abk/features/teams/domain/repos/teams_repo.dart';
import 'package:mal3abk/features/teams/domain/use_cases/preview_team_invite_use_case.dart';
import 'package:mal3abk/features/teams/presentation/cubit/team_invite_preview_cubit.dart';
import 'package:mal3abk/features/teams/presentation/cubit/team_invite_preview_state.dart';
import 'package:mocktail/mocktail.dart';

class _MockTeamsRepo extends Mock implements TeamsRepo {}

const _lions = TeamInvitePreviewModel(
  teamId: 't1',
  name: 'Shobra Lions',
  city: 'cairo',
  governorate: 'cairo',
  memberCount: 7,
);

void main() {
  late _MockTeamsRepo repo;
  late TeamInvitePreviewCubit cubit;

  setUp(() {
    repo = _MockTeamsRepo();
    cubit = TeamInvitePreviewCubit(
      previewTeamInviteUseCase: PreviewTeamInviteUseCase(teamsRepo: repo),
    );
  });

  tearDown(() => cubit.close());

  test('an incomplete or malformed code asks nothing', () async {
    await cubit.codeChanged('BJY');
    await cubit.codeChanged('BJYFL1');

    expect(cubit.state, const TeamInvitePreviewState.initial());
    verifyNever(() => repo.previewInvitation(any()));
  });

  test('a complete code shows its team', () async {
    when(
      () => repo.previewInvitation('BJYFLU'),
    ).thenAnswer((_) async => const ApiResult.success(_lions));

    await cubit.codeChanged('bjyflu');

    expect(cubit.state, const TeamInvitePreviewState.success(_lions));
  });

  test('an unknown code shows the server reason', () async {
    when(() => repo.previewInvitation('ZZZZZZ')).thenAnswer(
      (_) async => const ApiResult.failure(
        AppApiFailure(message: 'errors.teams.invalid_invite_code'),
      ),
    );

    await cubit.codeChanged('ZZZZZZ');

    expect(
      cubit.state,
      const TeamInvitePreviewState.error('errors.teams.invalid_invite_code'),
    );
  });

  test(
    'a slow answer for an older code never replaces the newer one',
    () async {
      final slow = Completer<ApiResult<TeamInvitePreviewModel>>();
      when(
        () => repo.previewInvitation('AAAAAA'),
      ).thenAnswer((_) => slow.future);
      when(
        () => repo.previewInvitation('BJYFLU'),
      ).thenAnswer((_) async => const ApiResult.success(_lions));

      final first = cubit.codeChanged('AAAAAA');
      await cubit.codeChanged('BJYFLU');
      slow.complete(
        const ApiResult.failure(
          AppApiFailure(message: 'errors.teams.not_found'),
        ),
      );
      await first;

      expect(cubit.state, const TeamInvitePreviewState.success(_lions));
    },
  );
}
