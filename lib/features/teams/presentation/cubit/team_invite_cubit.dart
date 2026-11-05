import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/teams_repo.dart';
import 'team_invite_state.dart';

class TeamInviteCubit extends Cubit<TeamInviteState>
    with SafeEmitCubitMixin<TeamInviteState> {
  TeamInviteCubit({required this.teamsRepo})
    : super(const TeamInviteState.initial());

  final TeamsRepo teamsRepo;

  Future<void> createCode(String teamId) async {
    emitIfOpen(const TeamInviteState.loading());
    final result = await teamsRepo.createInvitation(teamId);
    result.when(
      success: (invitation) => emitIfOpen(TeamInviteState.success(invitation)),
      failure: (failure) => emitIfOpen(TeamInviteState.error(failure.message)),
    );
  }
}
