import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/explore/data/models/explore_venue_card_model.dart';
import 'package:mal3abk/features/explore/domain/repos/explore_repo.dart';
import 'package:mal3abk/features/home/presentation/cubit/recently_viewed_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockExploreRepo extends Mock implements ExploreRepo {}

const venue = ExploreVenueCardModel(
  venueId: 'v-1',
  name: 'ملعب النجوم',
  slug: 'nogoum',
  city: 'القاهرة',
  area: 'مدينة نصر',
);

void main() {
  late MockExploreRepo repo;
  late RecentlyViewedCubit cubit;

  setUp(() {
    repo = MockExploreRepo();
    cubit = RecentlyViewedCubit(exploreRepo: repo);
    when(
      () => repo.getRecentlyViewed(),
    ).thenAnswer((_) async => const ApiResult.success([venue]));
  });

  tearDown(() => cubit.close());

  test('loads the venues the player opened', () async {
    await cubit.load();

    expect(cubit.state, [venue]);
  });

  test('restores the list when clearing fails', () async {
    when(() => repo.clearRecentlyViewed()).thenAnswer(
      (_) async =>
          const ApiResult.failure(AppApiFailure(message: 'errors.network')),
    );
    await cubit.load();

    await cubit.clear();

    expect(cubit.state, [venue]);
  });
}
