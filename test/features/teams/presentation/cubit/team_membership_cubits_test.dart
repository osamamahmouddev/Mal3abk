import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/teams/data/models/create_team_request_body.dart';
import 'package:mal3abk/features/teams/data/models/created_team_model.dart';
import 'package:mal3abk/features/teams/data/models/team_detail_model.dart';
import 'package:mal3abk/features/teams/data/models/team_discovery_model.dart';
import 'package:mal3abk/features/teams/data/models/team_discovery_page_model.dart';
import 'package:mal3abk/features/teams/data/models/team_invitation_model.dart';
import 'package:mal3abk/features/teams/data/models/update_team_settings_request_body.dart';
import 'package:mal3abk/features/teams/domain/repos/teams_repo.dart';
import 'package:mal3abk/features/teams/domain/use_cases/create_team_use_case.dart';
import 'package:mal3abk/features/teams/domain/use_cases/get_team_dashboard_use_case.dart';
import 'package:mal3abk/features/teams/domain/use_cases/get_team_invite_code_use_case.dart';
import 'package:mal3abk/features/teams/domain/use_cases/join_team_by_code_use_case.dart';
import 'package:mal3abk/features/teams/data/models/team_dashboard_model.dart';
import 'package:mal3abk/features/teams/presentation/cubit/create_team_cubit.dart';
import 'package:mal3abk/features/teams/presentation/cubit/create_team_state.dart';
import 'package:mal3abk/features/teams/presentation/cubit/discover_teams_cubit.dart';
import 'package:mal3abk/features/teams/presentation/cubit/discover_teams_state.dart';
import 'package:mal3abk/features/teams/presentation/cubit/join_team_cubit.dart';
import 'package:mal3abk/features/teams/presentation/cubit/join_team_state.dart';
import 'package:mal3abk/features/teams/presentation/cubit/my_teams_cubit.dart';
import 'package:mal3abk/features/teams/presentation/cubit/my_teams_state.dart';
import 'package:mal3abk/features/teams/presentation/cubit/team_action_cubit.dart';
import 'package:mal3abk/features/teams/presentation/cubit/team_action_state.dart';
import 'package:mal3abk/features/teams/presentation/cubit/team_action_type.dart';
import 'package:mal3abk/features/teams/presentation/cubit/team_dashboard_cubit.dart';
import 'package:mal3abk/features/teams/presentation/cubit/team_dashboard_state.dart';
import 'package:mal3abk/features/teams/presentation/cubit/team_invite_cubit.dart';
import 'package:mal3abk/features/teams/presentation/cubit/team_invite_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/teams_fixtures.dart';

class MockTeamsRepo extends Mock implements TeamsRepo {}

class MockCreateTeamUseCase extends Mock implements CreateTeamUseCase {}

class MockJoinTeamByCodeUseCase extends Mock implements JoinTeamByCodeUseCase {}

class MockGetTeamDashboardUseCase extends Mock
    implements GetTeamDashboardUseCase {}

class MockGetTeamInviteCodeUseCase extends Mock
    implements GetTeamInviteCodeUseCase {}

const _created = CreatedTeamModel(team: teamDetail, settingsSaved: true);

const _createBody = CreateTeamRequestBody(
  name: 'فريق النجوم',
  city: 'Nasr City',
  governorate: 'Cairo',
);

const _settings = UpdateTeamSettingsRequestBody(
  isPublic: true,
  isRecruiting: false,
  isOpenForChallenges: true,
);

ApiResult<T> _fail<T>(String key) =>
    ApiResult.failure(AppApiFailure(message: key));

TeamDiscoveryModel _discovered(String id) => TeamDiscoveryModel(
  id: id,
  name: 'Team $id',
  city: 'Nasr City',
  governorate: 'Cairo',
  rating: 1500,
  memberCount: 5,
  matchesPlayed: 0,
  isRecruiting: true,
  isOpenForChallenges: true,
  canBeChallenged: true,
);

