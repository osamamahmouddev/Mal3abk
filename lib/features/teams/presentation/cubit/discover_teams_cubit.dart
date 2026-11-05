import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/teams_repo.dart';
import 'discover_teams_state.dart';

class DiscoverTeamsCubit extends Cubit<DiscoverTeamsState>
    with SafeEmitCubitMixin<DiscoverTeamsState> {
  DiscoverTeamsCubit({required this.teamsRepo})
    : super(const DiscoverTeamsState.initial());

  final TeamsRepo teamsRepo;
  String? search;
  bool loadingMore = false;

  Future<void> load({String? query}) async {
    search = query?.trim().isEmpty ?? true ? null : query!.trim();
    emitIfOpen(const DiscoverTeamsState.loading());
    final result = await teamsRepo.discoverTeams(search: search);
    result.when(
      success: (page) => emitIfOpen(
        DiscoverTeamsState.success(page.items, page.hasMore, page.page),
      ),
      failure: (failure) =>
          emitIfOpen(DiscoverTeamsState.error(failure.message)),
    );
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! DiscoverTeamsSuccess || !current.hasMore || loadingMore) {
      return;
    }
    loadingMore = true;
    final result = await teamsRepo.discoverTeams(
      search: search,
      page: current.page + 1,
    );
    loadingMore = false;
    result.when(
      success: (page) => emitIfOpen(
        DiscoverTeamsState.success(
          [...current.teams, ...page.items],
          page.hasMore,
          page.page,
        ),
      ),
      failure: (_) {},
    );
  }
}
