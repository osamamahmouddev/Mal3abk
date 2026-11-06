import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/location/location_service.dart';
import '../../data/models/map_venue_pin_model.dart';

part 'explore_map_state.freezed.dart';

@freezed
sealed class ExploreMapState with _$ExploreMapState {
  const factory ExploreMapState.locating() = ExploreMapLocating;

  /// [tooWide] when the view spans more than the server allows, so the
  /// player should zoom in; [selected] is the tapped pin.
  const factory ExploreMapState.ready({
    required GeoPoint center,
    required bool hasMyLocation,
    @Default(<MapVenuePinModel>[]) List<MapVenuePinModel> pins,
    @Default(false) bool searching,
    @Default(false) bool truncated,
    @Default(false) bool tooWide,
    MapVenuePinModel? selected,
    String? failure,
  }) = ExploreMapReady;
}
