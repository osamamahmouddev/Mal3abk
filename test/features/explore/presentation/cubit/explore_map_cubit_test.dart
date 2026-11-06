import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/location/location_service.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/explore/data/models/explore_filter_model.dart';
import 'package:mal3abk/features/explore/data/models/map_bounds_model.dart';
import 'package:mal3abk/features/explore/data/models/map_venue_pin_model.dart';
import 'package:mal3abk/features/explore/domain/repos/explore_repo.dart';
import 'package:mal3abk/features/explore/presentation/cubit/explore_map_cubit.dart';
import 'package:mal3abk/features/explore/presentation/cubit/explore_map_state.dart';
import 'package:mocktail/mocktail.dart';

class MockExploreRepo extends Mock implements ExploreRepo {}

class MockLocationService extends Mock implements LocationService {}

const near = MapBoundsModel(south: 30, west: 31.2, north: 30.1, east: 31.3);
const wide = MapBoundsModel(south: 29, west: 30, north: 31.5, east: 32.5);

MapSearchResultModel result(String id) => MapSearchResultModel(
  pins: [
    MapVenuePinModel(venueId: id, name: id, latitude: 30.05, longitude: 31.25),
  ],
  totalCount: 1,
  truncated: false,
);

void main() {
  late MockExploreRepo repo;
  late MockLocationService location;
  late ExploreMapCubit cubit;

  setUpAll(() {
    registerFallbackValue(near);
    registerFallbackValue(const ExploreFilterModel());
  });

  setUp(() {
    repo = MockExploreRepo();
    location = MockLocationService();
    when(
      () => location.current(ask: any(named: 'ask')),
    ).thenAnswer((_) async => null);
    cubit = ExploreMapCubit(exploreRepo: repo, locationService: location);
  });

  tearDown(() => cubit.close());

  test('opens on Cairo when the location is unknown', () async {
    await cubit.start();

    final state = cubit.state as ExploreMapReady;
    expect(state.center, GeoPoint.cairo);
    expect(state.hasMyLocation, isFalse);
  });

  test('asks the player to zoom in instead of searching a huge area', () async {
    await cubit.start();

    await cubit.search(wide);

    expect((cubit.state as ExploreMapReady).tooWide, isTrue);
    verifyNever(
      () => repo.mapVenues(
        bounds: any(named: 'bounds'),
        filter: any(named: 'filter'),
      ),
    );
  });

  test('keeps only the answer to the latest search', () async {
    final slow = Completer<ApiResult<MapSearchResultModel>>();
    var calls = 0;
    when(
      () => repo.mapVenues(
        bounds: any(named: 'bounds'),
        filter: any(named: 'filter'),
      ),
    ).thenAnswer(
      (_) => calls++ == 0
          ? slow.future
          : Future.value(ApiResult.success(result('new'))),
    );
    await cubit.start();

    final first = cubit.search(near);
    await cubit.search(near);
    slow.complete(ApiResult.success(result('old')));
    await first;

    expect((cubit.state as ExploreMapReady).pins.map((p) => p.venueId), [
      'new',
    ]);
  });
}
