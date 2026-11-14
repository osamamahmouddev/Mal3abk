import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/location/location_service.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/explore/data/models/explore_filter_model.dart';
import 'package:mal3abk/features/explore/data/models/explore_result_model.dart';
import 'package:mal3abk/features/explore/domain/use_cases/explore_venues_use_case.dart';
import 'package:mal3abk/features/explore/presentation/cubit/explore_list_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockExploreVenuesUseCase extends Mock implements ExploreVenuesUseCase {}

class MockLocationService extends Mock implements LocationService {}

const _empty = ExploreResultModel(
  items: [],
  page: 1,
  pageSize: 20,
  totalCount: 0,
  hasMore: false,
);

void main() {
  late MockExploreVenuesUseCase explore;
  late ExploreListCubit cubit;

  setUpAll(() => registerFallbackValue(const ExploreFilterModel()));

  setUp(() {
    explore = MockExploreVenuesUseCase();
    cubit = ExploreListCubit(
      exploreVenuesUseCase: explore,
      locationService: MockLocationService(),
    );
    when(
      () => explore(
        near: any(named: 'near'),
        city: any(named: 'city'),
        area: any(named: 'area'),
        filter: any(named: 'filter'),
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
      ),
    ).thenAnswer((_) async => const ApiResult.success(_empty));
  });
  tearDown(() => cubit.close());

  ExploreFilterModel searched() =>
      verify(
            () => explore(
              near: any(named: 'near'),
              city: any(named: 'city'),
              area: any(named: 'area'),
              filter: captureAny(named: 'filter'),
              page: any(named: 'page'),
              pageSize: any(named: 'pageSize'),
            ),
          ).captured.last
          as ExploreFilterModel;

  group('a search asked for from the home card', () {
    final request = ExploreFilterModel(
      day: DateTime(2026, 11, 20),
      startHour: 20,
    );

    test('searches that day and hour', () async {
      await cubit.applyRequest(request);
      final sent = searched();
      expect(sent.day, DateTime(2026, 11, 20));
      expect(sent.startHour, 20);
      expect(cubit.filter.startHour, 20);
    });

    test('keeps the other filters the player set', () async {
      cubit.filter = const ExploreFilterModel(
        maxPrice: 200,
        sort: ExploreSortOption.price,
        facilities: {'lights'},
      );
      await cubit.applyRequest(request);
      final f = cubit.filter;
      expect(f.maxPrice, 200);
      expect(f.sort, ExploreSortOption.price);
      expect(f.facilities, {'lights'});
    });

    test('replaces a time window with the exact hour', () async {
      cubit.filter = const ExploreFilterModel(
        timeWindow: ExploreTimeWindow.evening,
      );
      await cubit.applyRequest(request);
      expect(cubit.filter.timeWindow, isNull);
      expect(cubit.filter.startHour, 20);
    });

    test('replaces an earlier picked day and hour', () async {
      await cubit.applyRequest(request);
      await cubit.applyRequest(
        ExploreFilterModel(day: DateTime(2026, 11, 22), startHour: 18),
      );
      expect(cubit.filter.day, DateTime(2026, 11, 22));
      expect(cubit.filter.startHour, 18);
    });

    test('a request with only a window keeps that window', () async {
      await cubit.applyRequest(
        const ExploreFilterModel(timeWindow: ExploreTimeWindow.night),
      );
      expect(cubit.filter.timeWindow, ExploreTimeWindow.night);
      expect(cubit.filter.startHour, isNull);
    });
  });
}
