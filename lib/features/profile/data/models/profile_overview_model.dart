import 'my_profile_model.dart';

/// The profile tab: the player's own profile plus counts gathered from other
/// endpoints; a count is null when it couldn't be loaded.
class ProfileOverviewModel {
  const ProfileOverviewModel({
    required this.profile,
    this.avatarUrl,
    this.matchesPlayed,
    this.teamsCount,
    this.bookingsCount,
    this.teamNames = const [],
  });

  final MyProfileModel profile;

  /// Absolute URL, ready to load.
  final String? avatarUrl;
  final int? matchesPlayed;
  final int? teamsCount;
  final int? bookingsCount;
  final List<String> teamNames;
}
