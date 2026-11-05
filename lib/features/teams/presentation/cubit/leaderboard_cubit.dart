import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/get_leaderboard_use_case.dart';
import 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState>
    with SafeEmitCubitMixin<LeaderboardState> {
  LeaderboardCubit({required this.getLeaderboardUseCase})
    : super(const LeaderboardState.initial());

  final GetLeaderboardUseCase getLeaderboardUseCase;
  bool loadingMore = false;

  Future<void> load({String? governorate}) async {
    emitIfOpen(const LeaderboardState.loading());
    final result = await getLeaderboardUseCase(governorate: governorate);
    result.when(
      success: (view) => emitIfOpen(
        LeaderboardState.success(
          view.page.items,
          view.page.hasMore,
          view.page.page,
          governorate,
          view.myTeamIds,
        ),
      ),
      failure: (failure) => emitIfOpen(LeaderboardState.error(failure.message)),
    );
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! LeaderboardSuccess || !current.hasMore || loadingMore) {
      return;
    }
    loadingMore = true;
    final result = await getLeaderboardUseCase(
      governorate: current.governorate,
      page: current.page + 1,
    );
    loadingMore = false;
    result.when(
      success: (view) => emitIfOpen(
        LeaderboardState.success(
          [...current.entries, ...view.page.items],
          view.page.hasMore,
          view.page.page,
          current.governorate,
          current.myTeamIds,
        ),
      ),
      failure: (_) {},
    );
  }
}
