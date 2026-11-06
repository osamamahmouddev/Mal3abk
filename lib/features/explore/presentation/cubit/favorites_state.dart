import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/explore_venue_card_model.dart';

part 'favorites_state.freezed.dart';

@freezed
sealed class FavoritesState with _$FavoritesState {
  const factory FavoritesState.loading() = FavoritesLoading;

  /// [failure] is set once when a removal was rolled back.
  const factory FavoritesState.success(
    List<ExploreVenueCardModel> venues, {
    String? failure,
  }) = FavoritesSuccess;
  const factory FavoritesState.error(String message) = FavoritesError;
}
