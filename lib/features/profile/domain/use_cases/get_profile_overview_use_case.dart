import '../../../../core/network/api_result.dart';
import '../../../../core/utils/media_url.dart';
import '../../../booking/domain/repos/booking_repo.dart';
import '../../../teams/domain/repos/teams_repo.dart';
import '../../data/models/profile_overview_model.dart';
import '../repos/profile_repo.dart';

/// Loads the profile, then its stats, teams and booking count in parallel.
/// Only the profile itself is required.
class GetProfileOverviewUseCase {
  GetProfileOverviewUseCase({
    required this.profileRepo,
    required this.teamsRepo,
    required this.bookingRepo,
    required this.mediaBaseUrl,
  });

  final ProfileRepo profileRepo;
  final TeamsRepo teamsRepo;
  final BookingRepo bookingRepo;
  final String mediaBaseUrl;

  Future<ApiResult<ProfileOverviewModel>> call() async {
    final profileResult = await profileRepo.getMyProfile();
    return profileResult.when(
      success: (profile) async {
        final (publicProfile, teams, bookings) = await (
          profileRepo.getPlayerProfile(profile.userId),
          teamsRepo.getMyTeams(),
          bookingRepo.getMyBookings(page: 1, pageSize: 1),
        ).wait;
        final stats = publicProfile.maybeWhen(
          success: (p) => p.stats,
          orElse: () => null,
        );
        final teamNames = teams.maybeWhen(
          success: (list) => [for (final t in list) t.name],
          orElse: () => null,
        );
        return ApiResult.success(
          ProfileOverviewModel(
            profile: profile,
            avatarUrl: MediaUrl.resolve(
              profile.avatarUrl,
              baseUrl: mediaBaseUrl,
            ),
            matchesPlayed: stats?.matchesPlayed,
            teamsCount: teamNames?.length ?? stats?.teamsCount,
            bookingsCount: bookings.maybeWhen(
              success: (page) => page.totalCount,
              orElse: () => null,
            ),
            teamNames: teamNames ?? const [],
          ),
        );
      },
      failure: (failure) async => ApiResult.failure(failure),
    );
  }
}
