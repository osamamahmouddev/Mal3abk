import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/utils/cairo_time.dart';

void main() {
  group('CairoTime.parseUtc', () {
    test('reads an ISO-8601 UTC time', () {
      expect(
        CairoTime.parseUtc('2026-12-01T18:00:00Z'),
        DateTime.utc(2026, 12, 1, 18),
      );
    });

    test('converts an offset time to UTC', () {
      expect(
        CairoTime.parseUtc('2026-12-01T20:00:00+02:00'),
        DateTime.utc(2026, 12, 1, 18),
      );
    });

    test('never throws on a malformed value', () {
      expect(
        CairoTime.parseUtc('not a date'),
        DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      );
      expect(
        CairoTime.parseUtc(''),
        DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      );
    });
  });
}
