import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/device/device_identity_provider.dart';

void main() {
  group('makeAndModel', () {
    test('prefixes the capitalised maker', () {
      expect(
        DeviceIdentityProvider.makeAndModel('samsung', 'SM-S911B'),
        'Samsung SM-S911B',
      );
    });

    test('does not repeat a maker already in the model', () {
      expect(
        DeviceIdentityProvider.makeAndModel('Google', 'Google Pixel 8'),
        'Google Pixel 8',
      );
    });

    test('falls back to the model when the maker is unknown', () {
      expect(DeviceIdentityProvider.makeAndModel(' ', 'X1'), 'X1');
    });
  });

  group('headerSafe', () {
    test('drops characters a header cannot carry', () {
      expect(
        DeviceIdentityProvider.headerSafe('Pixel 8 ™ موبايل', 100),
        'Pixel8',
      );
    });

    test('clips long values and rejects empty ones', () {
      expect(DeviceIdentityProvider.headerSafe('abcdef', 3), 'abc');
      expect(DeviceIdentityProvider.headerSafe('  ', 10), isNull);
      expect(DeviceIdentityProvider.headerSafe(null, 10), isNull);
    });
  });
}
