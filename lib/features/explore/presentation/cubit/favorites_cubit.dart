import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/explore_repo.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState>
    with SafeEmitCubitMixin<FavoritesState> {
  FavoritesCubit({required this.exploreRepo})
    : super(const FavoritesState.loading());

  final ExploreRepo exploreRepo;

  Future<void> load() async {
    if (state is! FavoritesSuccess) emitIfOpen(const FavoritesState.loading());
    final result = await exploreRepo.getFavorites();
    result.when(
      success: (venues) => emitIfOpen(FavoritesState.success(venues)),
      failure: (failure) => emitIfOpen(FavoritesState.error(failure.message)),
    );
  }

  Future<void> remove(String venueId) async {
    final current = state;
    if (current is! FavoritesSuccess) return;
    final before = current.venues;
    emitIfOpen(
      FavoritesState.success([
        for (final v in before)
          if (v.venueId != venueId) v,
      ]),
    );
    final result = await exploreRepo.setFavorite(venueId, favorite: false);
    if (result case ApiFailure(:final failure)) {
      emitIfOpen(FavoritesState.success(before, failure: failure.message));
    }
  }
}
