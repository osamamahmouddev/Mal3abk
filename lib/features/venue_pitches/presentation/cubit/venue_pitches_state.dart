import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../reference/data/models/localized_item_model.dart';
import '../../../venue_shell/data/models/venue_pitch_model.dart';

part 'venue_pitches_state.freezed.dart';

@freezed
abstract class VenuePitchesState with _$VenuePitchesState {
  const factory VenuePitchesState({
    @Default([]) List<VenuePitchModel> pitches,
    @Default([]) List<LocalizedItemModel> surfaces,
    @Default(true) bool loading,
    String? error,

    /// The pitch (or `new`, or a venue id) an action is running for.
    String? busyId,
    @Default(false) bool uploading,
  }) = _VenuePitchesState;
}
