class ApiConstants {
  const ApiConstants._();

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String profile = '/auth/profile';

  static const String fields = '/fields';
  static const String fieldDetails = '/fields/{id}';
  static const String bookings = '/bookings';
  static const String bookingDetails = '/bookings/{id}';
}
