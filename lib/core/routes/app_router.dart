import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/cubit/logout_cubit.dart';
import '../../features/auth/presentation/cubit/send_otp_cubit.dart';
import '../../features/auth/presentation/cubit/verify_otp_cubit.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/booking/data/models/create_booking_response_model.dart';
import '../../features/booking/presentation/cubit/my_bookings_cubit.dart';
import '../../features/booking/presentation/screens/booking_details_screen.dart';
import '../../features/booking/presentation/screens/booking_review_screen.dart';
import '../../features/booking/presentation/screens/cancel_booking_screen.dart';
import '../../features/booking/presentation/screens/deposit_instructions_screen.dart';
import '../../features/booking/presentation/screens/my_bookings_screen.dart';
import '../../features/booking/presentation/screens/upload_proof_screen.dart';
import '../../features/explore/presentation/cubit/explore_list_cubit.dart';
import '../../features/explore/presentation/cubit/pitch_booking_cubit.dart';
import '../../features/explore/presentation/cubit/venue_profile_cubit.dart';
import '../../features/explore/presentation/screens/explore_list_screen.dart';
import '../../features/explore/presentation/screens/explore_map_screen.dart';
import '../../features/explore/presentation/screens/favorites_screen.dart';
import '../../features/explore/presentation/screens/filters_and_sort_screen.dart';
import '../../features/explore/presentation/screens/photo_gallery_screen.dart';
import '../../features/explore/presentation/screens/pitch_and_time_screen.dart';
import '../../features/explore/presentation/screens/venue_profile_screen.dart';
import '../../features/home/presentation/cubit/home_feed_cubit.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/main_shell/presentation/screens/main_shell_screen.dart';
import '../../features/explore/data/models/explore_filter_model.dart';
import '../../features/explore/presentation/cubit/explore_map_cubit.dart';
import '../../features/explore/presentation/cubit/favorite_toggle_cubit.dart';
import '../../features/reference/presentation/cubit/filter_options_cubit.dart';
import '../../features/explore/presentation/cubit/favorites_cubit.dart';
import '../../features/home/presentation/cubit/home_team_activity_cubit.dart';
import '../../features/home/presentation/cubit/recently_viewed_cubit.dart';
import '../../features/booking/presentation/cubit/booking_details_cubit.dart';
import '../../features/booking/presentation/cubit/cancel_booking_cubit.dart';
import '../../features/booking/presentation/cubit/deposit_methods_cubit.dart';
import '../../features/booking/presentation/cubit/pay_commission_cubit.dart';
import '../../features/booking/presentation/cubit/my_bookings_tab.dart';
import '../../features/booking/presentation/cubit/proof_upload_cubit.dart';
import '../../features/matches/data/models/match_details_model.dart';
import '../../features/onboarding/presentation/cubit/avatar_cubit.dart';
import '../../features/onboarding/presentation/cubit/onboarding_consent_cubit.dart';
import '../../features/profile/data/models/my_profile_model.dart';
import '../../features/notifications/data/models/notification_model.dart';
import '../../features/settings/presentation/cubit/account_action_cubit.dart';
import '../../features/settings/presentation/cubit/biometric_lock_cubit.dart';
import '../../features/settings/presentation/cubit/consents_cubit.dart';
import '../../features/settings/presentation/cubit/notification_preferences_cubit.dart';
import '../../features/settings/presentation/cubit/sessions_cubit.dart';
import '../../features/settings/presentation/screens/active_sessions_screen.dart';
import '../../features/notifications/presentation/cubit/notifications_cubit.dart';
import '../../features/notifications/presentation/cubit/unread_notifications_cubit.dart';
import '../../features/matches/presentation/cubit/challenge_details_cubit.dart';
import '../../features/matches/presentation/cubit/challenge_response_cubit.dart';
import '../../features/matches/presentation/cubit/match_details_cubit.dart';
import '../../features/matches/presentation/cubit/match_result_cubit.dart';
import '../../features/matches/presentation/cubit/send_challenge_cubit.dart';
import '../../features/matches/presentation/screens/challenge_details_screen.dart';
import '../../features/matches/presentation/screens/challenge_team_screen.dart';
import '../../features/matches/presentation/screens/match_details_screen.dart';
import '../../features/matches/presentation/screens/submit_result_screen.dart';
import '../../features/notifications/presentation/screens/notification_detail_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/onboarding/presentation/cubit/profile_setup_cubit.dart';
import '../../features/onboarding/presentation/screens/location_permission_screen.dart';
import '../../features/onboarding/presentation/screens/notifications_permission_screen.dart';
import '../../features/onboarding/presentation/screens/profile_setup_screen.dart';
import '../../features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/phone_change/presentation/cubit/recover_phone_cubit.dart';
import '../../features/phone_change/presentation/cubit/start_phone_change_cubit.dart';
import '../../features/phone_change/presentation/cubit/verify_new_phone_cubit.dart';
import '../../features/phone_change/presentation/cubit/verify_old_phone_cubit.dart';
import '../../features/phone_change/presentation/screens/change_phone_screen.dart';
import '../../features/phone_change/presentation/screens/recover_phone_screen.dart';
import '../../features/phone_change/presentation/screens/verify_new_phone_screen.dart';
import '../../features/phone_change/presentation/screens/verify_old_phone_screen.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/profile/presentation/screens/my_profile_screen.dart';
import '../../features/settings/presentation/screens/help_and_support_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/splash/presentation/cubit/splash_cubit.dart';
import '../../features/splash/presentation/screens/force_update_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/reference/presentation/cubit/governorates_cubit.dart';
import '../../features/teams/data/models/team_profile_model.dart';
import '../../features/teams/presentation/cubit/create_team_cubit.dart';
import '../../features/teams/presentation/cubit/discover_teams_cubit.dart';
import '../../features/teams/presentation/cubit/join_team_cubit.dart';
import '../../features/teams/presentation/cubit/team_invite_preview_cubit.dart';
import '../../features/teams/presentation/cubit/leaderboard_cubit.dart';
import '../../features/teams/presentation/cubit/my_teams_cubit.dart';
import '../../features/teams/presentation/cubit/tactical_board_cubit.dart';
import '../../features/teams/presentation/cubit/team_action_cubit.dart';
import '../../features/teams/presentation/cubit/team_dashboard_cubit.dart';
import '../../features/teams/presentation/cubit/team_invite_cubit.dart';
import '../../features/teams/presentation/screens/tactical_board_screen.dart';
import '../../features/teams/presentation/screens/create_team_screen.dart';
import '../../features/teams/presentation/screens/invite_players_screen.dart';
import '../../features/teams/presentation/screens/join_team_by_code_screen.dart';
import '../../features/teams/presentation/screens/leave_team_screen.dart';
import '../../features/teams/presentation/screens/manage_members_screen.dart';
import '../../features/teams/presentation/screens/my_teams_screen.dart';
import '../../features/teams/presentation/screens/rankings_screen.dart';
import '../../features/teams/presentation/screens/team_profile_screen.dart';
import '../config/env_config.dart';
import '../di/service_locator.dart';
import 'app_navigator.dart';
import 'invite_link_observer.dart';
import 'routes.dart';

