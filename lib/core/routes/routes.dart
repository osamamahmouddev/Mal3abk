class AppRoutes {
  const AppRoutes._();

  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String profileSetup = '/profile-setup';
  static const String locationPermission = '/location-permission';
  static const String notificationsPermission = '/notifications-permission';

  static const String main = '/main';
  static const String home = '/home';
  static const String exploreList = '/explore-list';
  static const String exploreMap = '/explore-map';
  static const String filtersAndSort = '/filters-and-sort';
  static const String venueProfile = '/venue-profile';
  static const String pitchAndTime = '/pitch-and-time';
  static const String favorites = '/favorites';

  static const String bookingReview = '/booking-review';
  static const String depositInstructions = '/deposit-instructions';
  static const String uploadProof = '/upload-proof';
  static const String myBookings = '/my-bookings';
  static const String bookingDetails = '/booking-details';
  static const String cancelBooking = '/cancel-booking';

  static const String myTeams = '/my-teams';
  static const String teamProfile = '/team-profile';
  static const String createTeam = '/create-team';
  static const String invitePlayers = '/invite-players';
  static const String joinTeamByCode = '/join-team-by-code';
  static const String manageMembers = '/manage-members';
  static const String rankings = '/rankings';
  static const String tacticalBoard = '/tactical-board';
  static const String leaveTeam = '/leave-team';

  static const String challengeTeam = '/challenge-team';
  static const String challengeDetails = '/challenge-details';
  static const String matchDetails = '/match-details';
  static const String submitResult = '/submit-result';

  static const String myProfile = '/my-profile';
  static const String notifications = '/notifications';
  static const String notificationDetail = '/notification-detail';
  static const String settings = '/settings';
  static const String activeSessions = '/settings/sessions';
  static const String helpAndSupport = '/help-and-support';

  static const String changePhone = '/change-phone';
  static const String verifyOldPhone = '/change-phone/verify-old';
  static const String verifyNewPhone = '/change-phone/verify-new';

  /// Deep link: `https://malabak.app/recover-phone?token=…`.
  static const String recoverPhone = '/recover-phone';
}
