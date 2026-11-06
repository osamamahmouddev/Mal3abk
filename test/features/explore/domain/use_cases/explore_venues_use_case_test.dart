import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/explore/data/models/explore_result_model.dart';
import 'package:mal3abk/features/explore/domain/repos/explore_repo.dart';
import 'package:mal3abk/features/explore/domain/use_cases/explore_venues_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockExploreRepo extends Mock implements ExploreRepo {}

void main() {
  late MockExploreRepo mockRepo;
  late ExploreVenuesUseCase exploreVenuesUseCase;

  setUp(() {
    mockRepo = MockExploreRepo();
    exploreVenuesUseCase = ExploreVenuesUseCase(exploreRepo: mockRepo);
  });

  const sampleResult = ExploreResultModel(
    items: [],
    page: 1,
    pageSize: 20,
    totalCount: 0,
    hasMore: false,
  );

  test('ExploreVenuesUseCase delegates to repository', () async {
    when(
      () => mockRepo.exploreVenues(page: 1, pageSize: 20),
    ).thenAnswer((_) async => const ApiResult.success(sampleResult));

    final result = await exploreVenuesUseCase(page: 1, pageSize: 20);

    expect(result, isA<Success<ExploreResultModel>>());
    verify(() => mockRepo.exploreVenues(page: 1, pageSize: 20)).called(1);
  });
}
