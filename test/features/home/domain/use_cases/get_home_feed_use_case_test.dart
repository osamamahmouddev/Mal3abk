import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/home/data/models/home_feed_model.dart';
import 'package:mal3abk/features/home/domain/repos/home_repo.dart';
import 'package:mal3abk/features/home/domain/use_cases/get_home_feed_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepo extends Mock implements HomeRepo {}

void main() {
  late MockHomeRepo homeRepo;
  late GetHomeFeedUseCase useCase;

  const feed = HomeFeedModel(
    nearby: HomeSectionModel(status: 'ok'),
    popularNearYou: HomeSectionModel(status: 'empty'),
    recentlyViewed: HomeSectionModel(status: 'ok'),
    generatedAtUtc: '2026-10-31T20:00:00Z',
  );

  setUp(() {
    homeRepo = MockHomeRepo();
    useCase = GetHomeFeedUseCase(homeRepo: homeRepo);
  });

  test('shows all of Egypt by default, whatever the profile says', () async {
    when(
      () => homeRepo.getHomeFeed(),
    ).thenAnswer((_) async => const ApiResult.success(feed));

    final located = (await useCase() as Success).data;

    expect((located.city, located.area), (null, null));
  });

  test('a picked place is passed through', () async {
    when(
      () => homeRepo.getHomeFeed(city: 'القاهرة', area: 'المعادي'),
    ).thenAnswer((_) async => const ApiResult.success(feed));

    final located =
        (await useCase(city: 'القاهرة', area: 'المعادي') as Success).data;

    expect((located.city, located.area), ('القاهرة', 'المعادي'));
  });
}
