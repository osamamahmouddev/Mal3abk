extension StringNullOrEmpty on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension ListNullOrEmpty<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension LocalizedDigits on int {
  static const _arabicDigits = [
    '٠',
    '١',
    '٢',
    '٣',
    '٤',
    '٥',
    '٦',
    '٧',
    '٨',
    '٩',
  ];

  /// Renders the number with Arabic-Indic digits when [languageCode] is `ar`.
  String toLocalizedDigits(String languageCode) {
    final latin = toString();
    if (languageCode != 'ar') return latin;
    return latin.split('').map((d) => _arabicDigits[int.parse(d)]).join();
  }
}

extension LatinDigits on String {
  static const _arabicDigits = '٠١٢٣٤٥٦٧٨٩';
  static const _persianDigits = '۰۱۲۳۴۵۶۷۸۹';

  /// Converts Arabic-Indic and Persian digits to Latin digits, so input typed
  /// on an Arabic keyboard reaches the API as `0-9`.
  String toLatinDigits() {
    final buffer = StringBuffer();
    for (final char in split('')) {
      final arabicIndex = _arabicDigits.indexOf(char);
      final persianIndex = _persianDigits.indexOf(char);
      if (arabicIndex >= 0) {
        buffer.write(arabicIndex);
      } else if (persianIndex >= 0) {
        buffer.write(persianIndex);
      } else {
        buffer.write(char);
      }
    }
    return buffer.toString();
  }
}
