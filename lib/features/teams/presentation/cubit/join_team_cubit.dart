import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/join_team_by_code_use_case.dart';
import 'join_team_state.dart';

class JoinTeamCubit extends Cubit<JoinTeamState>
    with SafeEmitCubitMixin<JoinTeamState> {
  JoinTeamCubit({required this.joinTeamByCodeUseCase})
    : super(const JoinTeamState.initial());

  final JoinTeamByCodeUseCase joinTeamByCodeUseCase;

  Future<void> join(String code) async {
    if (state is JoinTeamLoading) return;
    emitIfOpen(const JoinTeamState.loading());
    final result = await joinTeamByCodeUseCase(code);
    result.when(
      success: (team) => emitIfOpen(JoinTeamState.success(team)),
      failure: (failure) => emitIfOpen(JoinTeamState.error(failure.message)),
    );
  }
}
