import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/calendar_slot_model.dart';
import '../../data/models/manual_booking_request_body.dart';
import '../../data/models/operating_schedule_model.dart';

part 'venue_calendar_state.freezed.dart';

enum VenueCalendarView { day, week, month }

@freezed
abstract class VenueCalendarState with _$VenueCalendarState {
  const factory VenueCalendarState({
    required VenueCalendarView view,

    /// The Cairo calendar date in focus (time part is midnight).
    required DateTime date,

    /// The pitch the week view shows.
    String? weekPitchId,
    @Default([]) List<CalendarSlotModel> slots,
    @Default([]) List<OperatingScheduleModel> schedules,
    @Default(true) bool isLoading,
    String? error,

    /// Picking many hours at once: free hours to book, or the venue's own
    /// bookings and blocked periods to free.
    @Default(false) bool picking,
    @Default({}) Map<String, CalendarHour> pickedHours,

    /// Picked taken slots: id → whether it is a blocked period.
    @Default({}) Map<String, bool> pickedTaken,
    @Default(false) bool busy,
  }) = _VenueCalendarState;
}
