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
      success: (data) => emitIfOpen(
        latest.copyWith(
          pins: data.pins,
          truncated: data.truncated,
          searching: false,
          selected: data.pins
              .where((p) => p.venueId == latest.selected?.venueId)
              .firstOrNull,
        ),
      ),
      failure: (failure) => emitIfOpen(
        latest.copyWith(searching: false, failure: failure.message),
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
