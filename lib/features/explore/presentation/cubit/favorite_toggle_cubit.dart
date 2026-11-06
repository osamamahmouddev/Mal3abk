import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/explore_repo.dart';
import 'favorite_toggle_state.dart';

class FavoriteToggleCubit extends Cubit<FavoriteToggleState>
    with SafeEmitCubitMixin<FavoriteToggleState> {
  FavoriteToggleCubit({required this.exploreRepo})
    : super(const FavoriteToggleState());

  final ExploreRepo exploreRepo;

  bool isFavorite(String venueId, {required bool loaded}) =>
      state.overrides[venueId] ?? loaded;

  Future<void> toggle(String venueId, {required bool loaded}) async {
    final next = !isFavorite(venueId, loaded: loaded);
    final before = state.overrides;
    emitIfOpen(FavoriteToggleState(overrides: {...before, venueId: next}));
    final result = await exploreRepo.setFavorite(venueId, favorite: next);
    if (result case ApiFailure(:final failure)) {
      emitIfOpen(
        FavoriteToggleState(overrides: before, failure: failure.message),
      );
    }
  }
}
