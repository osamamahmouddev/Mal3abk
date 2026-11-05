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
