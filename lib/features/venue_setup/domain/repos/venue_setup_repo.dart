import 'dart:typed_data';

import '../../../../core/network/api_result.dart';
import '../../../venue_calendar/data/models/operating_schedule_model.dart';
import '../../../venue_overview/data/models/venue_approval_model.dart';
import '../../../venue_shell/data/models/venue_model.dart';
import '../../../venue_shell/data/models/venue_pitch_model.dart';
import '../../data/models/venue_setup_form.dart';

/// `MediaPurpose` on the API.
enum VenueMediaPurpose {
  venuePhoto(0),
  pitchPhoto(1);

  const VenueMediaPurpose(this.value);
  final int value;
}

abstract class VenueSetupRepo {
  /// Creates the venue when [venueId] is null, otherwise updates it.
  Future<ApiResult<VenueModel>> saveVenue(String? venueId, VenueSetupForm form);

  Future<ApiResult<List<VenuePitchModel>>> getPitches(String venueId);

  Future<ApiResult<void>> addPitch(
    String venueId, {
    required String name,
    required String turfType,
    required int capacity,
    required List<String> photos,
  });

  Future<ApiResult<void>> deletePitch(String pitchId);

  /// Cleans the picked image (real type check, no EXIF) and uploads it;
  /// returns the media path to store (`/api/v1/media/{id}/medium`).
  Future<ApiResult<String>> uploadImage(
    Uint8List bytes,
    VenueMediaPurpose purpose,
  );

  Future<ApiResult<void>> addVenuePhoto(String venueId, String mediaPath);

  Future<ApiResult<void>> removeVenuePhoto(String venueId, String mediaPath);

  Future<ApiResult<void>> addPitchPhoto(
    String venueId,
    String pitchId,
    String mediaPath,
  );

  Future<ApiResult<void>> removePitchPhoto(
    String venueId,
    String pitchId,
    String mediaPath,
  );

  Future<ApiResult<List<OperatingScheduleModel>>> getSchedules(String venueId);

  Future<ApiResult<void>> saveSchedules(
    String venueId,
    Map<int, DayHours> week,
  );

  Future<ApiResult<VenueApprovalModel>> getApproval(String venueId);

  Future<ApiResult<VenueApprovalModel>> submitForReview(
    String venueId,
    String message,
  );
}
