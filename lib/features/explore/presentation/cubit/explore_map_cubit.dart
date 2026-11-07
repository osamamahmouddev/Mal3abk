import 'dart:async';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/location/location_service.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/explore_filter_model.dart';
import '../../data/models/map_bounds_model.dart';
import '../../data/models/map_venue_pin_model.dart';
import '../../domain/repos/explore_repo.dart';
import 'explore_map_state.dart';

class ExploreMapCubit extends Cubit<ExploreMapState>
    with SafeEmitCubitMixin<ExploreMapState> {
  ExploreMapCubit({required this.exploreRepo, required this.locationService})
    : super(const ExploreMapState.locating());

  final ExploreRepo exploreRepo;
  final LocationService locationService;

  ExploreFilterModel filter = const ExploreFilterModel();
  MapBoundsModel? _lastBounds;
  int _request = 0;
  bool _triedWiderSearch = false;

  /// Half the side of the area searched once when the opening view is empty.
  static const double _widerSearchRadius = 0.9;

  /// Opens on the player when they allowed location, otherwise on Cairo.
  Future<void> start({bool ask = false}) async {
    final point = await locationService.current(ask: ask);
    emitIfOpen(
      ExploreMapState.ready(
        center: point ?? GeoPoint.cairo,
        hasMyLocation: point != null,
      ),
    );
  }

  /// Searches the visible area; older answers are dropped if the player has
  /// moved on.
  Future<void> search(MapBoundsModel bounds) async {
    final current = state;
    if (current is! ExploreMapReady) return;
    _lastBounds = bounds;
    if (!bounds.isSearchable) {
      emitIfOpen(current.copyWith(tooWide: true, searching: false));
      return;
    }
    final request = ++_request;
    emitIfOpen(
      current.copyWith(searching: true, tooWide: false, failure: null),
    );
    final result = await exploreRepo.mapVenues(bounds: bounds, filter: filter);
    final latest = state;
    if (request != _request || latest is! ExploreMapReady) return;
    result.when(
      success: (data) {
        emitIfOpen(
          latest.copyWith(
            pins: data.pins,
            truncated: data.truncated,
            searching: false,
            fitTo: null,
            selected: data.pins
                .where((p) => p.venueId == latest.selected?.venueId)
                .firstOrNull,
          ),
        );
        if (data.pins.isEmpty) unawaited(_showWhereVenuesAre(bounds));
      },
      failure: (failure) => emitIfOpen(
        latest.copyWith(searching: false, failure: failure.message),
      ),
    );
  }

  /// The opening view can sit over an area with no pitches while some are a
  /// few kilometres away. Looks around once and, if it finds any, asks the
  /// map to move so they are visible. Never moves the map after the player
  /// has begun exploring on their own.
  Future<void> _showWhereVenuesAre(MapBoundsModel empty) async {
    if (_triedWiderSearch) return;
    _triedWiderSearch = true;
    final latitude = (empty.north + empty.south) / 2;
    final longitude = (empty.east + empty.west) / 2;
    final result = await exploreRepo.mapVenues(
      bounds: MapBoundsModel(
        south: latitude - _widerSearchRadius,
        west: longitude - _widerSearchRadius,
        north: latitude + _widerSearchRadius,
        east: longitude + _widerSearchRadius,
      ),
      filter: filter,
    );
    final current = state;
    if (current is! ExploreMapReady || _lastBounds != empty) return;
    final pins = result.maybeWhen(
      success: (data) => data.pins,
      orElse: () => const <MapVenuePinModel>[],
    );
    if (pins.isEmpty) return;
    var south = pins.first.latitude;
    var north = south;
    var west = pins.first.longitude;
    var east = west;
    for (final pin in pins) {
      south = math.min(south, pin.latitude);
      north = math.max(north, pin.latitude);
      west = math.min(west, pin.longitude);
      east = math.max(east, pin.longitude);
    }
    // Keep the player's own spot in view so the map does not feel like it
    // jumped somewhere unrelated.
    south = math.min(south, empty.south);
    north = math.max(north, empty.north);
    west = math.min(west, empty.west);
    east = math.max(east, empty.east);
    emitIfOpen(
      current.copyWith(
        fitTo: MapBoundsModel(
          south: south,
          west: west,
          north: north,
          east: east,
        ),
      ),
    );
  }

  Future<void> applyFilter(ExploreFilterModel next) async {
    filter = next;
    final bounds = _lastBounds;
    if (bounds != null) await search(bounds);
  }

  void select(MapVenuePinModel? pin) {
    final current = state;
    if (current is ExploreMapReady) {
      emitIfOpen(current.copyWith(selected: pin));
    }
  }

  Future<GeoPoint?> locateMe() async {
    final point = await locationService.current(ask: true);
    final current = state;
    if (point != null && current is ExploreMapReady) {
      emitIfOpen(current.copyWith(center: point, hasMyLocation: true));
    }
    return point;
  }
}
