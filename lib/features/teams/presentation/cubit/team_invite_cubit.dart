import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/team_invitation_model.dart';
import '../../domain/repos/teams_repo.dart';
import '../../domain/use_cases/get_team_invite_code_use_case.dart';
import 'team_invite_state.dart';

class TeamInviteCubit extends Cubit<TeamInviteState>
    with SafeEmitCubitMixin<TeamInviteState> {
  TeamInviteCubit({
    required this.getTeamInviteCodeUseCase,
    required this.teamsRepo,
  }) : super(const TeamInviteState.initial());

  final GetTeamInviteCodeUseCase getTeamInviteCodeUseCase;
  final TeamsRepo teamsRepo;

  /// Shows the code players already have; never replaces a working code.
  Future<void> load(String teamId) =>
      _run(() => getTeamInviteCodeUseCase(teamId));

  /// Replaces the code on purpose; the old one stops working at once.
  Future<void> newCode(String teamId) =>
      _run(() => teamsRepo.createInvitation(teamId));

  Future<void> _run(
    Future<ApiResult<TeamInvitationModel>> Function() call,
  ) async {
    if (state is TeamInviteLoading) return;
    emitIfOpen(const TeamInviteState.loading());
    final result = await call();
    result.when(
      success: (invitation) => emitIfOpen(TeamInviteState.success(invitation)),
      failure: (failure) => emitIfOpen(TeamInviteState.error(failure.message)),
    );
  }
}
