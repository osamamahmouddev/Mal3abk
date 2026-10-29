import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/cubit/logout_cubit.dart';
import '../../features/auth/presentation/cubit/send_otp_cubit.dart';
import '../../features/auth/presentation/cubit/verify_otp_cubit.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/booking/presentation/screens/booking_details_screen.dart';
import '../../features/booking/presentation/screens/booking_review_screen.dart';
import '../../features/booking/presentation/screens/cancel_booking_screen.dart';
import '../../features/booking/presentation/screens/deposit_instructions_screen.dart';
import '../../features/booking/presentation/screens/my_bookings_screen.dart';
import '../../features/booking/presentation/screens/proof_rejected_screen.dart';
import '../../features/booking/presentation/screens/upload_proof_screen.dart';
import '../../features/explore/presentation/screens/explore_list_screen.dart';
import '../../features/explore/presentation/screens/explore_map_screen.dart';
import '../../features/explore/presentation/screens/favorites_screen.dart';
import '../../features/explore/presentation/screens/filters_and_sort_screen.dart';
import '../../features/explore/presentation/screens/pitch_and_time_screen.dart';
import '../../features/explore/presentation/screens/venue_profile_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/main_shell/presentation/screens/main_shell_screen.dart';
import '../../features/matches/presentation/screens/challenge_details_screen.dart';
import '../../features/matches/presentation/screens/challenge_received_screen.dart';
import '../../features/matches/presentation/screens/challenge_team_screen.dart';
import '../../features/matches/presentation/screens/match_details_screen.dart';
import '../../features/matches/presentation/screens/submit_result_screen.dart';
import '../../features/notifications/presentation/screens/notification_detail_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
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
import '../../features/profile/presentation/screens/my_profile_screen.dart';
import '../../features/settings/presentation/screens/help_and_support_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/splash/presentation/cubit/splash_cubit.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/teams/presentation/screens/captaincy_offer_screen.dart';
import '../../features/teams/presentation/screens/create_team_screen.dart';
import '../../features/teams/presentation/screens/invite_players_screen.dart';
import '../../features/teams/presentation/screens/join_team_by_code_screen.dart';
import '../../features/teams/presentation/screens/leave_team_screen.dart';
import '../../features/teams/presentation/screens/manage_members_screen.dart';
import '../../features/teams/presentation/screens/my_teams_screen.dart';
import '../../features/teams/presentation/screens/rankings_screen.dart';
import '../../features/teams/presentation/screens/team_profile_screen.dart';
import '../di/service_locator.dart';
import 'routes.dart';

class AppRouter {
  const AppRouter._();

  /// A cold start from the recovery link opens only that screen; any other
  /// launch starts at the splash screen.
  static List<Route<dynamic>> onGenerateInitialRoutes(String initialRoute) {
    final path = Uri.parse(initialRoute).path;
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
          builder: (_) => BlocProvider<SplashCubit>(
            create: (_) => sl<SplashCubit>()..checkAuth(),
            child: const SplashScreen(),
          ),
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
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.profileSetup),
          builder: (_) => const ProfileSetupScreen(),
        );

      case AppRoutes.locationPermission:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.locationPermission),
          builder: (_) => const LocationPermissionScreen(),
        );

      case AppRoutes.notificationsPermission:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.notificationsPermission),
          builder: (_) => const NotificationsPermissionScreen(),
        );

      case AppRoutes.main:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.main),
          builder: (_) => const MainShellScreen(),
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.home),
          builder: (_) => const HomeScreen(),
        );

      case AppRoutes.exploreList:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.exploreList),
          builder: (_) => const ExploreListScreen(),
        );

      case AppRoutes.exploreMap:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.exploreMap),
          builder: (_) => const ExploreMapScreen(),
        );

      case AppRoutes.filtersAndSort:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.filtersAndSort),
          builder: (_) => const FiltersAndSortScreen(),
        );

      case AppRoutes.venueProfile:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.venueProfile),
          builder: (_) => const VenueProfileScreen(),
        );

      case AppRoutes.pitchAndTime:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.pitchAndTime),
          builder: (_) => const PitchAndTimeScreen(),
        );

      case AppRoutes.favorites:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.favorites),
          builder: (_) => const FavoritesScreen(),
        );

      case AppRoutes.bookingReview:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.bookingReview),
          builder: (_) => const BookingReviewScreen(),
        );

      case AppRoutes.depositInstructions:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.depositInstructions),
          builder: (_) => const DepositInstructionsScreen(),
        );

      case AppRoutes.uploadProof:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.uploadProof),
          builder: (_) => const UploadProofScreen(),
        );

      case AppRoutes.proofRejected:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.proofRejected),
          builder: (_) => const ProofRejectedScreen(),
        );

      case AppRoutes.myBookings:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.myBookings),
          builder: (_) => const MyBookingsScreen(),
        );

      case AppRoutes.bookingDetails:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.bookingDetails),
          builder: (_) => const BookingDetailsScreen(),
        );

      case AppRoutes.cancelBooking:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.cancelBooking),
          builder: (_) => const CancelBookingScreen(),
        );

      case AppRoutes.myTeams:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.myTeams),
          builder: (_) => const MyTeamsScreen(),
        );

      case AppRoutes.teamProfile:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.teamProfile),
          builder: (_) => const TeamProfileScreen(),
        );

      case AppRoutes.createTeam:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.createTeam),
          builder: (_) => const CreateTeamScreen(),
        );

      case AppRoutes.invitePlayers:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.invitePlayers),
          builder: (_) => const InvitePlayersScreen(),
        );

      case AppRoutes.joinTeamByCode:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.joinTeamByCode),
          builder: (_) => const JoinTeamByCodeScreen(),
        );

      case AppRoutes.manageMembers:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.manageMembers),
          builder: (_) => const ManageMembersScreen(),
        );

      case AppRoutes.rankings:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.rankings),
          builder: (_) => const RankingsScreen(),
        );

      case AppRoutes.captaincyOffer:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.captaincyOffer),
          builder: (_) => const CaptaincyOfferScreen(),
        );

      case AppRoutes.leaveTeam:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.leaveTeam),
          builder: (_) => const LeaveTeamScreen(),
        );

      case AppRoutes.challengeTeam:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.challengeTeam),
          builder: (_) => const ChallengeTeamScreen(),
        );

      case AppRoutes.challengeReceived:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.challengeReceived),
          builder: (_) => const ChallengeReceivedScreen(),
        );

      case AppRoutes.challengeDetails:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.challengeDetails),
          builder: (_) => const ChallengeDetailsScreen(),
        );

      case AppRoutes.matchDetails:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.matchDetails),
          builder: (_) => const MatchDetailsScreen(),
        );

      case AppRoutes.submitResult:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.submitResult),
          builder: (_) => const SubmitResultScreen(),
        );

      case AppRoutes.myProfile:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.myProfile),
          builder: (_) => const MyProfileScreen(),
        );

      case AppRoutes.notifications:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.notifications),
          builder: (_) => const NotificationsScreen(),
        );

      case AppRoutes.notificationDetail:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.notificationDetail),
          builder: (_) => const NotificationDetailScreen(),
        );

      case AppRoutes.settings:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.settings),
          builder: (_) => BlocProvider<LogoutCubit>(
            create: (_) => sl<LogoutCubit>(),
            child: const SettingsScreen(),
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
        builder: (_) => Scaffold(
          body: Center(
            child: Text(message),
          ),
        ),
      );
}
