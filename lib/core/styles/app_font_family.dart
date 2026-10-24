class AppFontFamily {
  const AppFontFamily._();

  static const String ibmPlexSansArabic = 'IBMPlexSansArabic';
  static const String fustat = 'Fustat';

  static String getFontFamily(String languageCode) {
    if (languageCode == 'ar') {
      return ibmPlexSansArabic;
    }
    return ibmPlexSansArabic;
  }
}
