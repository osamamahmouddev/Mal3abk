class AppLocale {
  const AppLocale._();

  static String _currentLanguage = 'ar';

  static String get currentLanguage => _currentLanguage;

  static void update(String languageCode) {
    _currentLanguage = languageCode;
  }

  static bool get isArabic => _currentLanguage == 'ar';
  static bool get isEnglish => _currentLanguage == 'en';
}
