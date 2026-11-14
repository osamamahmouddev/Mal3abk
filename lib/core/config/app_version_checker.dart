/// Semantic version comparator to enforce force-updates when the installed app
/// version falls below the backend's minimum supported version.
class AppVersionChecker {
  const AppVersionChecker();

  /// Compares semantic versions `v1` and `v2`.
  /// Returns negative if v1 < v2, zero if v1 == v2, positive if v1 > v2.
  static int compareVersions(String v1, String v2) {
    final clean1 = v1.split('+').first.trim();
    final clean2 = v2.split('+').first.trim();

    final parts1 = clean1.split('.').map((p) => int.tryParse(p) ?? 0).toList();
    final parts2 = clean2.split('.').map((p) => int.tryParse(p) ?? 0).toList();

    final maxLen = parts1.length > parts2.length
        ? parts1.length
        : parts2.length;
    for (var i = 0; i < maxLen; i++) {
      final num1 = i < parts1.length ? parts1[i] : 0;
      final num2 = i < parts2.length ? parts2[i] : 0;
      if (num1 != num2) {
        return num1.compareTo(num2);
      }
    }
    return 0;
  }

  /// True if [currentVersion] is strictly lower than [minSupportedVersion].
  static bool isUpdateRequired({
    required String currentVersion,
    required String minSupportedVersion,
  }) {
    if (minSupportedVersion.isEmpty) return false;
    return compareVersions(currentVersion, minSupportedVersion) < 0;
  }
}
