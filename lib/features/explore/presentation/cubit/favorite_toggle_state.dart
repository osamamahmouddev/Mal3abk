import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_toggle_state.freezed.dart';

/// Hearts the player changed this session, over what the list loaded with;
/// [failure] is set once when a change was rolled back.
@freezed
abstract class FavoriteToggleState with _$FavoriteToggleState {
  const factory FavoriteToggleState({
    @Default(<String, bool>{}) Map<String, bool> overrides,
    String? failure,
  }) = _FavoriteToggleState;
}
