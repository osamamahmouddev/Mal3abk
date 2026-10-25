extension StringNullOrEmpty on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension ListNullOrEmpty<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension LocalizedDigits on int {
  static const _arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

  /// Renders the number with Arabic-Indic digits when [languageCode] is `ar`.
  String toLocalizedDigits(String languageCode) {
    final latin = toString();
    if (languageCode != 'ar') return latin;
    return latin.split('').map((d) => _arabicDigits[int.parse(d)]).join();
  }
}