class AppRouter {
  const AppRouter._();

  /// A cold start from the recovery link opens only that screen; any other
  /// launch starts at the splash screen. A team invite link waits there for
  /// sign-in and opens the join screen once the shell is shown.
  static List<Route<dynamic>> onGenerateInitialRoutes(String initialRoute) {
    final invite = InviteLinkObserver.targetFor(
      initialRoute,
      webHosts: sl.isRegistered<EnvConfig>()
          ? {Uri.parse(sl<EnvConfig>().baseUrl).host}
          : const {},
    );
    if (invite != null) AppNavigator.openDeepLink(invite);
    final path = Uri.tryParse(initialRoute)?.path ?? '';
    final name = path == AppRoutes.recoverPhone
        ? initialRoute
        : AppRoutes.splash;
    return [onGenerateRoute(RouteSettings(name: name))];
  }

  static Route onGenerateRoute(RouteSettings settings) {
    // Deep links arrive as a path with a query string, e.g.
    // `/recover-phone?token=…`; match on the path only.
    final uri = Uri.parse(settings.name ?? '');
    switch (uri.path) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.splash),
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<SplashCubit>(
                create: (_) => sl<SplashCubit>()..checkAuth(),
              ),
              BlocProvider<LogoutCubit>(create: (_) => sl<LogoutCubit>()),
            ],
            child: const SplashScreen(),
          ),
        );

      case AppRoutes.forceUpdate:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.forceUpdate),
          builder: (_) => const ForceUpdateScreen(),
        );

      case AppRoutes.welcome:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.welcome),
          builder: (_) => const WelcomeScreen(),
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.login),
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<SendOtpCubit>(create: (_) => sl<SendOtpCubit>()),
              BlocProvider<VerifyOtpCubit>(create: (_) => sl<VerifyOtpCubit>()),
            ],
            child: const LoginScreen(),
          ),
        );

      case AppRoutes.profileSetup:
        final arguments = settings.arguments;
        if (arguments != null && arguments is! MyProfileModel) {
          return _errorRoute('Invalid profile');
        }
        final profile = arguments as MyProfileModel?;
        return MaterialPageRoute<MyProfileModel>(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<ProfileSetupCubit>(
                create: (_) => sl<ProfileSetupCubit>(),
              ),
              BlocProvider<AvatarCubit>(
                create: (_) => sl<AvatarCubit>()..seed(profile?.avatarUrl),
              ),
              BlocProvider<GovernoratesCubit>(
                create: (_) => sl<GovernoratesCubit>()..load(),
              ),
            ],
            child: ProfileSetupScreen(profile: profile),
          ),
        );

      case AppRoutes.locationPermission:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<OnboardingConsentCubit>(
            create: (_) => sl<OnboardingConsentCubit>(),
            child: const LocationPermissionScreen(),
          ),
        );

      case AppRoutes.notificationsPermission:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<OnboardingConsentCubit>(
            create: (_) => sl<OnboardingConsentCubit>(),
            child: const NotificationsPermissionScreen(),
          ),
        );

      case AppRoutes.main:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.main),
          builder: (_) => const MainShellScreen(),
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.home),
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<HomeFeedCubit>(
                create: (_) => sl<HomeFeedCubit>()..fetchFeed(),
              ),
              BlocProvider<GovernoratesCubit>(
                create: (_) => sl<GovernoratesCubit>()..load(),
              ),
              BlocProvider<HomeTeamActivityCubit>(
                create: (_) => sl<HomeTeamActivityCubit>()..load(),
              ),
              BlocProvider<UnreadNotificationsCubit>(
                create: (_) => sl<UnreadNotificationsCubit>()..refresh(),
              ),
              BlocProvider<MyBookingsCubit>(
                create: (_) =>
                    sl<MyBookingsCubit>()..load(MyBookingsTab.upcoming),
              ),
              BlocProvider<RecentlyViewedCubit>(
                create: (_) => sl<RecentlyViewedCubit>()..load(),
              ),
            ],
            child: const HomeScreen(),
          ),
        );

      case AppRoutes.exploreList:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.exploreList),
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<ExploreListCubit>(
                create: (_) => sl<ExploreListCubit>()..start(),
              ),
              BlocProvider<FavoriteToggleCubit>(
                create: (_) => sl<FavoriteToggleCubit>(),
              ),
            ],
            child: const ExploreListScreen(),
          ),
        );

      case AppRoutes.exploreMap:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<ExploreMapCubit>(
            create: (_) => sl<ExploreMapCubit>()..start(),
            child: const ExploreMapScreen(),
          ),
        );

      case AppRoutes.filtersAndSort:
        final args = settings.arguments;
        final (initial, hasLocation) = args is (ExploreFilterModel, bool)
            ? args
            : (const ExploreFilterModel(), false);
        return MaterialPageRoute<ExploreFilterModel>(
          settings: settings,
          fullscreenDialog: true,
          builder: (_) => BlocProvider<FilterOptionsCubit>(
            create: (_) => sl<FilterOptionsCubit>()..load(),
            child: FiltersAndSortScreen(
              initial: initial,
              hasLocation: hasLocation,
            ),
          ),
        );

      case AppRoutes.venueProfile:
        final venueId = settings.arguments;
        if (venueId is! String) return _errorRoute('Missing venue id');
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<VenueProfileCubit>(
                create: (_) => sl<VenueProfileCubit>()..loadVenue(venueId),
              ),
              BlocProvider<FavoriteToggleCubit>(
                create: (_) => sl<FavoriteToggleCubit>(),
              ),
            ],
            child: VenueProfileScreen(venueId: venueId),
          ),
        );

      case AppRoutes.photoGallery:
        final args = settings.arguments;
        if (args is! PhotoGalleryArgs || args.photos.isEmpty) {
          return _errorRoute('Missing photos');
        }
        return PageRouteBuilder<int>(
          settings: settings,
          opaque: false,
          pageBuilder: (_, _, _) => PhotoGalleryScreen(args: args),
          transitionsBuilder: (_, animation, _, child) =>
              FadeTransition(opacity: animation, child: child),
        );

      case AppRoutes.pitchAndTime:
        final args = settings.arguments;
        if (args is! PitchAndTimeArgs) return _errorRoute('Missing venue');
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<PitchBookingCubit>(
            create: (_) =>
                sl<PitchBookingCubit>()
                  ..loadAvailability(args.venueId, pitchIndex: args.pitchIndex),
            child: PitchAndTimeScreen(args: args),
          ),
        );

      case AppRoutes.favorites:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.favorites),
          builder: (_) => BlocProvider<FavoritesCubit>(
            create: (_) => sl<FavoritesCubit>()..load(),
            child: const FavoritesScreen(),
          ),
        );

      case AppRoutes.bookingReview:
        final cubit = settings.arguments;
        if (cubit is! PitchBookingCubit) return _errorRoute('Missing booking');
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BookingReviewScreen(cubit: cubit),
        );

      case AppRoutes.depositInstructions:
        final booking = settings.arguments;
        if (booking is! CreateBookingResponseModel) {
          return _errorRoute('Missing booking');
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<DepositMethodsCubit>(
                create: (_) =>
                    sl<DepositMethodsCubit>()..load(booking.bookingId),
              ),
              BlocProvider<PayCommissionCubit>(
                create: (_) => sl<PayCommissionCubit>(),
              ),
            ],
            child: DepositInstructionsScreen(booking: booking),
          ),
        );

      case AppRoutes.uploadProof:
        final bookingId = settings.arguments;
        if (bookingId is! String) return _errorRoute('Missing booking id');
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<BookingDetailsCubit>(
                create: (_) => sl<BookingDetailsCubit>()..load(bookingId),
              ),
              BlocProvider<ProofUploadCubit>(
                create: (_) => sl<ProofUploadCubit>(),
              ),
            ],
            child: UploadProofScreen(bookingId: bookingId),
          ),
        );

      case AppRoutes.myBookings:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.myBookings),
          builder: (_) => BlocProvider<MyBookingsCubit>(
            create: (_) => sl<MyBookingsCubit>()..load(MyBookingsTab.upcoming),
            child: const MyBookingsScreen(),
          ),
        );

      case AppRoutes.bookingDetails:
        final bookingId = settings.arguments;
        if (bookingId is! String) return _errorRoute('Missing booking id');
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<BookingDetailsCubit>(
            create: (_) => sl<BookingDetailsCubit>()..load(bookingId),
            child: BookingDetailsScreen(bookingId: bookingId),
          ),
        );

      case AppRoutes.cancelBooking:
        final bookingId = settings.arguments;
        if (bookingId is! String) return _errorRoute('Missing booking id');
        return MaterialPageRoute<bool>(
          settings: settings,
          builder: (_) => BlocProvider<CancelBookingCubit>(
            create: (_) => sl<CancelBookingCubit>()..loadPreview(bookingId),
            child: CancelBookingScreen(bookingId: bookingId),
          ),
        );

      case AppRoutes.myTeams:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.myTeams),
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<MyTeamsCubit>(
                create: (_) => sl<MyTeamsCubit>()..load(),
              ),
              BlocProvider<DiscoverTeamsCubit>(
                create: (_) => sl<DiscoverTeamsCubit>()..load(),
              ),
            ],
            child: const MyTeamsScreen(),
          ),
        );

      case AppRoutes.teamProfile:
        final teamId = settings.arguments;
        if (teamId is! String) return _errorRoute('Missing team id');
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<TeamDashboardCubit>(
                create: (_) => sl<TeamDashboardCubit>()..load(teamId),
              ),
              BlocProvider<TeamActionCubit>(
                create: (_) => sl<TeamActionCubit>(),
              ),
            ],
            child: TeamProfileScreen(teamId: teamId),
          ),
        );

      case AppRoutes.createTeam:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.createTeam),
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<CreateTeamCubit>(
                create: (_) => sl<CreateTeamCubit>(),
              ),
              BlocProvider<GovernoratesCubit>(
                create: (_) => sl<GovernoratesCubit>()..load(),
              ),
            ],
            child: const CreateTeamScreen(),
          ),
        );

      case AppRoutes.invitePlayers:
        final teamId = settings.arguments;
        if (teamId is! String) return _errorRoute('Missing team id');
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<TeamInviteCubit>(
            create: (_) => sl<TeamInviteCubit>()..load(teamId),
            child: InvitePlayersScreen(teamId: teamId),
          ),
        );

      case AppRoutes.joinTeamByCode:
        final code = settings.arguments;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<JoinTeamCubit>(create: (_) => sl<JoinTeamCubit>()),
              BlocProvider<TeamInvitePreviewCubit>(
                create: (_) => sl<TeamInvitePreviewCubit>(),
              ),
            ],
            child: JoinTeamByCodeScreen(
              initialCode: code is String ? code : null,
            ),
          ),
        );

      case AppRoutes.manageMembers:
        final teamId = settings.arguments;
        if (teamId is! String) return _errorRoute('Missing team id');
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<TeamDashboardCubit>(
                create: (_) => sl<TeamDashboardCubit>()..load(teamId),
              ),
              BlocProvider<TeamActionCubit>(
                create: (_) => sl<TeamActionCubit>(),
              ),
            ],
            child: ManageMembersScreen(teamId: teamId),
          ),
        );

      case AppRoutes.rankings:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.rankings),
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<LeaderboardCubit>(
                create: (_) => sl<LeaderboardCubit>()..load(),
              ),
              BlocProvider<GovernoratesCubit>(
                create: (_) => sl<GovernoratesCubit>()..load(),
              ),
            ],
            child: const RankingsScreen(),
          ),
        );

      case AppRoutes.leaveTeam:
        final profile = settings.arguments;
        if (profile is! TeamProfileModel) return _errorRoute('Missing team');
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<TeamActionCubit>(
            create: (_) => sl<TeamActionCubit>(),
            child: LeaveTeamScreen(profile: profile),
          ),
        );

      case AppRoutes.tacticalBoard:
        final profile = settings.arguments;
        if (profile is! TeamProfileModel) return _errorRoute('Missing team');
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<TacticalBoardCubit>(
            create: (_) => sl<TacticalBoardCubit>()
              ..load(profile.id, [for (final m in profile.roster) m.playerId]),
            child: TacticalBoardScreen(profile: profile),
          ),
        );

      case AppRoutes.challengeTeam:
        final opponent = settings.arguments;
        if (opponent is! TeamProfileModel) return _errorRoute('Missing team');
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<MyTeamsCubit>(
                create: (_) => sl<MyTeamsCubit>()..load(),
              ),
              BlocProvider<SendChallengeCubit>(
                create: (_) => sl<SendChallengeCubit>(),
              ),
            ],
            child: ChallengeTeamScreen(opponent: opponent),
          ),
        );

      case AppRoutes.challengeDetails:
        final challengeId = settings.arguments;
        if (challengeId is! String) return _errorRoute('Missing challenge id');
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<ChallengeDetailsCubit>(
                create: (_) => sl<ChallengeDetailsCubit>()..load(challengeId),
              ),
              BlocProvider<ChallengeResponseCubit>(
                create: (_) => sl<ChallengeResponseCubit>(),
              ),
            ],
            child: ChallengeDetailsScreen(challengeId: challengeId),
          ),
        );

      case AppRoutes.matchDetails:
        final matchId = settings.arguments;
        if (matchId is! String) return _errorRoute('Missing match id');
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<MatchDetailsCubit>(
                create: (_) => sl<MatchDetailsCubit>()..load(matchId),
              ),
              BlocProvider<MatchResultCubit>(
                create: (_) => sl<MatchResultCubit>(),
              ),
            ],
            child: MatchDetailsScreen(matchId: matchId),
          ),
        );

      case AppRoutes.submitResult:
        final details = settings.arguments;
        if (details is! MatchDetailsModel || details.myTeam == null) {
          return _errorRoute('Missing match');
        }
        return MaterialPageRoute<bool>(
          settings: settings,
          builder: (_) => BlocProvider<MatchResultCubit>(
            create: (_) => sl<MatchResultCubit>(),
            child: SubmitResultScreen(details: details),
          ),
        );

      case AppRoutes.myProfile:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.myProfile),
          builder: (_) => BlocProvider<ProfileCubit>(
            create: (_) => sl<ProfileCubit>()..fetchProfile(),
            child: const MyProfileScreen(),
          ),
        );

      case AppRoutes.notifications:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<NotificationsCubit>(
            create: (_) => sl<NotificationsCubit>()..load(),
            child: const NotificationsScreen(),
          ),
        );

      case AppRoutes.notificationDetail:
        final notification = settings.arguments;
        if (notification is! NotificationModel) {
          return _errorRoute('Missing notification');
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => NotificationDetailScreen(notification: notification),
        );

      case AppRoutes.settings:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.settings),
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<LogoutCubit>(create: (_) => sl<LogoutCubit>()),
              BlocProvider<NotificationPreferencesCubit>(
                create: (_) => sl<NotificationPreferencesCubit>()..load(),
              ),
              BlocProvider<ConsentsCubit>(
                create: (_) => sl<ConsentsCubit>()..load(),
              ),
              BlocProvider<AccountActionCubit>(
                create: (_) => sl<AccountActionCubit>(),
              ),
              BlocProvider<BiometricLockCubit>(
                create: (_) => sl<BiometricLockCubit>()..load(),
              ),
            ],
            child: const SettingsScreen(),
          ),
        );

      case AppRoutes.activeSessions:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<SessionsCubit>(
            create: (_) => sl<SessionsCubit>()..load(),
            child: const ActiveSessionsScreen(),
          ),
        );

      case AppRoutes.helpAndSupport:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.helpAndSupport),
          builder: (_) => const HelpAndSupportScreen(),
        );

      case AppRoutes.changePhone:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.changePhone),
          builder: (_) => BlocProvider<StartPhoneChangeCubit>(
            create: (_) => sl<StartPhoneChangeCubit>(),
            child: const ChangePhoneScreen(),
          ),
        );

      case AppRoutes.verifyOldPhone:
        final requestId = settings.arguments;
        if (requestId is! String || requestId.isEmpty) {
          return _errorRoute('Missing phone change request id');
        }
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.verifyOldPhone),
          builder: (_) => BlocProvider<VerifyOldPhoneCubit>(
            create: (_) => sl<VerifyOldPhoneCubit>(),
            child: VerifyOldPhoneScreen(requestId: requestId),
          ),
        );

      case AppRoutes.verifyNewPhone:
        final requestId = settings.arguments;
        if (requestId is! String || requestId.isEmpty) {
          return _errorRoute('Missing phone change request id');
        }
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.verifyNewPhone),
          builder: (_) => BlocProvider<VerifyNewPhoneCubit>(
            create: (_) => sl<VerifyNewPhoneCubit>(),
            child: VerifyNewPhoneScreen(requestId: requestId),
          ),
        );

      case AppRoutes.recoverPhone:
        // The token comes from the deep link query or, when pushed in-app,
        // from the arguments. A missing token shows the invalid-link state.
        final arguments = settings.arguments;
        final recoveryToken = arguments is String
            ? arguments
            : uri.queryParameters['token'] ?? '';
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.recoverPhone),
          builder: (_) => BlocProvider<RecoverPhoneCubit>(
            create: (_) => sl<RecoverPhoneCubit>(),
            child: RecoverPhoneScreen(recoveryToken: recoveryToken),
          ),
        );

      default:
        return _errorRoute('Unknown route: ${uri.path}');
    }
  }

  static Route _errorRoute(String message) => MaterialPageRoute(
    builder: (_) => Scaffold(body: Center(child: Text(message))),
  );
}
