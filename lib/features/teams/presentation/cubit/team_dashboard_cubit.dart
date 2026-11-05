import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/get_team_dashboard_use_case.dart';
import 'team_dashboard_state.dart';

class TeamDashboardCubit extends Cubit<TeamDashboardState>
    with SafeEmitCubitMixin<TeamDashboardState> {
  TeamDashboardCubit({required this.getTeamDashboardUseCase})
    : super(const TeamDashboardState.initial());

  final GetTeamDashboardUseCase getTeamDashboardUseCase;

  Future<void> load(String teamId) async {
    if (state is! TeamDashboardSuccess) {
      emitIfOpen(const TeamDashboardState.loading());
    }
    final result = await getTeamDashboardUseCase(teamId);
    result.when(
      success: (dashboard) => emitIfOpen(TeamDashboardState.success(dashboard)),
      failure: (failure) =>
          emitIfOpen(TeamDashboardState.error(failure.message)),
    );
  }
}
