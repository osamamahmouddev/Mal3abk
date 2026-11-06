/// The visible map area, in degrees.
class MapBoundsModel {
  const MapBoundsModel({
    required this.south,
    required this.west,
    required this.north,
    required this.east,
  });

  /// The server accepts boxes up to this many degrees wide or tall.
  static const double maxSpanDegrees = 2;

  final double south;
  final double west;
  final double north;
  final double east;

  bool get isSearchable =>
      north - south <= maxSpanDegrees && east - west <= maxSpanDegrees;
}
