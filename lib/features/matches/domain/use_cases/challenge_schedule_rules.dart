import '../../../../core/network/app_api_failure.dart';

/// Mirrors the server's challenge rules so obvious mistakes fail before a
/// round trip; the server still enforces them.
class ChallengeScheduleRules {
  const ChallengeScheduleRules._();

  static const int minDurationMinutes = 30;
  static const int maxDurationMinutes = 180;

  static AppApiFailure? check({
    required DateTime proposedUtc,
    required int durationMinutes,
    required DateTime nowUtc,
  }) {
    if (durationMinutes < minDurationMinutes ||
        durationMinutes > maxDurationMinutes) {
      return const AppApiFailure(message: 'errors.matches.invalid_duration');
    }
    if (!proposedUtc.isAfter(nowUtc)) {
      return const AppApiFailure(message: 'errors.matches.date_in_past');
    }
    return null;
  }
}
