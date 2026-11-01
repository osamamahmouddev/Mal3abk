import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/get_venue_details_use_case.dart';
import '../../domain/use_cases/get_venue_pitches_use_case.dart';
import 'venue_profile_state.dart';

class VenueProfileCubit extends Cubit<VenueProfileState>
    with SafeEmitCubitMixin<VenueProfileState> {
  VenueProfileCubit({
    required this.getVenueDetailsUseCase,
    required this.getVenuePitchesUseCase,
  }) : super(const VenueProfileState.initial());

  final GetVenueDetailsUseCase getVenueDetailsUseCase;
  final GetVenuePitchesUseCase getVenuePitchesUseCase;

  Future<void> loadVenue(String venueId) async {
    emitIfOpen(const VenueProfileState.loading());
    final venueResult = await getVenueDetailsUseCase(venueId);

    await venueResult.when(
      success: (venue) async {
        final pitchesResult = await getVenuePitchesUseCase(venueId);
        pitchesResult.when(
          success: (pitches) => emitIfOpen(
            VenueProfileState.success(venue: venue, pitches: pitches),
          ),
          failure: (_) => emitIfOpen(
            VenueProfileState.success(venue: venue, pitches: const []),
          ),
        );
      },
      failure: (failure) async =>
          emitIfOpen(VenueProfileState.error(failure.message)),
    );
  }
}
