import '../../../../core/utils/cairo_time.dart';
import '../../../venue_shell/data/models/venue_booking_status.dart';

enum VenueBookingsTab { all, pending, confirmed, closed }

enum VenueBookingsRange { all, today, tomorrow, week, month }

enum VenueBookingsSource { all, app, manual }

enum VenueBookingsSort { startAsc, startDesc, createdDesc, priceDesc }

/// The bookings list filters, the same as the venue web page.
class VenueBookingsQuery {
  const VenueBookingsQuery({
    this.tab = VenueBookingsTab.all,
    this.search = '',
    this.pitchId,
    this.source = VenueBookingsSource.all,
    this.sort = VenueBookingsSort.startAsc,
    this.range = VenueBookingsRange.all,
  });

  final VenueBookingsTab tab;
  final String search;
  final String? pitchId;
  final VenueBookingsSource source;
  final VenueBookingsSort sort;
  final VenueBookingsRange range;

  bool get hasFilters =>
      search.isNotEmpty ||
      pitchId != null ||
      source != VenueBookingsSource.all ||
      range != VenueBookingsRange.all ||
      tab != VenueBookingsTab.all;

  static List<int> statusesOf(VenueBookingsTab tab) => switch (tab) {
    VenueBookingsTab.pending => const [
      VenueBookingStatus.pendingDeposit,
      VenueBookingStatus.proofSubmitted,
      VenueBookingStatus.underReview,
    ],
    VenueBookingsTab.confirmed => const [
      VenueBookingStatus.confirmed,
      VenueBookingStatus.completed,
    ],
    VenueBookingsTab.closed => const [
      VenueBookingStatus.rejected,
      VenueBookingStatus.expired,
      VenueBookingStatus.cancelled,
      VenueBookingStatus.noShow,
    ],
    VenueBookingsTab.all => const [],
  };

  String get sortValue => switch (sort) {
    VenueBookingsSort.startAsc => 'start_asc',
    VenueBookingsSort.startDesc => 'start_desc',
    VenueBookingsSort.createdDesc => 'created_desc',
    VenueBookingsSort.priceDesc => 'price_desc',
  };

  bool? get manualValue => switch (source) {
    VenueBookingsSource.all => null,
    VenueBookingsSource.app => false,
    VenueBookingsSource.manual => true,
  };

  /// The range as whole Cairo days: bookings starting from the first day's
  /// midnight up to one second before the day after the last.
  (String, String)? get utcWindow {
    final today = CairoTime.today();
    final (DateTime, DateTime)? days = switch (range) {
      VenueBookingsRange.all => null,
      VenueBookingsRange.today => (today, today),
      VenueBookingsRange.tomorrow => (
        today.add(const Duration(days: 1)),
        today.add(const Duration(days: 1)),
      ),
      VenueBookingsRange.week => (today, today.add(const Duration(days: 6))),
      VenueBookingsRange.month => (
        DateTime(today.year, today.month),
        DateTime(today.year, today.month + 1, 0),
      ),
    };
    if (days == null) return null;
    final start = CairoTime.toUtc(days.$1, 0);
    final end = CairoTime.toUtc(
      DateTime(days.$2.year, days.$2.month, days.$2.day + 1),
      0,
    ).subtract(const Duration(seconds: 1));
    return (start.toIso8601String(), end.toIso8601String());
  }

  VenueBookingsQuery copyWith({
    VenueBookingsTab? tab,
    String? search,
    String? Function()? pitchId,
    VenueBookingsSource? source,
    VenueBookingsSort? sort,
    VenueBookingsRange? range,
  }) => VenueBookingsQuery(
    tab: tab ?? this.tab,
    search: search ?? this.search,
    pitchId: pitchId != null ? pitchId() : this.pitchId,
    source: source ?? this.source,
    sort: sort ?? this.sort,
    range: range ?? this.range,
  );
}
