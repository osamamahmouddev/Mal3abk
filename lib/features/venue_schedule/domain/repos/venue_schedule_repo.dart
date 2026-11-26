import '../../../../core/network/api_result.dart';
import '../../../venue_calendar/data/models/operating_schedule_model.dart';
import '../../../venue_setup/data/models/venue_setup_form.dart';
import '../../data/models/venue_schedule_models.dart';

abstract class VenueScheduleRepo {
  Future<ApiResult<List<OperatingScheduleModel>>> getVenueWeek(String venueId);

  /// Bookings the new venue hours would leave outside the schedule.
  Future<ApiResult<List<UpcomingBookingRefModel>>> previewVenueWeek(
    String venueId,
    Map<int, DayHours> week,
  );

  Future<ApiResult<void>> saveVenueWeek(
    String venueId,
    Map<int, DayHours> week,
  );

  Future<ApiResult<SpecialSchedulesModel>> getSpecialSchedules(String venueId);

  Future<ApiResult<ScheduleChangeResult>> savePitchWeek(
    String venueId,
    String pitchId,
    Map<int, DayHours> week, {
    required bool confirm,
  });

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
  });

  Future<ApiResult<ScheduleChangeResult>> closeHolidays(
    String venueId, {
    required int year,
    String? pitchId,
    required bool confirm,
  });

  Future<ApiResult<void>> removeOverride(String venueId, String overrideId);

  Future<ApiResult<void>> saveRules(String venueId, BookingRulesModel rules);
}
