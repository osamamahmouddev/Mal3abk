import 'package:geolocator/geolocator.dart';

/// A point on the map, in degrees.
class GeoPoint {
  const GeoPoint({required this.latitude, required this.longitude});

  /// Downtown Cairo, where the map opens when the player's location is unknown.
  static const GeoPoint cairo = GeoPoint(latitude: 30.0444, longitude: 31.2357);

  final double latitude;
  final double longitude;
}

/// The player's location, read only when they have allowed it. Nothing is
/// sent anywhere except as explore search coordinates.
class LocationService {
  const LocationService();

  static const Duration timeout = Duration(seconds: 8);

  Future<bool> hasPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// Shows the system prompt if the player hasn't answered it yet.
  Future<bool> requestPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) return false;
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// Null when permission is missing, location is off or it times out.
  Future<GeoPoint?> current({bool ask = false}) async {
    try {
      final allowed = ask ? await requestPermission() : await hasPermission();
      if (!allowed || !await Geolocator.isLocationServiceEnabled()) return null;
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: timeout,
        ),
      );
      return GeoPoint(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } on Exception {
      return null;
    }
  }
}
