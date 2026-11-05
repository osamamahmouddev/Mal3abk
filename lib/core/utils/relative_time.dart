import 'package:easy_localization/easy_localization.dart';

import '../extensions/app_display_extensions.dart';
import 'cairo_time.dart';

/// "منذ ١٠ دقائق"-style age of a server timestamp; a date after a week.
class RelativeTime {
  const RelativeTime._();

  static String since(DateTime utc, String languageCode, {DateTime? nowUtc}) {
    final elapsed = (nowUtc ?? DateTime.now().toUtc()).difference(utc.toUtc());
    String ago(String unit, int value) =>
        'common.ago.$unit'.tr(args: [value.toLocalizedDigits(languageCode)]);
    if (elapsed.inMinutes < 1) return 'common.ago.now'.tr();
    if (elapsed.inHours < 1) return ago('minutes', elapsed.inMinutes);
    if (elapsed.inDays < 1) return ago('hours', elapsed.inHours);
    if (elapsed.inDays < 7) return ago('days', elapsed.inDays);
    return CairoTime.shortDate(utc, languageCode);
  }
}
