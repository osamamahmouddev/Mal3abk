import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/local_storage/device_id_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  group('DeviceIdStorage', () {
    test('generates a UUID v4 on first read', () async {
      final id = await DeviceIdStorage().readDeviceId();

      expect(
        id,
        matches(
          RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
          ),
        ),
      );
    });

    test('returns the same id for the same install', () async {
      final first = await DeviceIdStorage().readDeviceId();
      final second = await DeviceIdStorage().readDeviceId();

      expect(second, first);
    });
  });
}
