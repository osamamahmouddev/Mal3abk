import 'dart:math' as math;

import '../../../core/utils/cairo_time.dart';
import '../data/models/calendar_slot_model.dart';
import '../data/models/manual_booking_request_body.dart';
import '../data/models/operating_schedule_model.dart';
import 'cubit/venue_calendar_cubit.dart';
import 'cubit/venue_calendar_state.dart';

/// One column of the time grid: a pitch (day view) or a day (week view).
class CalendarColumn {
  const CalendarColumn({
    required this.key,
    required this.label,
    required this.date,
    required this.pitchId,
  });

  final String key;
  final String label;
  final DateTime date;
  final String pitchId;
}

/// Time math shared by the calendar widgets, ported from the web calendar.
abstract final class CalendarLayout {
  static const int defaultFirstHour = 8;
  static const int defaultLastHour = 26;

  /// Minutes from the business day's Cairo midnight to [utc].
  static double minutesFrom(DateTime date, DateTime utc) =>
      utc.difference(VenueCalendarCubit.dayStartUtc(date)).inSeconds / 60;

  static CalendarHour hourOf(CalendarColumn column, int hour) {
    final start = VenueCalendarCubit.dayStartUtc(
      column.date,
    ).add(Duration(hours: hour));
    return CalendarHour(
      pitchId: column.pitchId,
      start: start,
      end: start.add(const Duration(hours: 1)),
    );
  }

  /// The hours of [column] nothing is booked or blocked in.
  static List<CalendarHour> freeHours(
    CalendarColumn column,
    List<int> hours,
    List<CalendarSlotModel> slots,
  ) => [
    for (final h in hours)
      if (!slots.any(
        (s) =>
            s.pitchId == column.pitchId &&
            s.overlaps(hourOf(column, h).start, hourOf(column, h).end),
      ))
        hourOf(column, h),
  ];

  /// Cairo calendar date a slot starts on.
  static DateTime localDate(DateTime utc) {
    final local = CairoTime.fromUtc(utc);
    return DateTime(local.year, local.month, local.day);
  }

  /// The grid's hour range from the opening hours, never clipping a booking.
  static (int, int) visibleHours(
    List<OperatingScheduleModel> schedules,
    DateTime date,
    VenueCalendarView view,
    List<CalendarSlotModel> slots,
  ) {
    var first = defaultFirstHour;
    var last = defaultLastHour;
    final active = schedules.where((s) => s.isActive).toList();
    if (active.isNotEmpty) {
      final day = view == VenueCalendarView.day
          ? active.where((s) => s.dayOfWeek == date.weekday % 7).firstOrNull
          : null;
      if (day != null) {
        first = day.openHour;
        last = day.closeHourFromDayStart;
      } else {
        first = active.map((s) => s.openHour).reduce(math.min);
        last = active.map((s) => s.closeHourFromDayStart).reduce(math.max);
      }
    }
    if (slots.isNotEmpty) {
      var minStart = double.infinity;
      var maxEnd = double.negativeInfinity;
      for (final s in slots) {
        final start = minutesFrom(localDate(s.start), s.start) / 60;
        final end = start + s.end.difference(s.start).inMinutes / 60;
        minStart = math.min(minStart, start);
        maxEnd = math.max(maxEnd, end);
      }
      first = math.max(0, math.min(first, minStart.floor()));
      last = math.min(30, math.max(last, maxEnd.ceil()));
    }
    if (last <= first) last = first + 6;
    return (first, last);
  }
}
