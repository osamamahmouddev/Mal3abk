import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/teams/data/models/tactics_board_model.dart';
import 'package:mal3abk/features/teams/domain/repos/tactics_repo.dart';
import 'package:mal3abk/features/teams/domain/repos/teams_repo.dart';
import 'package:mal3abk/features/teams/presentation/cubit/my_teams_cubit.dart';
import 'package:mal3abk/features/teams/presentation/cubit/my_teams_state.dart';
import 'package:mal3abk/features/teams/presentation/cubit/tactical_board_cubit.dart';
import 'package:mal3abk/features/teams/presentation/cubit/tactical_board_state.dart';
import 'package:mal3abk/features/teams/presentation/cubit/team_action_cubit.dart';
import 'package:mal3abk/features/teams/presentation/cubit/team_action_state.dart';
import 'package:mal3abk/features/teams/presentation/cubit/team_action_type.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/teams_fixtures.dart';

class MockTeamsRepo extends Mock implements TeamsRepo {}

class MockTacticsRepo extends Mock implements TacticsRepo {}

void main() {
  late MockTeamsRepo repo;

  setUpAll(() {
    registerFallbackValue(
      const TacticsBoardModel(playersPerSide: 5, formationName: '', slots: []),
    );
  });

  setUp(() => repo = MockTeamsRepo());

  group('MyTeamsCubit', () {
    test('emits [loading, success]', () async {
      when(
        () => repo.getMyTeams(),
      ).thenAnswer((_) async => const ApiResult.success([myTeam]));
      final cubit = MyTeamsCubit(teamsRepo: repo);

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const MyTeamsState.loading(),
          const MyTeamsState.success([myTeam]),
        ]),
      );
      await cubit.load();
      await expectation;
      await cubit.close();
    });
  });

  group('TeamActionCubit', () {
    test('reports which action succeeded', () async {
      when(
        () => repo.approveJoinRequest(testTeamId, 'req-1'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      final cubit = TeamActionCubit(teamsRepo: repo);

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const TeamActionState.loading(),
          const TeamActionState.success(TeamActionType.approveRequest),
        ]),
      );
      await cubit.approveRequest(testTeamId, 'req-1');
      await expectation;
      await cubit.close();
    });

    test('emits the failure key', () async {
      when(() => repo.leaveTeam(testTeamId)).thenAnswer(
        (_) async => const ApiResult.failure(
          AppApiFailure(message: 'errors.teams.not_found'),
        ),
      );
      final cubit = TeamActionCubit(teamsRepo: repo);

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          const TeamActionState.loading(),
          const TeamActionState.error('errors.teams.not_found'),
        ]),
      );
      await cubit.leaveTeam(testTeamId);
      await expectation;
      await cubit.close();
    });
  });

  group('TacticalBoardCubit', () {
    late MockTacticsRepo tactics;
    late TacticalBoardCubit cubit;

    setUp(() {
      tactics = MockTacticsRepo();
      when(() => tactics.load(testTeamId)).thenAnswer((_) async => null);
      when(() => tactics.save(any(), any())).thenAnswer((_) async {});
      cubit = TacticalBoardCubit(tacticsRepo: tactics);
    });

    tearDown(() => cubit.close());

    test('places the squad into the default 5-a-side formation', () async {
      await cubit.load(testTeamId, ['p1', 'p2', 'p3']);

      final state = cubit.state as TacticalBoardSuccess;
      expect(state.board.playersPerSide, 5);
      expect(state.board.slots, ['p1', 'p2', 'p3', null, null]);
    });

    test('tapping two slots swaps them and saves the line-up', () async {
      await cubit.load(testTeamId, ['p1', 'p2', 'p3']);

      cubit
        ..tapSlot(0)
        ..tapSlot(2);

      final state = cubit.state as TacticalBoardSuccess;
      expect(state.board.slots.take(3), ['p3', 'p2', 'p1']);
      expect(state.selectedSlot, isNull);
      verify(() => tactics.save(testTeamId, any())).called(1);
    });

    test('keeps players on the pitch when switching formation', () async {
      await cubit.load(testTeamId, List.generate(8, (i) => 'p$i'));

      cubit.changeSize(7);

      final state = cubit.state as TacticalBoardSuccess;
      expect(state.board.slots, hasLength(7));
      expect(state.board.slots.whereType<String>(), hasLength(7));
    });
  });
}
