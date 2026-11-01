import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/home/data/models/home_feed_model.dart';
import 'package:mal3abk/features/home/domain/repos/home_repo.dart';
import 'package:mal3abk/features/home/domain/use_cases/get_home_feed_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepo extends Mock implements HomeRepo {}

void main() {
  late MockHomeRepo mockRepo;
  late GetHomeFeedUseCase getHomeFeedUseCase;

  setUp(() {
    mockRepo = MockHomeRepo();
    getHomeFeedUseCase = GetHomeFeedUseCase(homeRepo: mockRepo);
  });

  const sampleFeed = HomeFeedModel(
    nearby: HomeSectionModel(status: 'ok', items: []),
    popularNearYou: HomeSectionModel(status: 'empty', items: []),
    recentlyViewed: HomeSectionModel(status: 'ok', items: []),
    generatedAtUtc: '2026-10-31T20:00:00Z',
  );

  test('GetHomeFeedUseCase calls repo with parameters', () async {
    when(
      () => mockRepo.getHomeFeed(city: 'القاهرة', area: 'مدينة نصر'),
    ).thenAnswer((_) async => const ApiResult.success(sampleFeed));

    final result = await getHomeFeedUseCase(city: 'القاهرة', area: 'مدينة نصر');

    expect(result, isA<Success<HomeFeedModel>>());
    verify(
      () => mockRepo.getHomeFeed(city: 'القاهرة', area: 'مدينة نصر'),
    ).called(1);
  });
}
