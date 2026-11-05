extension StringNullOrEmpty on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension ListNullOrEmpty<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension LocalizedArabicString on String {
  static const _latinChars = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.',
  ];
  static const _arabicChars = [
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
    '٫',
  ];

  /// Converts Latin digits and decimal points to Arabic-Indic digits.
  String toArabicDigits() {
    var result = this;
    for (var i = 0; i < _latinChars.length; i++) {
      result = result.replaceAll(_latinChars[i], _arabicChars[i]);
    }
    return result;
  }
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

extension NameInitials on String {
  /// First letters of up to the first two words: "فريق النجوم" -> "فن".
  String get initials {
    final words = trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    return words.take(2).map((w) => String.fromCharCode(w.runes.first)).join();
  }
}
