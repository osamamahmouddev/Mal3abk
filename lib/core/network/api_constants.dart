class ApiConstants {
  const ApiConstants._();

  static const String sendOtp = '/api/v1/auth/otp/send';
  static const String verifyOtp = '/api/v1/auth/otp/verify';
  static const String firebaseAuth = '/api/v1/auth/firebase';
  static const String refreshToken = '/api/v1/auth/refresh';
  static const String logout = '/api/v1/auth/logout';
  static const String logoutAll = '/api/v1/auth/logout-all';

  /// Venue owner/staff accounts (email + password)
  static const String ownerLogin = '/api/v1/auth/login';
  static const String registerVenueOwner = '/api/v1/auth/register/venue-owner';
  static const String resendVerificationEmail = '/api/v1/auth/email/resend';
  static const String forgotPassword = '/api/v1/auth/password/forgot';

  static const String stepUp = '/api/v1/auth/step-up';
  static const String stepUpOtp = '/api/v1/auth/step-up/otp';
  static const String startPhoneChange = '/api/v1/me/phone-change/start';
  static const String verifyOldPhone = '/api/v1/me/phone-change/verify-old';
  static const String verifyNewPhone = '/api/v1/me/phone-change/verify-new';
  static const String recoverPhone = '/api/v1/me/phone-change/recover';

  /// Endpoints that never carry an access token and must not trigger a
  /// token refresh when they answer 401.
  static const List<String> anonymousPaths = [
    sendOtp,
    verifyOtp,
    firebaseAuth,
    refreshToken,
    logout,
    recoverPhone,
    ownerLogin,
    registerVenueOwner,
    resendVerificationEmail,
    forgotPassword,
  ];

  /// Venue dashboard (owners and staff)
  static const String myPermissions = '/api/v1/me/permissions';
  static const String managedVenues = '/api/v1/venue-manager/venues';
  static const String managedVenue = '/api/v1/venue-manager/venues/{venueId}';
  static const String venueDashboard =
      '/api/v1/venue-manager/venues/{venueId}/dashboard';
  static const String venueApproval =
      '/api/v1/venue-manager/venues/{venueId}/approval';
  static const String venueApprovalSubmit =
      '/api/v1/venue-manager/venues/{venueId}/approval/submit';
  static const String venueBookings =
      '/api/v1/venue-manager/venues/{venueId}/bookings';
  static const String venueBooking =
      '/api/v1/venue-manager/venues/{venueId}/bookings/{bookingId}';
  static const String venueBookingConfirmDeposit =
      '/api/v1/venue-manager/venues/{venueId}/bookings/{bookingId}/confirm-deposit';
  static const String venueBookingCancel =
      '/api/v1/venue-manager/venues/{venueId}/bookings/{bookingId}/cancel';
  static const String venueBookingNoShow =
      '/api/v1/venue-manager/venues/{venueId}/bookings/{bookingId}/no-show';
  static const String venueManualBooking =
      '/api/v1/venue-manager/venues/{venueId}/bookings/manual';
  static const String venueCalendar =
      '/api/v1/venue-manager/venues/{venueId}/calendar';
  static const String venueSchedules =
      '/api/v1/venue-manager/venues/{venueId}/schedules';
  static const String venueBlockedSlots =
      '/api/v1/venue-manager/venues/{venueId}/blocked-slots';
  static const String venueBlockedSlot =
      '/api/v1/venue-manager/venues/{venueId}/blocked-slots/{slotId}';
  static const String venueManualBookingBulk =
      '/api/v1/venue-manager/venues/{venueId}/bookings/manual/bulk';
  static const String venueManualBookingBulkRelease =
      '/api/v1/venue-manager/venues/{venueId}/bookings/manual/bulk-release';
  static const String venuePricePreview =
      '/api/v1/venue-manager/venues/{venueId}/price-rules/preview';
  static const String venueCustomers =
      '/api/v1/venue-manager/venues/{venueId}/customers';
  static const String managedVenuePitches =
      '/api/v1/venue-manager/venues/{venueId}/pitches';
  static const String managedPitch = '/api/v1/venue-manager/pitches/{pitchId}';
  static const String venueGallery =
      '/api/v1/venue-manager/venues/{venueId}/gallery';
  static const String venueGalleryItem =
      '/api/v1/venue-manager/venues/{venueId}/gallery/{mediaId}';
  static const String pitchGallery =
      '/api/v1/venue-manager/venues/{venueId}/pitches/{pitchId}/gallery';
  static const String pitchGalleryItem =
      '/api/v1/venue-manager/venues/{venueId}/pitches/{pitchId}/gallery/{mediaId}';

  /// Profile and onboarding
  static const String myProfile = '/api/v1/me';
  static const String onboardingProfile = '/api/v1/me/onboarding/profile';
  static const String myAvatar = '/api/v1/me/avatar';
  static const String playerProfile = '/api/v1/players/{userId}';
  static const String mediaUploads = '/api/v1/media/uploads';
  static const String onboardingStatus = '/api/v1/me/onboarding';

  /// Home and Venues
  static const String home = '/api/v1/home';
  static const String exploreVenues = '/api/v1/venues/explore';
  static const String mapVenues = '/api/v1/venues/map';
  static const String areas = '/api/v1/venues/areas';
  static const String venueDetails = '/api/v1/venues/{id}';
  static const String venuePitches = '/api/v1/venues/{id}/pitches';
  static const String venueAvailability = '/api/v1/venues/{id}/availability';

  /// Bookings
  static const String bookingQuote = '/api/v1/bookings/quote';
  static const String createBooking = '/api/v1/bookings';
  static const String myBookingsList = '/api/v1/me/bookings';
  static const String myBookingDetail = '/api/v1/me/bookings/{id}';
  static const String cancelBooking = '/api/v1/bookings/{id}/cancel';
  static const String cancelPreview = '/api/v1/bookings/{id}/cancel/preview';
  static const String bookingPaymentMethods =
      '/api/v1/bookings/{id}/payment-methods';
  static const String payBookingCommission =
      '/api/v1/bookings/{id}/pay-commission';
  static const String idempotencyKeyHeader = 'Idempotency-Key';
  static const String proofUploadUrl = '/api/v1/bookings/{id}/proof/upload-url';
  static const String submitBookingProof = '/api/v1/bookings/{id}/proof/submit';

  static const String pitchTypes = '/api/v1/reference/pitch-types';
  static const String surfaces = '/api/v1/reference/surfaces';
  static const String facilities = '/api/v1/reference/facilities';
  static const String governorates = '/api/v1/reference/governorates';

  static const String myTeams = '/api/v1/me/teams';
  static const String teams = '/api/v1/teams';
  static const String teamDetail = '/api/v1/teams/{id}';
  static const String teamProfile = '/api/v1/teams/{id}/profile';
  static const String acceptTeamInvitation = '/api/v1/teams/invitations/accept';
  static const String teamInvitationPreview =
      '/api/v1/teams/invitations/{code}';
  static const String teamInvitations = '/api/v1/teams/{id}/invitations';
  static const String teamJoinRequests = '/api/v1/teams/{id}/join-requests';
  static const String approveJoinRequest =
      '/api/v1/teams/{id}/join-requests/{requestId}/approve';
  static const String declineJoinRequest =
      '/api/v1/teams/{id}/join-requests/{requestId}/decline';
  static const String leaveTeam = '/api/v1/teams/{id}/leave';
  static const String teamMember = '/api/v1/teams/{id}/members/{playerId}';
  static const String teamSettings = '/api/v1/teams/{id}/settings';
  static const String teamMemberRole =
      '/api/v1/teams/{id}/members/{playerId}/role';
  static const String transferCaptaincy =
      '/api/v1/teams/{id}/transfer-captaincy';
  static const String leaderboard = '/api/v1/teams/leaderboard';
  static const String teamChallenges = '/api/v1/teams/{id}/challenges';

  static const String me = '/api/v1/me';
  static const String favorites = '/api/v1/me/favorites';
  static const String favorite = '/api/v1/me/favorites/{venueId}';
  static const String recentlyViewed = '/api/v1/me/recently-viewed';
  static const String recentlyViewedVenue =
      '/api/v1/me/recently-viewed/{venueId}';
  static const String sessions = '/api/v1/me/sessions';
  static const String session = '/api/v1/me/sessions/{id}';
  static const String revokeOtherSessions = '/api/v1/me/sessions/revoke-others';
  static const String consents = '/api/v1/me/consents';
  static const String language = '/api/v1/me/language';
  static const String dataExport = '/api/v1/me/data-export';
  static const String stepUpTokenHeader = 'X-Step-Up-Token';

  static const String notifications = '/api/v1/me/notifications';
  static const String notificationsUnreadCount =
      '/api/v1/me/notifications/unread-count';
  static const String notificationRead = '/api/v1/me/notifications/{id}/read';
  static const String notificationsReadAll =
      '/api/v1/me/notifications/read-all';
  static const String notificationPreferences =
      '/api/v1/me/notification-preferences';
  static const String notificationPreference =
      '/api/v1/me/notification-preferences/{category}';
  static const String registerPushToken = '/api/v1/me/devices/push-token';
  static const String unregisterPushToken = '/api/v1/me/devices/push-token';

  static const String challenges = '/api/v1/matches/challenges';
  static const String challengeDetails = '/api/v1/matches/challenges/{id}';
  static const String respondToChallenge =
      '/api/v1/matches/challenges/{id}/respond';
  static const String upcomingMatches = '/api/v1/matches/upcoming';
  static const String matchHistory = '/api/v1/matches/history';
  static const String matchDetails = '/api/v1/matches/{id}';
  static const String matchResults = '/api/v1/matches/{id}/results';
  static const String verifyMatchResult = '/api/v1/matches/{id}/results/verify';
}
