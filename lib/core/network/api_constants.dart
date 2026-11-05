class ApiConstants {
  const ApiConstants._();

  static const String sendOtp = '/api/v1/auth/otp/send';
  static const String verifyOtp = '/api/v1/auth/otp/verify';
  static const String refreshToken = '/api/v1/auth/refresh';
  static const String logout = '/api/v1/auth/logout';
  static const String logoutAll = '/api/v1/auth/logout-all';

  static const String stepUp = '/api/v1/me/step-up';
  static const String startPhoneChange = '/api/v1/me/phone-change/start';
  static const String verifyOldPhone = '/api/v1/me/phone-change/verify-old';
  static const String verifyNewPhone = '/api/v1/me/phone-change/verify-new';
  static const String recoverPhone = '/api/v1/me/phone-change/recover';

  /// Endpoints that never carry an access token and must not trigger a
  /// token refresh when they answer 401.
  static const List<String> anonymousPaths = [
    sendOtp,
    verifyOtp,
    refreshToken,
    logout,
    recoverPhone,
  ];

  /// Profile and onboarding
  static const String myProfile = '/api/v1/me';
  static const String onboardingProfile = '/api/v1/me/onboarding/profile';
  static const String onboardingStatus = '/api/v1/me/onboarding';

  /// Home and Venues
  static const String home = '/api/v1/home';
  static const String exploreVenues = '/api/v1/venues/explore';
  static const String mapVenues = '/api/v1/venues/map';
  static const String areas = '/api/v1/venues/areas';
  static const String venueDetails = '/api/v1/venues/{id}';
  static const String venuePitches = '/api/v1/venues/{id}/pitches';
  static const String venueAvailability = '/api/v1/venues/{id}/availability';
  static const String venuePaymentMethods =
      '/api/v1/venues/{id}/payment-methods';

  /// Bookings
  static const String bookingQuote = '/api/v1/bookings/quote';
  static const String createBooking = '/api/v1/bookings';
  static const String myBookingsList = '/api/v1/me/bookings';
  static const String myBookingDetail = '/api/v1/me/bookings/{id}';
  static const String cancelBooking = '/api/v1/bookings/{id}/cancel';
  static const String cancelPreview = '/api/v1/bookings/{id}/cancel-preview';
  static const String submitProof = '/api/v1/bookings/{id}/proof';
  static const String proofUploadUrl = '/api/v1/bookings/{id}/proof/upload-url';
  static const String submitBookingProof = '/api/v1/bookings/{id}/proof/submit';

  static const String governorates = '/api/v1/reference/governorates';

  static const String myTeams = '/api/v1/me/teams';
  static const String teams = '/api/v1/teams';
  static const String teamProfile = '/api/v1/teams/{id}/profile';
  static const String acceptTeamInvitation = '/api/v1/teams/invitations/accept';
  static const String teamInvitations = '/api/v1/teams/{id}/invitations';
  static const String teamJoinRequests = '/api/v1/teams/{id}/join-requests';
  static const String approveJoinRequest =
      '/api/v1/teams/{id}/join-requests/{requestId}/approve';
  static const String declineJoinRequest =
      '/api/v1/teams/{id}/join-requests/{requestId}/decline';
  static const String leaveTeam = '/api/v1/teams/{id}/leave';
  static const String teamMember = '/api/v1/teams/{id}/members/{playerId}';
  static const String teamSettings = '/api/v1/teams/{id}/settings';
  static const String transferCaptaincy =
      '/api/v1/teams/{id}/transfer-captaincy';
  static const String leaderboard = '/api/v1/teams/leaderboard';
  static const String teamChallenges = '/api/v1/teams/{id}/challenges';

  static const String challenges = '/api/v1/matches/challenges';
  static const String challengeDetails = '/api/v1/matches/challenges/{id}';
  static const String respondToChallenge =
      '/api/v1/matches/challenges/{id}/respond';
  static const String upcomingMatches = '/api/v1/matches/upcoming';
  static const String matchHistory = '/api/v1/matches/history';
  static const String matchDetails = '/api/v1/matches/{id}';
  static const String matchResults = '/api/v1/matches/{id}/results';
  static const String verifyMatchResult = '/api/v1/matches/{id}/results/verify';

  static const String fields = '/fields';
  static const String fieldDetails = '/fields/{id}';
  static const String bookings = '/bookings';
  static const String bookingDetails = '/bookings/{id}';
}
