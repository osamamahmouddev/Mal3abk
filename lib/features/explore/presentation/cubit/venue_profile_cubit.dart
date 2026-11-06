import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/pitch_details_model.dart';
import '../../domain/repos/explore_repo.dart';
import '../../domain/use_cases/get_venue_details_use_case.dart';
import '../../domain/use_cases/get_venue_pitches_use_case.dart';
import 'venue_profile_state.dart';

/// Loads a venue with its pitches and whether the player saved it; only the
/// venue itself is required.
class VenueProfileCubit extends Cubit<VenueProfileState>
    with SafeEmitCubitMixin<VenueProfileState> {
  VenueProfileCubit({
    required this.getVenueDetailsUseCase,
    required this.getVenuePitchesUseCase,
    required this.exploreRepo,
  }) : super(const VenueProfileState.initial());

  final GetVenueDetailsUseCase getVenueDetailsUseCase;
  final GetVenuePitchesUseCase getVenuePitchesUseCase;
  final ExploreRepo exploreRepo;

  Future<void> loadVenue(String venueId) async {
    if (state is! VenueProfileSuccess) {
      emitIfOpen(const VenueProfileState.loading());
    }
    final (venueResult, pitchesResult, favoritesResult) = await (
      getVenueDetailsUseCase(venueId),
      getVenuePitchesUseCase(venueId),
      exploreRepo.getFavorites(),
    ).wait;

    venueResult.when(
      success: (venue) => emitIfOpen(
        VenueProfileState.success(
          venue: venue,
          pitches: pitchesResult.maybeWhen(
            success: (pitches) => pitches,
            orElse: () => const <PitchDetailsModel>[],
          ),
          isFavorite: favoritesResult.maybeWhen(
            success: (favorites) => favorites.any((v) => v.venueId == venueId),
            orElse: () => false,
          ),
        ),
      ),
      failure: (failure) =>
          emitIfOpen(VenueProfileState.error(failure.message)),
    );
  }
}
