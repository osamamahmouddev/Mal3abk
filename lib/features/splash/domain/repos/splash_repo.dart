abstract class SplashRepo {
  Future<bool> isAuthenticated();

  /// Whether the saved session belongs to a venue owner/staff sign-in.
  Future<bool> isVenueSession();
}
