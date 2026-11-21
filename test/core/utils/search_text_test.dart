import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/utils/search_text.dart';

void main() {
  test('Arabic spelling variants still match', () {
    expect(SearchText.matches('الإسكندرية', 'الاسكندريه'), isTrue);
    expect(SearchText.matches('مدينة نصر', 'مدينه'), isTrue);
    expect(SearchText.matches('بني سويف', 'بنى'), isTrue);
    expect(SearchText.matches('القاهرة', 'القاهرةُ'), isTrue);
  });

  test('English ignores case, and an empty query matches all', () {
    expect(SearchText.matches('Nasr City', 'nasr'), isTrue);
    expect(SearchText.matches('Nasr City', '   '), isTrue);
    expect(SearchText.matches('Nasr City', 'maadi'), isFalse);
  });
}
