import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/config/app_version_checker.dart';

void main() {
  group('AppVersionChecker', () {
    test('compares semantic versions accurately', () {
      expect(AppVersionChecker.compareVersions('1.0.0', '1.0.0'), equals(0));
      expect(AppVersionChecker.compareVersions('1.0.0', '1.0.1'), isNegative);
      expect(AppVersionChecker.compareVersions('1.1.0', '1.0.9'), isPositive);
      expect(AppVersionChecker.compareVersions('2.0.0', '1.9.9'), isPositive);
      expect(AppVersionChecker.compareVersions('1.0.0+1', '1.0.0+2'), equals(0));
    });

    test('isUpdateRequired returns true when current is strictly lower than minSupported', () {
      expect(
        AppVersionChecker.isUpdateRequired(
          currentVersion: '1.0.0',
          minSupportedVersion: '1.1.0',
        ),
        isTrue,
      );

      expect(
        AppVersionChecker.isUpdateRequired(
          currentVersion: '1.2.0',
          minSupportedVersion: '1.1.0',
        ),
        isFalse,
      );

      expect(
        AppVersionChecker.isUpdateRequired(
          currentVersion: '1.1.0',
          minSupportedVersion: '1.1.0',
        ),
        isFalse,
      );

      expect(
        AppVersionChecker.isUpdateRequired(
          currentVersion: '1.0.0',
          minSupportedVersion: '',
        ),
        isFalse,
      );
    });
  });
}
