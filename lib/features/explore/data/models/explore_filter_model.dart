/// Server `ExploreSort`. Distance needs the player's location, which the app
/// doesn't read, so it isn't offered.
enum ExploreSortOption {
  popularity('Popularity'),
  price('Price'),
  name('Name');

  const ExploreSortOption(this.serverName);

  final String serverName;
}

/// Kick-off windows in Cairo time, sent as `From`/`To` for today.
enum ExploreTimeWindow {
  afternoon('16:00', '19:00'),
  evening('19:00', '22:00'),
  night('22:00', '23:59');

  const ExploreTimeWindow(this.from, this.to);

  final String from;
  final String to;
}

class ExploreFilterModel {
  const ExploreFilterModel({
    this.sort = ExploreSortOption.popularity,
    this.timeWindow,
    this.maxPrice,
    this.pitchType,
    this.surface,
    this.facilities = const {},
  });

  static const List<int> priceCaps = [150, 200, 250, 300];

  final ExploreSortOption sort;
  final ExploreTimeWindow? timeWindow;
  final int? maxPrice;
  final String? pitchType;
  final String? surface;
  final Set<String> facilities;

  /// Nullable fields take a function so they can be cleared.
  ExploreFilterModel copyWith({
    ExploreSortOption? sort,
    ExploreTimeWindow? Function()? timeWindow,
    int? Function()? maxPrice,
    String? Function()? pitchType,
    String? Function()? surface,
    Set<String>? facilities,
  }) => ExploreFilterModel(
    sort: sort ?? this.sort,
    timeWindow: timeWindow == null ? this.timeWindow : timeWindow(),
    maxPrice: maxPrice == null ? this.maxPrice : maxPrice(),
    pitchType: pitchType == null ? this.pitchType : pitchType(),
    surface: surface == null ? this.surface : surface(),
    facilities: facilities ?? this.facilities,
  );

  int get activeCount =>
      (sort == ExploreSortOption.popularity ? 0 : 1) +
      (timeWindow == null ? 0 : 1) +
      (maxPrice == null ? 0 : 1) +
      (pitchType == null ? 0 : 1) +
      (surface == null ? 0 : 1) +
      facilities.length;
}
