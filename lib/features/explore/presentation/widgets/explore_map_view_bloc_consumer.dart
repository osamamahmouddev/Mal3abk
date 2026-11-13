import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/location/location_service.dart';
import '../../../../core/styles/app_assets.dart';
import '../../data/models/map_bounds_model.dart';
import '../cubit/explore_map_cubit.dart';
import '../cubit/explore_map_state.dart';

/// The Google map with one marker per venue; searches whenever the camera
/// settles and follows the center the cubit asks for.
class ExploreMapViewBlocConsumer extends HookWidget {
  const ExploreMapViewBlocConsumer({super.key});

  static const double initialZoom = 13;

  /// Where the pin's tip sits in its image, so the tip marks the venue.
  static const Offset pinAnchor = Offset(0.5, 0.856);

  @override
  Widget build(BuildContext context) {
    final controller = useRef<GoogleMapController?>(null);
    final cubit = context.read<ExploreMapCubit>();
    final pins = useFuture(
      useMemoized(
        () => Future.wait([
          BitmapDescriptor.asset(
            ImageConfiguration.empty,
            AppAssets.mapPin,
            width: 46,
          ),
          BitmapDescriptor.asset(
            ImageConfiguration.empty,
            AppAssets.mapPinSelected,
            width: 60,
          ),
        ]),
      ),
    ).data;

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
          (previous.center != current.center ||
              (current.fitTo != null && previous.fitTo != current.fitTo)),
      listener: (context, state) {
        if (state is! ExploreMapReady) return;
        final fit = state.fitTo;
        controller.value?.animateCamera(
          fit == null
              ? CameraUpdate.newLatLng(toLatLng(state.center))
              : CameraUpdate.newLatLngBounds(
                  LatLngBounds(
                    southwest: LatLng(fit.south, fit.west),
                    northeast: LatLng(fit.north, fit.east),
                  ),
                  64,
                ),
        );
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
          // Lifts the Google logo and legal text clear of the nav bar below the
          // map instead of letting them sit on its edge.
          padding: EdgeInsets.only(bottom: 18.h),
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
                icon: pins == null
                    ? BitmapDescriptor.defaultMarker
                    : pins[pin.venueId == state.selected?.venueId ? 1 : 0],
                anchor: pinAnchor,
                // The selected pin is drawn above its neighbours.
                zIndexInt: pin.venueId == state.selected?.venueId ? 1 : 0,
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
