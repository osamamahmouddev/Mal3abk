/// Step 1 of the venue setup: the place itself.
class VenueSetupForm {
  const VenueSetupForm({
    required this.name,
    required this.city,
    required this.area,
    required this.phoneNumber,
    required this.address,
    required this.description,
    required this.facilities,
    required this.latitude,
    required this.longitude,
    this.photos = const [],
  });

  final String name;

  /// Arabic governorate and area names, as the web dashboard sends them.
  final String city;
  final String area;
  final String phoneNumber;
  final String address;
  final String description;
  final List<String> facilities;
  final double? latitude;
  final double? longitude;

  /// Photos picked before the venue exists (sent with the first save).
  final List<String> photos;

  /// Egypt with a margin: a point outside it is almost always swapped or
  /// mistyped coordinates.
  static bool inEgypt(double lat, double lng) =>
      lat >= 21.5 && lat <= 32 && lng >= 24.5 && lng <= 37.5;

  bool get hasLocation =>
      latitude != null && longitude != null && inEgypt(latitude!, longitude!);

  bool get isValid =>
      name.trim().length >= 3 &&
      city.isNotEmpty &&
      area.trim().isNotEmpty &&
      phoneNumber.trim().isNotEmpty &&
      address.trim().isNotEmpty &&
      hasLocation;

  Map<String, dynamic> toJson() => {
    'name': name.trim(),
    'city': city,
    'area': area.trim(),
    'phoneNumber': phoneNumber.trim(),
    'address': address.trim(),
    'description': description.trim().isEmpty ? null : description.trim(),
    'facilities': facilities,
    'photos': photos,
    'latitude': latitude,
    'longitude': longitude,
  };

  /// Pulls coordinates out of a pasted "30.04, 31.23" or a Google, Apple or
  /// OpenStreetMap link. Short links carry no coordinates and give null.
  static (double, double)? parseCoordinates(String text) {
    const n = r'(-?\d{1,3}(?:\.\d+)?)';
    final patterns = [
      RegExp('!3d$n!4d$n'),
      RegExp('@$n,$n'),
      RegExp('[?&](?:q|query|ll|destination|center)=$n,\\s*$n'),
      RegExp('mlat=$n&mlon=$n'),
      RegExp('^$n\\s*[,،\\s]\\s*$n\$'),
    ];
    var decoded = text.trim();
    try {
      decoded = Uri.decodeComponent(decoded);
    } catch (_) {}
    for (final p in patterns) {
      final m = p.firstMatch(decoded);
      if (m == null) continue;
      final lat = double.tryParse(m.group(1)!);
      final lng = double.tryParse(m.group(2)!);
      if (lat != null && lng != null && lat.abs() <= 90 && lng.abs() <= 180) {
        return (lat, lng);
      }
    }
    return null;
  }
}

/// One weekday's opening hours in the setup ("16:00" to "02:00").
class DayHours {
  const DayHours({
    required this.on,
    required this.open,
    required this.close,
    this.slot = 60,
  });

  final bool on;
  final String open;
  final String close;
  final int slot;

  DayHours copyWith({bool? on, String? open, String? close}) => DayHours(
    on: on ?? this.on,
    open: open ?? this.open,
    close: close ?? this.close,
    slot: slot,
  );

  /// .NET weekday numbers (Sunday = 0), shown from Saturday.
  static const List<int> dayOrder = [6, 0, 1, 2, 3, 4, 5];

  static Map<int, DayHours> defaultWeek() => {
    for (final d in dayOrder)
      d: DayHours(on: true, open: d == 5 ? '14:00' : '16:00', close: '02:00'),
  };

  /// Players per team a pitch can be set up for.
  static const List<int> capacities = [5, 6, 7, 8, 9, 11];
}
