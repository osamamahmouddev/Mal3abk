import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../../reference/domain/repos/reference_repo.dart';
import '../../../venue_shell/data/models/venue_model.dart';
import '../../data/models/venue_setup_form.dart';
import '../../domain/repos/venue_setup_repo.dart';
import 'venue_setup_state.dart';

/// The four-step venue setup of the web dashboard: place, pitches, opening
/// hours and sending it for review. Also edits an existing venue.
class VenueSetupCubit extends Cubit<VenueSetupState>
    with SafeEmitCubitMixin<VenueSetupState> {
  VenueSetupCubit({
    required this.venueSetupRepo,
    required this.referenceRepo,
    VenueModel? venue,
  }) : super(VenueSetupState(venue: venue, week: DayHours.defaultWeek()));

  final VenueSetupRepo venueSetupRepo;
  final ReferenceRepo referenceRepo;

  String? get venueId => state.venue?.id;

  Future<void> init() async {
    final governorates = referenceRepo.getGovernorates();
    final options = referenceRepo.getFilterOptions();
    (await governorates).when(
      success: (g) => emitIfOpen(state.copyWith(governorates: g)),
      failure: (_) {},
    );
    (await options).when(
      success: (o) => emitIfOpen(
        state.copyWith(facilities: o.facilities, surfaces: o.surfaces),
      ),
      failure: (_) {},
    );
    if (venueId != null) await _loadVenueParts();
  }

  Future<void> _loadVenueParts() async {
    final id = venueId!;
    final pitches = venueSetupRepo.getPitches(id);
    final schedules = venueSetupRepo.getSchedules(id);
    final approval = venueSetupRepo.getApproval(id);
    (await pitches).when(
      success: (p) => emitIfOpen(state.copyWith(pitches: p)),
      failure: (_) {},
    );
    (await schedules).when(
      success: (list) {
        if (list.isEmpty) return;
        final week = {
          for (final d in DayHours.dayOrder)
            d: DayHours.defaultWeek()[d]!.copyWith(on: false),
        };
        for (final s in list) {
          week[s.dayOfWeek] = DayHours(
            on: s.isActive,
            open: s.openTime.substring(0, 5),
            close: s.closeTime.substring(0, 5),
            slot: s.slotDurationMinutes,
          );
        }
        emitIfOpen(state.copyWith(week: week));
      },
      failure: (_) {},
    );
    (await approval).when(
      success: (a) => emitIfOpen(state.copyWith(approval: a)),
      failure: (_) {},
    );
  }

  void goTo(int step) {
    if (step > 1 && venueId == null) return;
    emitIfOpen(state.copyWith(step: step, error: null));
  }

  Future<void> saveVenue(VenueSetupForm form) async {
    if (state.saving || !form.isValid) return;
    emitIfOpen(state.copyWith(saving: true, error: null));
    final payload = venueId == null
        ? VenueSetupForm(
            name: form.name,
            city: form.city,
            area: form.area,
            phoneNumber: form.phoneNumber,
            address: form.address,
            description: form.description,
            facilities: form.facilities,
            latitude: form.latitude,
            longitude: form.longitude,
            photos: state.pendingVenuePhotos,
          )
        : VenueSetupForm(
            name: form.name,
            city: form.city,
            area: form.area,
            phoneNumber: form.phoneNumber,
            address: form.address,
            description: form.description,
            facilities: form.facilities,
            latitude: form.latitude,
            longitude: form.longitude,
            photos: state.venue!.photos,
          );
    final result = await venueSetupRepo.saveVenue(venueId, payload);
    final wasNew = venueId == null;
    result.when(
      success: (venue) => emitIfOpen(
        state.copyWith(
          venue: venue,
          saving: false,
          step: 2,
          pendingVenuePhotos: const [],
        ),
      ),
      failure: (f) =>
          emitIfOpen(state.copyWith(saving: false, error: f.message)),
    );
    if (wasNew && venueId != null) unawaited(_loadVenueParts());
  }

  Future<void> uploadVenuePhoto(Uint8List bytes) async {
    emitIfOpen(state.copyWith(uploading: true, error: null));
    final upload = await venueSetupRepo.uploadImage(
      bytes,
      VenueMediaPurpose.venuePhoto,
    );
    final path = upload.when(success: (p) => p, failure: (_) => null);
    if (path == null) {
      return _failed(upload);
    }
    final id = venueId;
    if (id == null) {
      emitIfOpen(
        state.copyWith(
          uploading: false,
          pendingVenuePhotos: [...state.pendingVenuePhotos, path],
        ),
      );
      return;
    }
    final added = await venueSetupRepo.addVenuePhoto(id, path);
    if (added is! Success) return _failed(added);
    emitIfOpen(
      state.copyWith(
        uploading: false,
        venue: _withPhotos(state.venue!, [...state.venue!.photos, path]),
      ),
    );
  }

  Future<void> removeVenuePhoto(String path) async {
    final id = venueId;
    if (id == null) {
      emitIfOpen(
        state.copyWith(
          pendingVenuePhotos: [
            for (final p in state.pendingVenuePhotos)
              if (p != path) p,
          ],
        ),
      );
      return;
    }
    emitIfOpen(state.copyWith(uploading: true, error: null));
    final result = await venueSetupRepo.removeVenuePhoto(id, path);
    if (result is! Success) return _failed(result);
    emitIfOpen(
      state.copyWith(
        uploading: false,
        venue: _withPhotos(state.venue!, [
          for (final p in state.venue!.photos)
            if (p != path) p,
        ]),
      ),
    );
  }

  Future<void> uploadDraftPitchPhoto(Uint8List bytes) async {
    emitIfOpen(state.copyWith(uploading: true, error: null));
    final upload = await venueSetupRepo.uploadImage(
      bytes,
      VenueMediaPurpose.pitchPhoto,
    );
    upload.when(
      success: (path) => emitIfOpen(
        state.copyWith(
          uploading: false,
          draftPitchPhotos: [...state.draftPitchPhotos, path],
        ),
      ),
      failure: (f) =>
          emitIfOpen(state.copyWith(uploading: false, error: f.message)),
    );
  }

  void removeDraftPitchPhoto(String path) => emitIfOpen(
    state.copyWith(
      draftPitchPhotos: [
        for (final p in state.draftPitchPhotos)
          if (p != path) p,
      ],
    ),
  );

  /// Returns true once the pitch was added (so the form clears its name).
  Future<bool> addPitch({
    required String name,
    required String turfType,
    required int capacity,
  }) async {
    final id = venueId;
    if (id == null || name.trim().isEmpty || state.saving) return false;
    emitIfOpen(state.copyWith(saving: true, error: null));
    final result = await venueSetupRepo.addPitch(
      id,
      name: name,
      turfType: turfType,
      capacity: capacity,
      photos: state.draftPitchPhotos,
    );
    if (result is! Success) {
      _failed(result);
      return false;
    }
    emitIfOpen(state.copyWith(saving: false, draftPitchPhotos: const []));
    await _reloadPitches();
    return true;
  }

  Future<void> deletePitch(String pitchId) async {
    emitIfOpen(state.copyWith(saving: true, error: null));
    final result = await venueSetupRepo.deletePitch(pitchId);
    if (result is! Success) return _failed(result);
    emitIfOpen(state.copyWith(saving: false));
    await _reloadPitches();
  }

  Future<void> uploadPitchPhoto(String pitchId, Uint8List bytes) async {
    final id = venueId;
    if (id == null) return;
    emitIfOpen(state.copyWith(uploading: true, error: null));
    final upload = await venueSetupRepo.uploadImage(
      bytes,
      VenueMediaPurpose.pitchPhoto,
    );
    final path = upload.when(success: (p) => p, failure: (_) => null);
    if (path == null) return _failed(upload);
    final added = await venueSetupRepo.addPitchPhoto(id, pitchId, path);
    if (added is! Success) return _failed(added);
    emitIfOpen(state.copyWith(uploading: false));
    await _reloadPitches();
  }

  Future<void> removePitchPhoto(String pitchId, String path) async {
    final id = venueId;
    if (id == null) return;
    emitIfOpen(state.copyWith(uploading: true, error: null));
    final result = await venueSetupRepo.removePitchPhoto(id, pitchId, path);
    if (result is! Success) return _failed(result);
    emitIfOpen(state.copyWith(uploading: false));
    await _reloadPitches();
  }

  Future<void> _reloadPitches() async {
    final id = venueId;
    if (id == null) return;
    (await venueSetupRepo.getPitches(id)).when(
      success: (p) => emitIfOpen(state.copyWith(pitches: p)),
      failure: (_) {},
    );
  }

  void setDay(int day, DayHours hours) =>
      emitIfOpen(state.copyWith(week: {...state.week, day: hours}));

  Future<void> saveSchedules() async {
    final id = venueId;
    if (id == null || state.saving) return;
    emitIfOpen(state.copyWith(saving: true, error: null));
    final result = await venueSetupRepo.saveSchedules(id, state.week);
    result.when(
      success: (_) => emitIfOpen(state.copyWith(saving: false, step: 4)),
      failure: (f) =>
          emitIfOpen(state.copyWith(saving: false, error: f.message)),
    );
  }

  Future<void> submitForReview(String message) async {
    final id = venueId;
    if (id == null || state.saving) return;
    emitIfOpen(state.copyWith(saving: true, error: null));
    final result = await venueSetupRepo.submitForReview(id, message);
    result.when(
      success: (approval) =>
          emitIfOpen(state.copyWith(saving: false, approval: approval)),
      failure: (f) =>
          emitIfOpen(state.copyWith(saving: false, error: f.message)),
    );
  }

  void _failed(ApiResult<Object?> result) => emitIfOpen(
    state.copyWith(
      saving: false,
      uploading: false,
      error: result.when(success: (_) => null, failure: (f) => f.message),
    ),
  );

  static VenueModel _withPhotos(VenueModel v, List<String> photos) =>
      VenueModel(
        id: v.id,
        name: v.name,
        description: v.description,
        address: v.address,
        city: v.city,
        area: v.area,
        latitude: v.latitude,
        longitude: v.longitude,
        phoneNumber: v.phoneNumber,
        approvalStatus: v.approvalStatus,
        isApproved: v.isApproved,
        isPublished: v.isPublished,
        facilities: v.facilities,
        photos: photos,
        pitches: v.pitches,
        pricingModel: v.pricingModel,
        commissionType: v.commissionType,
        commissionRate: v.commissionRate,
      );
}
