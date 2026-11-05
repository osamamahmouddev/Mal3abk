import 'package:intl/intl.dart';
import 'package:timezone/data/latest_10y.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Every slot, booking and match time is shown in Egyptian local time, whatever the
/// device's own time zone. Uses the IANA database, so DST changes are handled.
class CairoTime {
  const CairoTime._();

  static late tz.Location _cairo;

  static void initialize() {
    tz_data.initializeTimeZones();
    _cairo = tz.getLocation('Africa/Cairo');
  }

  static tz.TZDateTime fromUtc(DateTime utc) =>
      tz.TZDateTime.from(utc.toUtc(), _cairo);

  static tz.TZDateTime now() => tz.TZDateTime.now(_cairo);

  /// Midnight today in Cairo, as a plain calendar date.
  static DateTime today() {
    final local = now();
    return DateTime(local.year, local.month, local.day);
  }

  /// The UTC instant of [hour]:00 Cairo time on the calendar [day].
  static DateTime toUtc(DateTime day, int hour) =>
      tz.TZDateTime(_cairo, day.year, day.month, day.day, hour).toUtc();

  static String weekday(DateTime day, String languageCode) =>
      DateFormat('EEE', languageCode).format(day);

  static String hourLabel(int hour, String languageCode) =>
      DateFormat('h a', languageCode).format(DateTime(2000, 1, 1, hour));

  /// "السبت ٢ أغسطس · ٩:٠٠ م"
  static String dayAndTime(DateTime utc, String languageCode) {
    final local = fromUtc(utc);
    final day = DateFormat('EEEE d MMMM', languageCode).format(local);
    final time = DateFormat('h:mm a', languageCode).format(local);
    return '$day · $time';
  }

  /// "٢ أغسطس"
  static String shortDate(DateTime utc, String languageCode) =>
      DateFormat('d MMMM', languageCode).format(fromUtc(utc));

  static String time(DateTime utc, String languageCode) =>
      DateFormat('h:mm a', languageCode).format(fromUtc(utc));
}
