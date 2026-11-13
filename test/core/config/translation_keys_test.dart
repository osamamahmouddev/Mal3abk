import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Set<String> _keys(Map<String, dynamic> json, [String prefix = '']) => {
  for (final entry in json.entries)
    if (entry.value is Map<String, dynamic>)
      ..._keys(entry.value as Map<String, dynamic>, '$prefix${entry.key}.')
    else
      '$prefix${entry.key}',
};

/// Arabic has plural forms English lacks (`.two`, `.few`, `.many`, `.zero`).
bool _isArabicOnlyPlural(String key) =>
    const ['.zero', '.two', '.few', '.many'].any(key.endsWith);

void main() {
  test('ar.json and en.json define the same keys', () {
    final ar = _keys(
      jsonDecode(File('assets/translations/ar.json').readAsStringSync())
          as Map<String, dynamic>,
    );
    final en = _keys(
      jsonDecode(File('assets/translations/en.json').readAsStringSync())
          as Map<String, dynamic>,
    );

    expect(
      ar.where((k) => !_isArabicOnlyPlural(k)).toSet().difference(en),
      isEmpty,
      reason: 'only in ar.json',
    );
    expect(en.difference(ar), isEmpty, reason: 'only in en.json');
  });

  test('the explore header has no leftover mock-up text', () {
    final ar = File('assets/translations/ar.json').readAsStringSync();
    final en = File('assets/translations/en.json').readAsStringSync();

    for (final text in [ar, en]) {
      expect(text, isNot(contains('"summary_when"')));
      expect(text, isNot(contains('"summary_area"')));
    }
  });
}
