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

  group('the day and kick-off hour picked on the home card', () {
    String? sentDate;
    String? sentFrom;
    String? sentTo;

    Future<void> search(ExploreFilterModel filter) async {
      await ExploreRepoImpl(
        exploreApiService: api,
      ).exploreVenues(filter: filter);
      final captured = verify(
        () => api.exploreVenues(
          city: any(named: 'city'),
          area: any(named: 'area'),
          date: captureAny(named: 'date'),
          from: captureAny(named: 'from'),
          to: captureAny(named: 'to'),
          maxPrice: any(named: 'maxPrice'),
          pitchType: any(named: 'pitchType'),
          surface: any(named: 'surface'),
          facilities: any(named: 'facilities'),
          sort: any(named: 'sort'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).captured;
      sentDate = captured[0] as String?;
      sentFrom = captured[1] as String?;
      sentTo = captured[2] as String?;
    }

    test(
      'a day and an hour: that date, a slot starting within the hour',
      () async {
        await search(
          ExploreFilterModel(day: DateTime(2026, 11, 20), startHour: 20),
        );
        expect(sentDate, '2026-11-20');
        expect(sentFrom, '20:00');
        expect(sentTo, '20:59');
      },
    );

    test('single-digit months, days and hours are padded', () async {
      await search(ExploreFilterModel(day: DateTime(2027, 1, 3), startHour: 7));
      expect(sentDate, '2027-01-03');
      expect(sentFrom, '07:00');
      expect(sentTo, '07:59');
    });

    test('an hour without a day searches today', () async {
      final today = CairoTime.today();
      await search(const ExploreFilterModel(startHour: 23));
      expect(
        sentDate,
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}',
      );
      expect(sentFrom, '23:00');
      expect(sentTo, '23:59');
    });

    test('a day without a time searches that whole day', () async {
      await search(ExploreFilterModel(day: DateTime(2026, 11, 18)));
      expect(sentDate, '2026-11-18');
      expect(sentFrom, isNull);
      expect(sentTo, isNull);
    });

    test('a day with a window uses the window on that day', () async {
      await search(
        ExploreFilterModel(
          day: DateTime(2026, 11, 18),
          timeWindow: ExploreTimeWindow.afternoon,
        ),
      );
      expect(sentDate, '2026-11-18');
      expect(sentFrom, '16:00');
      expect(sentTo, '19:00');
    });

    test('an exact hour wins over a window', () async {
      await search(
        const ExploreFilterModel(
          startHour: 21,
          timeWindow: ExploreTimeWindow.afternoon,
        ),
      );
      expect(sentFrom, '21:00');
      expect(sentTo, '21:59');
    });

    test('no day and no time sends no date', () async {
      await search(const ExploreFilterModel());
      expect(sentDate, isNull);
      expect(sentFrom, isNull);
      expect(sentTo, isNull);
    });
  });

  group('the filter keeps the picked day and hour', () {
    test('copyWith keeps them when untouched', () {
      final f = ExploreFilterModel(
        day: DateTime(2026, 11, 20),
        startHour: 20,
      ).copyWith(maxPrice: () => 200);
      expect(f.day, DateTime(2026, 11, 20));
      expect(f.startHour, 20);
      expect(f.maxPrice, 200);
    });

    test('copyWith can clear them', () {
      final f = ExploreFilterModel(
        day: DateTime(2026, 11, 20),
        startHour: 20,
      ).copyWith(day: () => null, startHour: () => null);
      expect(f.day, isNull);
      expect(f.startHour, isNull);
    });

    test('a picked day and hour count as one active filter', () {
      expect(
        ExploreFilterModel(
          day: DateTime(2026, 11, 20),
          startHour: 20,
        ).activeCount,
        1,
      );
      expect(const ExploreFilterModel(startHour: 20).activeCount, 1);
      expect(const ExploreFilterModel().activeCount, 0);
    });
  });
}
