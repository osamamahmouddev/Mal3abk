import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/teams_repo.dart';
import 'my_teams_state.dart';

class MyTeamsCubit extends Cubit<MyTeamsState>
    with SafeEmitCubitMixin<MyTeamsState> {
  MyTeamsCubit({required this.teamsRepo}) : super(const MyTeamsState.initial());

  final TeamsRepo teamsRepo;

  Future<void> load() async {
    emitIfOpen(const MyTeamsState.loading());
    final result = await teamsRepo.getMyTeams();
    result.when(
      success: (teams) => emitIfOpen(MyTeamsState.success(teams)),
      failure: (failure) => emitIfOpen(MyTeamsState.error(failure.message)),
    );
  }
}
