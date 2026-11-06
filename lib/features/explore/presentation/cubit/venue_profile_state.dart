import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/pitch_details_model.dart';
import '../../data/models/venue_details_model.dart';

part 'venue_profile_state.freezed.dart';

@freezed
sealed class VenueProfileState with _$VenueProfileState {
  const factory VenueProfileState.initial() = VenueProfileInitial;
  const factory VenueProfileState.loading() = VenueProfileLoading;
  const factory VenueProfileState.success({
    required VenueDetailsModel venue,
    required List<PitchDetailsModel> pitches,
    @Default(false) bool isFavorite,
  }) = VenueProfileSuccess;
  const factory VenueProfileState.error(String message) = VenueProfileError;
}
