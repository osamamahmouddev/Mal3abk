import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/venue_bookings_query.dart';
import '../../domain/repos/venue_bookings_repo.dart';
import 'venue_bookings_state.dart';

class VenueBookingsCubit extends Cubit<VenueBookingsState>
    with SafeEmitCubitMixin<VenueBookingsState> {
  VenueBookingsCubit({
    required this.venueBookingsRepo,
    this.searchDebounce = const Duration(milliseconds: 300),
  }) : super(const VenueBookingsState.loading(query: VenueBookingsQuery()));

  final VenueBookingsRepo venueBookingsRepo;
  final Duration searchDebounce;

  static const int pageSize = 20;

  String? _venueId;
  Timer? _debounce;

  /// Bumped on every new search so an older, slower answer is dropped.
  int _generation = 0;

  VenueBookingsQuery get query => state.query;

  Future<void> start(String venueId) {
    _venueId = venueId;
    return _reload(query);
  }

  Future<void> refresh() => _reload(query, keepItems: true);

  void setSearch(String text) {
    _debounce?.cancel();
    _debounce = Timer(searchDebounce, () {
      final value = text.trim();
      if (value != query.search) _reload(query.copyWith(search: value));
    });
  }

  Future<void> setQuery(VenueBookingsQuery next) => _reload(next);

  Future<void> loadMore() async {
    final current = state;
    final venueId = _venueId;
    if (venueId == null ||
        current is! VenueBookingsSuccess ||
        current.isLoadingMore ||
        current.items.length >= current.totalCount) {
      return;
    }
    final generation = _generation;
    emitIfOpen(current.copyWith(isLoadingMore: true));
    final result = await venueBookingsRepo.getBookings(
      venueId,
      current.query,
      page: current.page + 1,
      pageSize: pageSize,
    );
    if (generation != _generation) return;
    result.when(
      success: (page) => emitIfOpen(
        current.copyWith(
          items: [...current.items, ...page.items],
          totalCount: page.totalCount,
          page: current.page + 1,
          isLoadingMore: false,
        ),
      ),
      failure: (_) => emitIfOpen(current.copyWith(isLoadingMore: false)),
    );
  }

  Future<void> _reload(
    VenueBookingsQuery next, {
    bool keepItems = false,
  }) async {
    final venueId = _venueId;
    if (venueId == null) return;
    final generation = ++_generation;
    final current = state;
    if (!(keepItems && current is VenueBookingsSuccess)) {
      emitIfOpen(VenueBookingsState.loading(query: next));
    }

    final countsFuture = _loadCounts(venueId, next);
    final result = await venueBookingsRepo.getBookings(
      venueId,
      next,
      pageSize: pageSize,
    );
    if (generation != _generation) return;
    result.when(
      success: (page) => emitIfOpen(
        VenueBookingsState.success(
          query: next,
          items: page.items,
          totalCount: page.totalCount,
          page: 1,
          counts: current is VenueBookingsSuccess ? current.counts : const {},
        ),
      ),
      failure: (failure) => emitIfOpen(
        VenueBookingsState.error(query: next, message: failure.message),
      ),
    );

    final counts = await countsFuture;
    final latest = state;
    if (generation == _generation && latest is VenueBookingsSuccess) {
      emitIfOpen(latest.copyWith(counts: counts));
    }
  }

  /// One tiny request per tab for its total, like the web badges.
  Future<Map<VenueBookingsTab, int>> _loadCounts(
    String venueId,
    VenueBookingsQuery query,
  ) async {
    final entries = await Future.wait(
      VenueBookingsTab.values.map((tab) async {
        final result = await venueBookingsRepo.getBookings(
          venueId,
          query,
          tab: tab,
          pageSize: 1,
        );
        return result.when(
          success: (page) => MapEntry(tab, page.totalCount),
          failure: (_) => null,
        );
      }),
    );
    return Map.fromEntries(
      entries.whereType<MapEntry<VenueBookingsTab, int>>(),
    );
  }

  /// Confirms a manual booking from the list; returns the failure message.
  Future<String?> confirmManual(String bookingId) async {
    final venueId = _venueId;
    final current = state;
    if (venueId == null || current is! VenueBookingsSuccess) return null;
    emitIfOpen(current.copyWith(actionBookingId: bookingId));
    final result = await venueBookingsRepo.confirmManual(venueId, bookingId);
    final latest = state;
    if (latest is VenueBookingsSuccess) {
      emitIfOpen(latest.copyWith(actionBookingId: null));
    }
    return result.when(
      success: (_) {
        refresh();
        return null;
      },
      failure: (f) => f.message,
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
