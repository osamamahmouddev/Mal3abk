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
    when(
      () => location.lastKnown(ask: any(named: 'ask')),
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

  test('opens at once on the last known position, without a GPS wait', () async {
    const known = GeoPoint(latitude: 31.2, longitude: 29.9);
    when(
      () => location.lastKnown(ask: any(named: 'ask')),
    ).thenAnswer((_) async => known);

    await cubit.start();

    final state = cubit.state as ExploreMapReady;
    expect(state.center, known);
    expect(state.hasMyLocation, isTrue);
    verifyNever(() => location.current(ask: any(named: 'ask')));
  });

  test('recenters when a fresh fix arrives after opening on Cairo', () async {
    const fresh = GeoPoint(latitude: 30.1, longitude: 31.3);
    when(
      () => location.current(ask: any(named: 'ask')),
    ).thenAnswer((_) async => fresh);

    await cubit.start();
    await Future<void>.delayed(Duration.zero);

    final state = cubit.state as ExploreMapReady;
    expect(state.center, fresh);
    expect(state.hasMyLocation, isTrue);
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

  group('when the opening view is empty', () {
    const empty = MapSearchResultModel(
      pins: [],
      totalCount: 0,
      truncated: false,
    );

    test('moves the map to venues found in a wider area', () async {
      final calls = <MapBoundsModel>[];
      when(
        () => repo.mapVenues(
          bounds: any(named: 'bounds'),
          filter: any(named: 'filter'),
        ),
      ).thenAnswer((invocation) async {
        final bounds = invocation.namedArguments[#bounds] as MapBoundsModel;
        calls.add(bounds);
        return ApiResult.success(calls.length == 1 ? empty : result('far'));
      });
      await cubit.start();

      await cubit.search(near);
      await pumpEventQueue();

      final fit = (cubit.state as ExploreMapReady).fitTo!;
      // The venue (30.05, 31.25) and the player's own view are both inside.
      expect(fit.south, lessThanOrEqualTo(30));
      expect(fit.north, greaterThanOrEqualTo(30.1));
      expect(fit.east, greaterThanOrEqualTo(31.3));
      expect(calls[1].isSearchable, isTrue);
    });

    test('only looks around once', () async {
      when(
        () => repo.mapVenues(
          bounds: any(named: 'bounds'),
          filter: any(named: 'filter'),
        ),
      ).thenAnswer((_) async => const ApiResult.success(empty));
      await cubit.start();

      await cubit.search(near);
      await pumpEventQueue();
      await cubit.search(near);
      await pumpEventQueue();

      // Two searches of the view, one wider search in between.
      verify(
        () => repo.mapVenues(
          bounds: any(named: 'bounds'),
          filter: any(named: 'filter'),
        ),
      ).called(3);
      expect((cubit.state as ExploreMapReady).fitTo, isNull);
    });

    test('does not move the map when the view already has venues', () async {
      when(
        () => repo.mapVenues(
          bounds: any(named: 'bounds'),
          filter: any(named: 'filter'),
        ),
      ).thenAnswer((_) async => ApiResult.success(result('here')));
      await cubit.start();

      await cubit.search(near);
      await pumpEventQueue();

      expect((cubit.state as ExploreMapReady).fitTo, isNull);
    });
  });
}
