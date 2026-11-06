import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/utils/cairo_time.dart';
import 'package:mal3abk/features/explore/data/apis/explore_api_service.dart';
import 'package:mal3abk/features/explore/data/models/explore_filter_model.dart';
import 'package:mal3abk/features/explore/data/models/explore_result_model.dart';
import 'package:mal3abk/features/explore/data/repos/explore_repo_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockExploreApiService extends Mock implements ExploreApiService {}

void main() {
  late MockExploreApiService api;

  setUpAll(CairoTime.initialize);

  setUp(() {
    api = MockExploreApiService();
    when(
      () => api.exploreVenues(
        city: any(named: 'city'),
        area: any(named: 'area'),
        date: any(named: 'date'),
        from: any(named: 'from'),
        to: any(named: 'to'),
        maxPrice: any(named: 'maxPrice'),
        pitchType: any(named: 'pitchType'),
        surface: any(named: 'surface'),
        facilities: any(named: 'facilities'),
        sort: any(named: 'sort'),
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
      ),
    ).thenAnswer(
      (_) async => const ExploreResultModel(
        items: [],
        page: 1,
        pageSize: 20,
        totalCount: 0,
        hasMore: false,
      ),
    );
  });

  test('sends the filters the way the API expects them', () async {
    final repo = ExploreRepoImpl(exploreApiService: api);

    await repo.exploreVenues(
      filter: const ExploreFilterModel(
        sort: ExploreSortOption.price,
        timeWindow: ExploreTimeWindow.evening,
        maxPrice: 200,
        pitchType: '5-a-side',
        facilities: {'lights', 'parking'},
      ),
    );

    final today = CairoTime.today();
    final captured = verify(
      () => api.exploreVenues(
        city: null,
        area: null,
        date: captureAny(named: 'date'),
        from: '19:00',
        to: '22:00',
        maxPrice: 200,
        pitchType: '5-a-side',
        surface: null,
        facilities: captureAny(named: 'facilities'),
        sort: 'Price',
        page: null,
        pageSize: null,
      ),
    ).captured;
    expect(
      captured[0],
      '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}',
    );
    expect((captured[1] as String).split(',').toSet(), {'lights', 'parking'});
  });

  test('leaves the date out without a time window', () async {
    await ExploreRepoImpl(exploreApiService: api).exploreVenues();

    verify(
      () => api.exploreVenues(
        city: null,
        area: null,
        date: null,
        from: null,
        to: null,
        maxPrice: null,
        pitchType: null,
        surface: null,
        facilities: null,
        sort: 'Popularity',
        page: null,
        pageSize: null,
      ),
    ).called(1);
  });

  test('counts and clears active filters', () {
    const filter = ExploreFilterModel(maxPrice: 150, facilities: {'wifi'});

    expect(filter.activeCount, 2);
    expect(filter.copyWith(maxPrice: () => null).activeCount, 1);
  });
}