TeamDiscoveryPageModel _page(
  List<String> ids, {
  int page = 1,
  int total = 60,
}) => TeamDiscoveryPageModel(
  items: [for (final id in ids) _discovered(id)],
  totalCount: total,
  page: page,
  pageSize: 20,
);

/// Collects every state a cubit emits while [act] runs.
Future<List<S>> statesOf<S>(
  Stream<S> stream,
  Future<void> Function() act,
) async {
  final states = <S>[];
  final sub = stream.listen(states.add);
  await act();
  await Future<void>.delayed(Duration.zero);
  await sub.cancel();
  return states;
}

void main() {
  late MockTeamsRepo repo;

  setUpAll(() => registerFallbackValue(_createBody));

  setUp(() => repo = MockTeamsRepo());

  group('CreateTeamCubit', () {
    late MockCreateTeamUseCase useCase;
    late CreateTeamCubit cubit;

    setUp(() {
      useCase = MockCreateTeamUseCase();
      cubit = CreateTeamCubit(createTeamUseCase: useCase);
    });
    tearDown(() => cubit.close());

    test('starts idle', () {
      expect(cubit.state, const CreateTeamState.initial());
    });

    test('emits loading then the created team', () async {
      when(
        () => useCase(any(), isPublic: any(named: 'isPublic')),
      ).thenAnswer((_) async => const ApiResult.success(_created));
      expect(
        await statesOf(
          cubit.stream,
          () => cubit.create(_createBody, isPublic: true),
        ),
        [
          const CreateTeamState.loading(),
          const CreateTeamState.success(teamDetail),
        ],
      );
    });

    test('emits loading then the error key', () async {
      when(() => useCase(any(), isPublic: any(named: 'isPublic'))).thenAnswer(
        (_) async => _fail('errors.teams.max_player_teams_exceeded'),
      );
      expect(
        await statesOf(
          cubit.stream,
          () => cubit.create(_createBody, isPublic: true),
        ),
        [
          const CreateTeamState.loading(),
          const CreateTeamState.error('errors.teams.max_player_teams_exceeded'),
        ],
      );
    });

    test('a team whose privacy was not saved still opens, flagged', () async {
      when(() => useCase(any(), isPublic: any(named: 'isPublic'))).thenAnswer(
        (_) async => const ApiResult.success(
          CreatedTeamModel(team: teamDetail, settingsSaved: false),
        ),
      );
      await cubit.create(_createBody, isPublic: false);
      expect(
        cubit.state,
        const CreateTeamState.success(teamDetail, settingsSaved: false),
      );
    });

    test('a fully created team is not flagged', () async {
      when(
        () => useCase(any(), isPublic: any(named: 'isPublic')),
      ).thenAnswer((_) async => const ApiResult.success(_created));
      await cubit.create(_createBody, isPublic: true);
      expect((cubit.state as CreateTeamSuccess).settingsSaved, isTrue);
    });

    test('passes the privacy choice to the use case', () async {
      when(
        () => useCase(any(), isPublic: any(named: 'isPublic')),
      ).thenAnswer((_) async => const ApiResult.success(_created));
      await cubit.create(_createBody, isPublic: false);
      verify(() => useCase(_createBody, isPublic: false)).called(1);
    });

    test('a double tap creates only one team', () async {
      final gate = Completer<ApiResult<CreatedTeamModel>>();
      when(
        () => useCase(any(), isPublic: any(named: 'isPublic')),
      ).thenAnswer((_) => gate.future);
      final first = cubit.create(_createBody, isPublic: true);
      await cubit.create(_createBody, isPublic: true);
      gate.complete(const ApiResult.success(_created));
      await first;
      verify(() => useCase(any(), isPublic: true)).called(1);
    });

    test('can retry after an error', () async {
      when(
        () => useCase(any(), isPublic: any(named: 'isPublic')),
      ).thenAnswer((_) async => _fail('errors.network'));
      await cubit.create(_createBody, isPublic: true);
      when(
        () => useCase(any(), isPublic: any(named: 'isPublic')),
      ).thenAnswer((_) async => const ApiResult.success(_created));
      await cubit.create(_createBody, isPublic: true);
      expect(cubit.state, const CreateTeamState.success(teamDetail));
    });

    test('does not emit after being closed', () async {
      final gate = Completer<ApiResult<CreatedTeamModel>>();
      when(
        () => useCase(any(), isPublic: any(named: 'isPublic')),
      ).thenAnswer((_) => gate.future);
      final pending = cubit.create(_createBody, isPublic: true);
      await cubit.close();
      gate.complete(const ApiResult.success(_created));
      await expectLater(pending, completes);
    });
  });

  group('JoinTeamCubit', () {
    late MockJoinTeamByCodeUseCase useCase;
    late JoinTeamCubit cubit;

    setUp(() {
      useCase = MockJoinTeamByCodeUseCase();
      cubit = JoinTeamCubit(joinTeamByCodeUseCase: useCase);
    });
    tearDown(() => cubit.close());

    test('starts idle', () {
      expect(cubit.state, const JoinTeamState.initial());
    });

    test('emits loading then the joined team', () async {
      when(
        () => useCase(any()),
      ).thenAnswer((_) async => const ApiResult.success(teamDetail));
      expect(await statesOf(cubit.stream, () => cubit.join('abc234')), [
        const JoinTeamState.loading(),
        const JoinTeamState.success(teamDetail),
      ]);
    });

    const failures = [
      'errors.teams.invalid_invite_code',
      'errors.teams.invite_code_expired',
      'errors.teams.player_already_in_team',
      'errors.teams.roster_full',
      'errors.teams.max_player_teams_exceeded',
    ];
    for (final key in failures) {
      test('shows $key', () async {
        when(() => useCase(any())).thenAnswer((_) async => _fail(key));
        await cubit.join('ABC234');
        expect(cubit.state, JoinTeamState.error(key));
      });
    }

    test('passes the code as typed (the use case cleans it)', () async {
      when(
        () => useCase(any()),
      ).thenAnswer((_) async => const ApiResult.success(teamDetail));
      await cubit.join(' abc234 ');
      verify(() => useCase(' abc234 ')).called(1);
    });

    test('a double tap joins only once', () async {
      final gate = Completer<ApiResult<TeamDetailModel>>();
      when(() => useCase(any())).thenAnswer((_) => gate.future);
      final first = cubit.join('ABC234');
      await cubit.join('ABC234');
      gate.complete(const ApiResult.success(teamDetail));
      await first;
      verify(() => useCase(any())).called(1);
    });
  });

  group('TeamInviteCubit', () {
    late MockGetTeamInviteCodeUseCase getCode;
    late TeamInviteCubit cubit;
    const current = TeamInvitationModel(
      teamId: testTeamId,
      inviteCode: 'ABC234',
    );
    const fresh = TeamInvitationModel(teamId: testTeamId, inviteCode: 'NEW234');

    setUp(() {
      getCode = MockGetTeamInviteCodeUseCase();
      cubit = TeamInviteCubit(
        getTeamInviteCodeUseCase: getCode,
        teamsRepo: repo,
      );
      when(
        () => getCode(testTeamId),
      ).thenAnswer((_) async => const ApiResult.success(current));
      when(
        () => repo.createInvitation(testTeamId),
      ).thenAnswer((_) async => const ApiResult.success(fresh));
    });
    tearDown(() => cubit.close());

    test('opening the screen shows the current code', () async {
      expect(await statesOf(cubit.stream, () => cubit.load(testTeamId)), [
        const TeamInviteState.loading(),
        const TeamInviteState.success(current),
      ]);
    });

    test('opening the screen never replaces the code', () async {
      await cubit.load(testTeamId);
      await cubit.load(testTeamId);
      verifyNever(() => repo.createInvitation(any()));
    });

    test('a new code is made only when asked', () async {
      await cubit.load(testTeamId);
      await cubit.newCode(testTeamId);
      expect(cubit.state, const TeamInviteState.success(fresh));
      verify(() => repo.createInvitation(testTeamId)).called(1);
    });

    test('a double tap on new code replaces it once', () async {
      final gate = Completer<ApiResult<TeamInvitationModel>>();
      when(
        () => repo.createInvitation(testTeamId),
      ).thenAnswer((_) => gate.future);
      final first = cubit.newCode(testTeamId);
      await cubit.newCode(testTeamId);
      gate.complete(const ApiResult.success(fresh));
      await first;
      verify(() => repo.createInvitation(testTeamId)).called(1);
    });

    test('a plain member is told only leaders can make a new code', () async {
      when(() => repo.createInvitation(testTeamId)).thenAnswer(
        (_) async => _fail('errors.teams.not_captain_or_vice_captain'),
      );
      await cubit.newCode(testTeamId);
      expect(
        cubit.state,
        const TeamInviteState.error('errors.teams.not_captain_or_vice_captain'),
      );
    });

    test('a failing load is shown and can be retried', () async {
      when(
        () => getCode(testTeamId),
      ).thenAnswer((_) async => _fail('errors.network'));
      await cubit.load(testTeamId);
      expect(cubit.state, const TeamInviteState.error('errors.network'));
      when(
        () => getCode(testTeamId),
      ).thenAnswer((_) async => const ApiResult.success(current));
      await cubit.load(testTeamId);
      expect(cubit.state, const TeamInviteState.success(current));
    });
  });

  group('TeamActionCubit', () {
    late TeamActionCubit cubit;

    setUp(() {
      registerFallbackValue(_settings);
      cubit = TeamActionCubit(teamsRepo: repo);
      when(
        () => repo.approveJoinRequest(any(), any()),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.declineJoinRequest(any(), any()),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.removeMember(any(), any()),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.transferCaptaincy(any(), any()),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.leaveTeam(any()),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.updateMemberRole(any(), any(), any()),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.updateSettings(any(), any()),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.requestToJoin(any(), message: any(named: 'message')),
      ).thenAnswer((_) async => ApiResult.success(joinRequest));
    });
    tearDown(() => cubit.close());

    final actions = <TeamActionType, Future<void> Function(TeamActionCubit)>{
      TeamActionType.approveRequest: (c) =>
          c.approveRequest(testTeamId, 'req-1'),
      TeamActionType.declineRequest: (c) =>
          c.declineRequest(testTeamId, 'req-1'),
      TeamActionType.removeMember: (c) =>
          c.removeMember(testTeamId, 'player-2'),
      TeamActionType.transferCaptaincy: (c) =>
          c.transferCaptaincy(testTeamId, 'player-2'),
      TeamActionType.makeViceCaptain: (c) =>
          c.makeViceCaptain(testTeamId, 'player-2'),
      TeamActionType.makeMember: (c) => c.makeMember(testTeamId, 'player-2'),
      TeamActionType.leaveTeam: (c) => c.leaveTeam(testTeamId),
      TeamActionType.disbandTeam: (c) => c.disbandTeam(testTeamId),
      TeamActionType.updateSettings: (c) =>
          c.updateSettings(testTeamId, _settings),
      TeamActionType.requestToJoin: (c) => c.requestToJoin(testTeamId),
    };

    actions.forEach((type, run) {
      test('${type.name} reports which action succeeded', () async {
        expect(await statesOf(cubit.stream, () => run(cubit)), [
          const TeamActionState.loading(),
          TeamActionState.success(type),
        ]);
      });
    });

    test('every action type is covered', () {
      expect(actions.keys.toSet(), TeamActionType.values.toSet());
    });

    test('approve targets the right team and request', () async {
      await cubit.approveRequest(testTeamId, 'req-1');
      verify(() => repo.approveJoinRequest(testTeamId, 'req-1')).called(1);
    });

    test('decline targets the right team and request', () async {
      await cubit.declineRequest(testTeamId, 'req-1');
      verify(() => repo.declineJoinRequest(testTeamId, 'req-1')).called(1);
    });

    test('remove targets the right player', () async {
      await cubit.removeMember(testTeamId, 'player-2');
      verify(() => repo.removeMember(testTeamId, 'player-2')).called(1);
    });

    test('making a vice-captain sends role 2', () async {
      await cubit.makeViceCaptain(testTeamId, 'player-2');
      verify(() => repo.updateMemberRole(testTeamId, 'player-2', 2)).called(1);
    });

    test('making a member sends role 3', () async {
      await cubit.makeMember(testTeamId, 'player-2');
      verify(() => repo.updateMemberRole(testTeamId, 'player-2', 3)).called(1);
    });

    test('closing the team is the lone captain leaving', () async {
      await cubit.disbandTeam(testTeamId);
      verify(() => repo.leaveTeam(testTeamId)).called(1);
      expect(
        cubit.state,
        const TeamActionState.success(TeamActionType.disbandTeam),
      );
    });

    test('an invalid role is shown', () async {
      when(
        () => repo.updateMemberRole(any(), any(), any()),
      ).thenAnswer((_) async => _fail('errors.teams.invalid_role'));
      await cubit.makeViceCaptain(testTeamId, 'player-2');
      expect(
        cubit.state,
        const TeamActionState.error('errors.teams.invalid_role'),
      );
    });

    test('transfer names the new captain', () async {
      await cubit.transferCaptaincy(testTeamId, 'player-2');
      verify(() => repo.transferCaptaincy(testTeamId, 'player-2')).called(1);
    });

    test('settings send exactly what was toggled', () async {
      await cubit.updateSettings(testTeamId, _settings);
      verify(() => repo.updateSettings(testTeamId, _settings)).called(1);
    });

    const failures = {
      'captain leaving without transfer':
          'errors.teams.self_removal_must_transfer_captaincy',
      'removing the captain': 'errors.teams.cannot_remove_captain',
      'member managing the roster':
          'errors.teams.not_authorized_to_manage_roster',
      'request already handled': 'errors.teams.join_request_already_handled',
      'team not recruiting': 'errors.teams.not_recruiting',
      'duplicate join request': 'errors.teams.duplicate_join_request',
      'transfer to self': 'errors.teams.cannot_transfer_to_self',
    };
    failures.forEach((label, key) {
      test('$label shows $key', () async {
        when(() => repo.leaveTeam(any())).thenAnswer((_) async => _fail(key));
        await cubit.leaveTeam(testTeamId);
        expect(cubit.state, TeamActionState.error(key));
      });
    });

    test('a second action while one runs is ignored', () async {
      final gate = Completer<ApiResult<void>>();
      when(
        () => repo.removeMember(any(), any()),
      ).thenAnswer((_) => gate.future);
      final first = cubit.removeMember(testTeamId, 'player-2');
      await cubit.removeMember(testTeamId, 'player-2');
      await cubit.leaveTeam(testTeamId);
      gate.complete(const ApiResult.success(null));
      await first;
      verify(() => repo.removeMember(any(), any())).called(1);
      verifyNever(() => repo.leaveTeam(any()));
    });

    test('a new action runs after the previous one failed', () async {
      when(
        () => repo.removeMember(any(), any()),
      ).thenAnswer((_) async => _fail('errors.network'));
      await cubit.removeMember(testTeamId, 'player-2');
      await cubit.leaveTeam(testTeamId);
      expect(
        cubit.state,
        const TeamActionState.success(TeamActionType.leaveTeam),
      );
    });
  });

  group('MyTeamsCubit', () {
    late MyTeamsCubit cubit;

    setUp(() => cubit = MyTeamsCubit(teamsRepo: repo));
    tearDown(() => cubit.close());

    test('an empty list is a success, not an error', () async {
      when(
        () => repo.getMyTeams(),
      ).thenAnswer((_) async => const ApiResult.success([]));
      await cubit.load();
      expect(cubit.state, const MyTeamsState.success([]));
    });

    test('a missing permission (403) is shown as an error', () async {
      when(
        () => repo.getMyTeams(),
      ).thenAnswer((_) async => _fail('errors.forbidden'));
      await cubit.load();
      expect(cubit.state, const MyTeamsState.error('errors.forbidden'));
    });

    test('a reload keeps the list on screen (no loading)', () async {
      when(
        () => repo.getMyTeams(),
      ).thenAnswer((_) async => const ApiResult.success([myTeam]));
      await cubit.load();
      when(
        () => repo.getMyTeams(),
      ).thenAnswer((_) async => const ApiResult.success([]));
      expect(await statesOf(cubit.stream, cubit.load), [
        const MyTeamsState.success([]),
      ]);
    });

    test('reload after an error recovers', () async {
      when(
        () => repo.getMyTeams(),
      ).thenAnswer((_) async => _fail('errors.network'));
      await cubit.load();
      when(
        () => repo.getMyTeams(),
      ).thenAnswer((_) async => const ApiResult.success([myTeam]));
      await cubit.load();
      expect(cubit.state, const MyTeamsState.success([myTeam]));
    });
  });

  group('TeamDashboardCubit', () {
    late MockGetTeamDashboardUseCase useCase;
    late TeamDashboardCubit cubit;
    final dashboard = TeamDashboardModel(profile: teamProfile(callerRole: 1));

    setUp(() {
      useCase = MockGetTeamDashboardUseCase();
      cubit = TeamDashboardCubit(getTeamDashboardUseCase: useCase);
    });
    tearDown(() => cubit.close());

    test('first load shows loading then the dashboard', () async {
      when(
        () => useCase(testTeamId),
      ).thenAnswer((_) async => ApiResult.success(dashboard));
      expect(await statesOf(cubit.stream, () => cubit.load(testTeamId)), [
        const TeamDashboardState.loading(),
        TeamDashboardState.success(dashboard),
      ]);
    });

    test('a refresh keeps the old dashboard on screen (no loading)', () async {
      when(
        () => useCase(testTeamId),
      ).thenAnswer((_) async => ApiResult.success(dashboard));
      await cubit.load(testTeamId);
      final states = await statesOf(cubit.stream, () => cubit.load(testTeamId));
      expect(states.whereType<TeamDashboardLoading>(), isEmpty);
    });

    test('a failure shows its key', () async {
      when(
        () => useCase(testTeamId),
      ).thenAnswer((_) async => _fail('errors.teams.not_found'));
      await cubit.load(testTeamId);
      expect(
        cubit.state,
        const TeamDashboardState.error('errors.teams.not_found'),
      );
    });
  });

  group('DiscoverTeamsCubit', () {
    late DiscoverTeamsCubit cubit;

    setUp(() {
      cubit = DiscoverTeamsCubit(teamsRepo: repo);
      when(
        () => repo.discoverTeams(
          search: any(named: 'search'),
          page: any(named: 'page'),
        ),
      ).thenAnswer((_) async => ApiResult.success(_page(['a', 'b'])));
    });
    tearDown(() => cubit.close());

    test('loads the first page', () async {
      await cubit.load();
      final state = cubit.state as DiscoverTeamsSuccess;
      expect(state.teams.map((t) => t.id), ['a', 'b']);
      expect(state.page, 1);
      expect(state.hasMore, isTrue);
    });

    test('a blank search is sent as no search', () async {
      await cubit.load(query: '   ');
      verify(() => repo.discoverTeams(search: null)).called(1);
    });

    test('a search is sent trimmed', () async {
      await cubit.load(query: '  نجوم ');
      verify(() => repo.discoverTeams(search: 'نجوم')).called(1);
    });

    test('load more appends the next page with the same search', () async {
      await cubit.load(query: 'نجوم');
      when(
        () => repo.discoverTeams(search: 'نجوم', page: 2),
      ).thenAnswer((_) async => ApiResult.success(_page(['c'], page: 2)));
      await cubit.loadMore();
      final state = cubit.state as DiscoverTeamsSuccess;
      expect(state.teams.map((t) => t.id), ['a', 'b', 'c']);
      expect(state.page, 2);
    });

    test('load more does nothing on the last page', () async {
      when(
        () => repo.discoverTeams(search: any(named: 'search')),
      ).thenAnswer((_) async => ApiResult.success(_page(['a'], total: 1)));
      await cubit.load();
      await cubit.loadMore();
      verifyNever(
        () => repo.discoverTeams(search: any(named: 'search'), page: 2),
      );
    });

    test('load more does nothing before the first page loads', () async {
      await cubit.loadMore();
      verifyNever(
        () => repo.discoverTeams(
          search: any(named: 'search'),
          page: any(named: 'page'),
        ),
      );
    });

    test('two quick scrolls fetch the next page once', () async {
      await cubit.load();
      final gate = Completer<ApiResult<TeamDiscoveryPageModel>>();
      when(
        () => repo.discoverTeams(search: null, page: 2),
      ).thenAnswer((_) => gate.future);
      final first = cubit.loadMore();
      await cubit.loadMore();
      gate.complete(ApiResult.success(_page(['c'], page: 2)));
      await first;
      verify(() => repo.discoverTeams(search: null, page: 2)).called(1);
    });

    test(
      'a late answer for an old search does not replace the new one',
      () async {
        final slow = Completer<ApiResult<TeamDiscoveryPageModel>>();
        when(
          () => repo.discoverTeams(search: 'old'),
        ).thenAnswer((_) => slow.future);
        when(
          () => repo.discoverTeams(search: 'new'),
        ).thenAnswer((_) async => ApiResult.success(_page(['n1'])));

        final oldSearch = cubit.load(query: 'old');
        await cubit.load(query: 'new');
        slow.complete(ApiResult.success(_page(['o1'])));
        await oldSearch;

        final state = cubit.state as DiscoverTeamsSuccess;
        expect(state.teams.map((t) => t.id), ['n1']);
      },
    );

    test('a page for an old search is not appended to a new search', () async {
      await cubit.load(query: 'old');
      final slowPage = Completer<ApiResult<TeamDiscoveryPageModel>>();
      when(
        () => repo.discoverTeams(search: 'old', page: 2),
      ).thenAnswer((_) => slowPage.future);
      when(
        () => repo.discoverTeams(search: 'new'),
      ).thenAnswer((_) async => ApiResult.success(_page(['n1'])));

      final more = cubit.loadMore();
      await cubit.load(query: 'new');
      slowPage.complete(ApiResult.success(_page(['o3'], page: 2)));
      await more;

      final state = cubit.state as DiscoverTeamsSuccess;
      expect(state.teams.map((t) => t.id), ['n1']);
    });

    test('refresh swaps in the first page without a loading state', () async {
      await cubit.load(query: 'نجوم');
      when(
        () => repo.discoverTeams(search: 'نجوم'),
      ).thenAnswer((_) async => ApiResult.success(_page(['z'])));
      final states = await statesOf(cubit.stream, cubit.refresh);
      expect(states.whereType<DiscoverTeamsLoading>(), isEmpty);
      expect((cubit.state as DiscoverTeamsSuccess).teams.map((t) => t.id), [
        'z',
      ]);
    });

    test('a failing refresh keeps the list on screen', () async {
      await cubit.load();
      when(
        () => repo.discoverTeams(search: any(named: 'search')),
      ).thenAnswer((_) async => _fail('errors.network'));
      await cubit.refresh();
      expect((cubit.state as DiscoverTeamsSuccess).teams.map((t) => t.id), [
        'a',
        'b',
      ]);
    });

    test('refresh before the first load just loads', () async {
      await cubit.refresh();
      expect(cubit.state, isA<DiscoverTeamsSuccess>());
    });

    test('a failing load shows the error', () async {
      when(
        () => repo.discoverTeams(search: any(named: 'search')),
      ).thenAnswer((_) async => _fail('errors.forbidden'));
      await cubit.load();
      expect(cubit.state, const DiscoverTeamsState.error('errors.forbidden'));
    });
  });
}
