import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../../../core/utils/image_sanitizer.dart';
import '../../../venue_calendar/data/models/operating_schedule_model.dart';
import '../../../venue_overview/data/models/venue_approval_model.dart';
import '../../../venue_shell/data/models/venue_model.dart';
import '../../../venue_shell/data/models/venue_pitch_model.dart';
import '../../domain/repos/venue_setup_repo.dart';
import '../apis/venue_setup_api_service.dart';
import '../models/venue_setup_form.dart';

class VenueSetupRepoImpl implements VenueSetupRepo {
  VenueSetupRepoImpl({
    required this.apiService,
    required this.dio,
    this.imageSanitizer = const ImageSanitizer(),
  });

  final VenueSetupApiService apiService;
  final Dio dio;
  final ImageSanitizer imageSanitizer;

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  /// The id of an uploaded photo; null for a link hosted elsewhere.
  static String? mediaIdOf(String path) {
    if (!path.startsWith('/api/v1/media/')) return null;
    final parts = path.split('/');
    return parts.length > 4 ? parts[4] : null;
  }

  @override
  Future<ApiResult<VenueModel>> saveVenue(
    String? venueId,
    VenueSetupForm form,
  ) => _guard(
    () => venueId == null
        ? apiService.createVenue(form.toJson())
        : apiService.updateVenue(venueId, form.toJson()),
  );

  @override
  Future<ApiResult<List<VenuePitchModel>>> getPitches(String venueId) =>
      _guard(() => apiService.getPitches(venueId));

  @override
  Future<ApiResult<void>> addPitch(
    String venueId, {
    required String name,
    required String turfType,
    required int capacity,
    required List<String> photos,
  }) => _guard(
    () => apiService.createPitch(venueId, {
      'name': name.trim(),
      'turfType': turfType,
      'capacity': capacity,
      'photos': photos,
    }),
  );

  @override
  Future<ApiResult<void>> deletePitch(String pitchId) =>
      _guard(() => apiService.deletePitch(pitchId));

  @override
  Future<ApiResult<String>> uploadImage(
    Uint8List bytes,
    VenueMediaPurpose purpose,
  ) => _guard(() async {
    final clean = await imageSanitizer.sanitize(bytes);
    if (clean == null) {
      throw const AppApiFailure(
        message: 'errors.media.invalid_image',
        code: 'Media.Rejected',
      );
    }
    final ticket = await apiService.createUpload({'purpose': purpose.value});
    if (ticket.maxBytes != null && clean.length > ticket.maxBytes!) {
      throw const AppApiFailure(
        message: 'errors.media.too_large',
        code: 'Media.TooLarge',
      );
    }
    await dio.put<dynamic>(
      ticket.uploadUrl.startsWith('/') || ticket.uploadUrl.startsWith('http')
          ? ticket.uploadUrl
          : '/${ticket.uploadUrl}',
      data: clean,
      options: Options(
        headers: {
          Headers.contentTypeHeader: ImageSanitizer.contentType,
          Headers.contentLengthHeader: clean.length,
        },
      ),
    );
    return '/api/v1/media/${ticket.mediaId}/medium';
  });

  @override
  Future<ApiResult<void>> addVenuePhoto(String venueId, String mediaPath) =>
      _guard(
        () => apiService.addVenuePhoto(venueId, {
          'mediaId': mediaIdOf(mediaPath),
        }),
      );

  @override
  Future<ApiResult<void>> removeVenuePhoto(String venueId, String mediaPath) =>
      _guard(() async {
        final id = mediaIdOf(mediaPath);
        if (id != null) await apiService.removeVenuePhoto(venueId, id);
      });

  @override
  Future<ApiResult<void>> addPitchPhoto(
    String venueId,
    String pitchId,
    String mediaPath,
  ) => _guard(
    () => apiService.addPitchPhoto(venueId, pitchId, {
      'mediaId': mediaIdOf(mediaPath),
    }),
  );

  @override
  Future<ApiResult<void>> removePitchPhoto(
    String venueId,
    String pitchId,
    String mediaPath,
  ) => _guard(() async {
    final id = mediaIdOf(mediaPath);
    if (id != null) await apiService.removePitchPhoto(venueId, pitchId, id);
  });

  @override
  Future<ApiResult<List<OperatingScheduleModel>>> getSchedules(
    String venueId,
  ) => _guard(() => apiService.getSchedules(venueId));

  @override
  Future<ApiResult<void>> saveSchedules(
    String venueId,
    Map<int, DayHours> week,
  ) => _guard(
    () => apiService.saveSchedules(venueId, {
      'schedules': [
        for (final d in DayHours.dayOrder)
          if (week[d]?.on ?? false)
            {
              'dayOfWeek': d,
              'openTime': '${week[d]!.open}:00',
              'closeTime': '${week[d]!.close}:00',
              'slotDurationMinutes': week[d]!.slot,
              'isActive': true,
            },
      ],
    }),
  );

  @override
  Future<ApiResult<VenueApprovalModel>> getApproval(String venueId) =>
      _guard(() => apiService.getApproval(venueId));

  @override
  Future<ApiResult<VenueApprovalModel>> submitForReview(
    String venueId,
    String message,
  ) => _guard(
    () => apiService.submitForReview(venueId, {
      'message': message.trim().isEmpty ? null : message.trim(),
    }),
  );
}
