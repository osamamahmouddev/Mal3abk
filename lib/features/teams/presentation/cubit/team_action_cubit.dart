import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/update_team_settings_request_body.dart';
import '../../domain/repos/teams_repo.dart';
import 'team_action_state.dart';
import 'team_action_type.dart';

class TeamActionCubit extends Cubit<TeamActionState>
    with SafeEmitCubitMixin<TeamActionState> {
  TeamActionCubit({required this.teamsRepo})
    : super(const TeamActionState.initial());

  final TeamsRepo teamsRepo;

  Future<void> approveRequest(String teamId, String requestId) => run(
    TeamActionType.approveRequest,
    () => teamsRepo.approveJoinRequest(teamId, requestId),
  );

  Future<void> declineRequest(String teamId, String requestId) => run(
    TeamActionType.declineRequest,
    () => teamsRepo.declineJoinRequest(teamId, requestId),
  );

  Future<void> removeMember(String teamId, String playerId) => run(
    TeamActionType.removeMember,
    () => teamsRepo.removeMember(teamId, playerId),
  );

  Future<void> transferCaptaincy(String teamId, String playerId) => run(
    TeamActionType.transferCaptaincy,
    () => teamsRepo.transferCaptaincy(teamId, playerId),
  );

  Future<void> leaveTeam(String teamId) =>
      run(TeamActionType.leaveTeam, () => teamsRepo.leaveTeam(teamId));

  Future<void> updateSettings(
    String teamId,
    UpdateTeamSettingsRequestBody body,
  ) => run(
    TeamActionType.updateSettings,
    () => teamsRepo.updateSettings(teamId, body),
  );

  Future<void> requestToJoin(String teamId) =>
      run(TeamActionType.requestToJoin, () => teamsRepo.requestToJoin(teamId));

  Future<void> run(
    TeamActionType action,
    Future<ApiResult<Object?>> Function() call,
  ) async {
    if (state is TeamActionLoading) return;
    emitIfOpen(const TeamActionState.loading());
    final result = await call();
    result.when(
      success: (_) => emitIfOpen(TeamActionState.success(action)),
      failure: (failure) => emitIfOpen(TeamActionState.error(failure.message)),
    );
  }
}
