/// Loose matching for short pick lists typed in Arabic or English: ignores
/// case, Arabic diacritics and the common spelling variants (أ إ آ → ا,
/// ة → ه, ى → ي), so "الاسكندريه" finds "الإسكندرية".
class SearchText {
  const SearchText._();

  static final RegExp _diacritics = RegExp('[ً-ْـ]');

  static String normalize(String value) => value
      .toLowerCase()
      .replaceAll(_diacritics, '')
      .replaceAll(RegExp('[أإآ]'), 'ا')
      .replaceAll('ة', 'ه')
      .replaceAll('ى', 'ي')
      .trim();

  /// Whether [candidate] contains [query] by the loose rules above.
  static bool matches(String candidate, String query) {
    final q = normalize(query);
    return q.isEmpty || normalize(candidate).contains(q);
  }
}
