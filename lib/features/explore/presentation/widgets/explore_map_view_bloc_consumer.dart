import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/location/location_service.dart';
import '../../data/models/map_bounds_model.dart';
import '../cubit/explore_map_cubit.dart';
import '../cubit/explore_map_state.dart';

/// The Google map with one marker per venue; searches whenever the camera
/// settles and follows the center the cubit asks for.
class ExploreMapViewBlocConsumer extends HookWidget {
  const ExploreMapViewBlocConsumer({super.key});

  static const double initialZoom = 13;

  @override
  Widget build(BuildContext context) {
    final controller = useRef<GoogleMapController?>(null);
    final cubit = context.read<ExploreMapCubit>();

    Future<void> searchVisible() async {
      final map = controller.value;
      if (map == null) return;
      final region = await map.getVisibleRegion();
      await cubit.search(
        MapBoundsModel(
          south: region.southwest.latitude,
          west: region.southwest.longitude,
          north: region.northeast.latitude,
          east: region.northeast.longitude,
        ),
      );
    }

    LatLng toLatLng(GeoPoint p) => LatLng(p.latitude, p.longitude);

    return BlocConsumer<ExploreMapCubit, ExploreMapState>(
      listenWhen: (previous, current) =>
          previous is ExploreMapReady &&
          current is ExploreMapReady &&
          previous.center != current.center,
      listener: (context, state) {
        if (state is ExploreMapReady) {
          controller.value?.animateCamera(
            CameraUpdate.newLatLng(toLatLng(state.center)),
          );
        }
      },
      buildWhen: (previous, current) =>
          previous is! ExploreMapReady ||
          current is! ExploreMapReady ||
          previous.pins != current.pins ||
          previous.hasMyLocation != current.hasMyLocation ||
          previous.selected != current.selected,
      builder: (context, state) {
        if (state is! ExploreMapReady) return const SizedBox.expand();
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: toLatLng(state.center),
            zoom: initialZoom,
          ),
          myLocationEnabled: state.hasMyLocation,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          onMapCreated: (map) {
            controller.value = map;
            searchVisible();
          },
          onCameraIdle: searchVisible,
          onTap: (_) => cubit.select(null),
          markers: {
            for (final pin in state.pins)
              Marker(
                markerId: MarkerId(pin.venueId),
                position: LatLng(pin.latitude, pin.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  pin.venueId == state.selected?.venueId
                      ? BitmapDescriptor.hueRed
                      : BitmapDescriptor.hueAzure,
                ),
                onTap: () {
                  HapticFeedback.selectionClick();
                  cubit.select(pin);
                },
              ),
          },
        );
      },
    );
  }
}
