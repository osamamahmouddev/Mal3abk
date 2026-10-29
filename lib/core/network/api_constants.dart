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

  static const String fields = '/fields';
  static const String fieldDetails = '/fields/{id}';
  static const String bookings = '/bookings';
  static const String bookingDetails = '/bookings/{id}';
}
