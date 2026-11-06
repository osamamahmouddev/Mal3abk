import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/get_home_team_activity_use_case.dart';
import 'home_team_activity_state.dart';

class HomeTeamActivityCubit extends Cubit<HomeTeamActivityState>
    with SafeEmitCubitMixin<HomeTeamActivityState> {
  HomeTeamActivityCubit({required this.getHomeTeamActivityUseCase})
    : super(const HomeTeamActivityState.initial());

  final GetHomeTeamActivityUseCase getHomeTeamActivityUseCase;

  Future<void> load() async {
    if (state is! HomeTeamActivitySuccess) {
      emitIfOpen(const HomeTeamActivityState.loading());
    }
    final result = await getHomeTeamActivityUseCase();
    result.when(
      success: (activity) =>
          emitIfOpen(HomeTeamActivityState.success(activity)),
      failure: (failure) =>
          emitIfOpen(HomeTeamActivityState.error(failure.message)),
    );
  }
}
