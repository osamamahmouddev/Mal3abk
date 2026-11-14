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

  /// Bumped by every new search, so an older answer that arrives late is
  /// dropped instead of replacing the newer one.
  int _generation = 0;

  Future<void> load({String? query}) async {
    final generation = ++_generation;
    search = query?.trim().isEmpty ?? true ? null : query!.trim();
    emitIfOpen(const DiscoverTeamsState.loading());
    final result = await teamsRepo.discoverTeams(search: search);
    if (generation != _generation) return;
    result.when(
      success: (page) => emitIfOpen(
        DiscoverTeamsState.success(page.items, page.hasMore, page.page),
      ),
      failure: (failure) =>
          emitIfOpen(DiscoverTeamsState.error(failure.message)),
    );
  }

  /// Fetches the first page of the current search again without a loading
  /// state; on failure the list on screen stays as it was.
  Future<void> refresh() async {
    if (state is! DiscoverTeamsSuccess) return load(query: search);
    final generation = ++_generation;
    final result = await teamsRepo.discoverTeams(search: search);
    if (generation != _generation) return;
    result.when(
      success: (page) => emitIfOpen(
        DiscoverTeamsState.success(page.items, page.hasMore, page.page),
      ),
      failure: (_) {},
    );
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! DiscoverTeamsSuccess || !current.hasMore || loadingMore) {
      return;
    }
    final generation = _generation;
    loadingMore = true;
    final result = await teamsRepo.discoverTeams(
      search: search,
      page: current.page + 1,
    );
    loadingMore = false;
    if (generation != _generation) return;
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
