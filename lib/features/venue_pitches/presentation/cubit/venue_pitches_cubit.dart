import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../../reference/domain/repos/reference_repo.dart';
import '../../../venue_setup/domain/repos/venue_setup_repo.dart';
import '../../../venue_shell/data/models/venue_pitch_model.dart';
import 'venue_pitches_state.dart';

/// What an action did, for the screen's message.
sealed class PitchActionResult {
  const PitchActionResult();
}

class PitchActionDone extends PitchActionResult {
  const PitchActionDone({this.upcomingBookings = 0});

  /// Bookings still ahead on a pitch that was just paused.
  final int upcomingBookings;
}

class PitchActionFailed extends PitchActionResult {
  const PitchActionFailed(this.message);
  final String message;
}

/// The web "venues and pitches" page: a venue's pitches (add, edit, pause,
/// delete, photos) and publishing approved branches.
class VenuePitchesCubit extends Cubit<VenuePitchesState>
    with SafeEmitCubitMixin<VenuePitchesState> {
  VenuePitchesCubit({
    required this.venueSetupRepo,
    required this.referenceRepo,
    required this.venueId,
  }) : super(const VenuePitchesState());

  final VenueSetupRepo venueSetupRepo;
  final ReferenceRepo referenceRepo;
  final String venueId;

  Future<void> load() async {
    final surfaces = referenceRepo.getFilterOptions();
    await _reload();
    (await surfaces).when(
      success: (o) => emitIfOpen(state.copyWith(surfaces: o.surfaces)),
      failure: (_) {},
    );
  }

  Future<void> _reload() async {
    final result = await venueSetupRepo.getPitches(venueId);
    result.when(
      success: (p) =>
          emitIfOpen(state.copyWith(pitches: p, loading: false, error: null)),
      failure: (f) =>
          emitIfOpen(state.copyWith(loading: false, error: f.message)),
    );
  }

  /// Adds "Pitch N" with sensible defaults, as the web does, and returns it
  /// so the screen opens it for editing.
  Future<(PitchActionResult, VenuePitchModel?)> addPitch(String name) async {
    emitIfOpen(state.copyWith(busyId: 'new'));
    final result = await venueSetupRepo.addPitch(
      venueId,
      name: name,
      turfType: 'ArtificialTurf',
      capacity: 5,
      photos: const [],
    );
    emitIfOpen(state.copyWith(busyId: null));
    if (result case ApiFailure(:final failure)) {
      return (PitchActionFailed(failure.message), null);
    }
    final before = {for (final p in state.pitches) p.id};
    await _reload();
    final added = state.pitches
        .where((p) => !before.contains(p.id))
        .firstOrNull;
    return (const PitchActionDone(), added);
  }

  Future<PitchActionResult> save(
    VenuePitchModel pitch, {
    required String name,
    required String turfType,
    required int capacity,
    double? lengthMeters,
    double? widthMeters,
  }) => _run(
    pitch.id,
    () async => (await venueSetupRepo.updatePitch(
      pitch,
      name: name,
      turfType: turfType,
      capacity: capacity,
      lengthMeters: lengthMeters,
      widthMeters: widthMeters,
    )).when(success: (_) => 0, failure: (f) => throw f),
  );

  Future<PitchActionResult> toggleActive(VenuePitchModel pitch) => _run(
    pitch.id,
    () async => (await venueSetupRepo.setPitchActive(
      pitch.id,
      !pitch.isActive,
    )).when(success: (n) => n, failure: (f) => throw f),
  );

  Future<PitchActionResult> delete(VenuePitchModel pitch) => _run(
    pitch.id,
    () async => (await venueSetupRepo.deletePitch(
      pitch.id,
    )).when(success: (_) => 0, failure: (f) => throw f),
  );

  Future<PitchActionResult> addPhoto(VenuePitchModel pitch, Uint8List bytes) {
    emitIfOpen(state.copyWith(uploading: true));
    return _run(pitch.id, () async {
      final path = (await venueSetupRepo.uploadImage(
        bytes,
        VenueMediaPurpose.pitchPhoto,
      )).when(success: (p) => p, failure: (f) => throw f);
      (await venueSetupRepo.addPitchPhoto(
        venueId,
        pitch.id,
        path,
      )).when(success: (_) {}, failure: (f) => throw f);
      return 0;
    });
  }

  Future<PitchActionResult> removePhoto(VenuePitchModel pitch, String photo) =>
      _run(pitch.id, () async {
        // A photo that isn't an uploaded one (a link) is dropped by saving
        // the pitch without it, like the web page.
        final result = photo.startsWith('/api/v1/media/')
            ? await venueSetupRepo.removePitchPhoto(venueId, pitch.id, photo)
            : await venueSetupRepo.updatePitch(
                pitch,
                name: pitch.name,
                turfType: pitch.turfType,
                capacity: pitch.capacity,
                lengthMeters: pitch.lengthMeters,
                widthMeters: pitch.widthMeters,
                photos: [
                  for (final p in pitch.photos)
                    if (p != photo) p,
                ],
              );
        result.when(success: (_) {}, failure: (f) => throw f);
        return 0;
      });

  Future<PitchActionResult> publishVenue(String id, bool isPublished) => _run(
    id,
    () async => (await venueSetupRepo.publishVenue(
      id,
      isPublished,
    )).when(success: (_) => 0, failure: (f) => throw f),
    reload: false,
  );

  Future<PitchActionResult> _run(
    String id,
    Future<int> Function() action, {
    bool reload = true,
  }) async {
    emitIfOpen(state.copyWith(busyId: id));
    try {
      final count = await action();
      if (reload) await _reload();
      return PitchActionDone(upcomingBookings: count);
    } on Object catch (e) {
      return PitchActionFailed(
        e is AppApiFailure ? e.message : 'common.unexpected_error',
      );
    } finally {
      emitIfOpen(state.copyWith(busyId: null, uploading: false));
    }
  }
}
