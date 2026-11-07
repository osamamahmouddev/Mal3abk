import '../extensions/app_display_extensions.dart';

/// "9:58" (Arabic digits in Arabic) for a countdown of [seconds].
class CountdownClock {
  const CountdownClock._();

  static String format(int seconds, String languageCode) {
    final raw = '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';
    return languageCode == 'ar' ? raw.toArabicDigits() : raw;
  }
}
