import 'package:dio/dio.dart';

import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../../venue_calendar/data/models/operating_schedule_model.dart';
import '../../../venue_setup/data/models/venue_setup_form.dart';
import '../../domain/repos/venue_schedule_repo.dart';
import '../apis/venue_schedule_api_service.dart';
import '../models/venue_schedule_models.dart';

class VenueScheduleRepoImpl implements VenueScheduleRepo {
  VenueScheduleRepoImpl({required this.apiService});

  final VenueScheduleApiService apiService;

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  /// A change that would orphan confirmed bookings answers 409 with them;
  /// that is not a failure, the user decides whether to go on.
  Future<ApiResult<ScheduleChangeResult>> _change(
    Future<void> Function() call,
  ) async {
    try {
      await call();
      return const ApiResult.success(ScheduleChangeResult(applied: true));
    } on DioException catch (e, st) {
      final data = e.response?.data;
      if (e.response?.statusCode == 409 &&
          data is Map &&
          data['affectedBookings'] is List) {
        return ApiResult.success(
          ScheduleChangeResult(
            applied: false,
            affected: _refs(data['affectedBookings']),
          ),
        );
      }
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  static List<UpcomingBookingRefModel> _refs(Object? list) => [
    for (final item in (list as List? ?? const []))
      if (item is Map<String, dynamic>) UpcomingBookingRefModel.fromJson(item),
  ];

  static String _time(String hhmm) => hhmm.length == 5 ? '$hhmm:00' : hhmm;

  @override
  Future<ApiResult<List<OperatingScheduleModel>>> getVenueWeek(
    String venueId,
  ) => _guard(() => apiService.getSchedules(venueId));

  @override
  Future<ApiResult<List<UpcomingBookingRefModel>>> previewVenueWeek(
    String venueId,
    Map<int, DayHours> week,
  ) => _guard(() async {
    final json = await apiService.previewImpact(venueId, {
      'days': [
        for (final d in DayHours.dayOrder)
          if (week[d] case final day?)
            {
              'dayOfWeek': d,
              'openTime': _time(day.open),
              'closeTime': _time(day.close),
              'isActive': day.on,
            },
      ],
    });
    return json is Map ? _refs(json['affectedBookings']) : const [];
  });

  @override
  Future<ApiResult<void>> saveVenueWeek(
    String venueId,
    Map<int, DayHours> week,
  ) => _guard(
    () => apiService.saveSchedules(venueId, {
      'schedules': [
        for (final d in DayHours.dayOrder)
          if (week[d] case final day? when day.on)
            {
              'dayOfWeek': d,
              'openTime': _time(day.open),
              'closeTime': _time(day.close),
              'slotDurationMinutes': day.slot,
              'isActive': true,
            },
      ],
    }),
  );

  @override
  Future<ApiResult<SpecialSchedulesModel>> getSpecialSchedules(
    String venueId,
  ) => _guard(() => apiService.getSpecialSchedules(venueId));

  @override
  Future<ApiResult<ScheduleChangeResult>> savePitchWeek(
    String venueId,
    String pitchId,
    Map<int, DayHours> week, {
    required bool confirm,
  }) => _change(
    () => apiService.savePitchHours(venueId, pitchId, {
      'days': [
        for (final d in DayHours.dayOrder)
          if (week[d] case final day?)
            {
              'dayOfWeek': d,
              'openTime': _time(day.open),
              'closeTime': _time(day.close),
              'isClosed': !day.on,
            },
      ],
      'confirm': confirm,
    }),
  );

  @override
  Future<ApiResult<ScheduleChangeResult>> addOverride(
    String venueId, {
    String? pitchId,
    required String startDate,
    String? endDate,
    required ScheduleOverrideKind kind,
    String? fromTime,
    String? toTime,
    required String reason,
    required bool confirm,
  }) => _change(
    () => apiService.addOverride(venueId, {
      'pitchId': pitchId,
      'startDate': startDate,
      'endDate': (endDate?.isEmpty ?? true) ? null : endDate,
      'kind': kind.index,
      'fromTime': kind == ScheduleOverrideKind.closure || fromTime == null
          ? null
          : _time(fromTime),
      'toTime': kind == ScheduleOverrideKind.closure || toTime == null
          ? null
          : _time(toTime),
      'reason': reason.trim(),
      'confirm': confirm,
    }),
  );

  @override
  Future<ApiResult<ScheduleChangeResult>> closeHolidays(
    String venueId, {
    required int year,
    String? pitchId,
    required bool confirm,
  }) => _change(
    () => apiService.closeHolidays(venueId, {
      'year': year,
      'pitchId': pitchId,
      'confirm': confirm,
    }),
  );

  @override
  Future<ApiResult<void>> removeOverride(String venueId, String overrideId) =>
      _guard(() => apiService.removeOverride(venueId, overrideId));

  @override
  Future<ApiResult<void>> saveRules(String venueId, BookingRulesModel rules) =>
      _guard(() => apiService.saveRules(venueId, rules.toJson()));
}
