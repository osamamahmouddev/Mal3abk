import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/explore/data/models/explore_venue_card_model.dart';
import 'package:mal3abk/features/explore/domain/repos/explore_repo.dart';
import 'package:mal3abk/features/explore/presentation/cubit/favorite_toggle_cubit.dart';
import 'package:mal3abk/features/explore/presentation/cubit/favorites_cubit.dart';
import 'package:mal3abk/features/explore/presentation/cubit/favorites_state.dart';
import 'package:mocktail/mocktail.dart';

class MockExploreRepo extends Mock implements ExploreRepo {}

ExploreVenueCardModel venue(String id) => ExploreVenueCardModel(
  venueId: id,
  name: 'ملعب $id',
  slug: id,
  city: 'القاهرة',
  area: 'مدينة نصر',
  isFavorite: true,
);

const failure = ApiResult<void>.failure(
  AppApiFailure(message: 'errors.network'),
);

void main() {
  late MockExploreRepo repo;

  setUp(() => repo = MockExploreRepo());

  group('FavoriteToggleCubit', () {
    test('flips the heart at once and saves it', () async {
      when(
        () => repo.setFavorite('v-1', favorite: true),
      ).thenAnswer((_) async => const ApiResult.success(null));
      final cubit = FavoriteToggleCubit(exploreRepo: repo);

      final pending = cubit.toggle('v-1', loaded: false);
      expect(cubit.isFavorite('v-1', loaded: false), isTrue);
      await pending;

      expect(cubit.isFavorite('v-1', loaded: false), isTrue);
      await cubit.close();
    });

    test('rolls back and reports a failed save', () async {
      when(
        () => repo.setFavorite('v-1', favorite: false),
      ).thenAnswer((_) async => failure);
      final cubit = FavoriteToggleCubit(exploreRepo: repo);

      await cubit.toggle('v-1', loaded: true);

      expect(cubit.isFavorite('v-1', loaded: true), isTrue);
      expect(cubit.state.failure, 'errors.network');
      await cubit.close();
    });
  });

  group('FavoritesCubit', () {
    test('removes a venue and restores it if the server refuses', () async {
      when(
        () => repo.getFavorites(),
      ).thenAnswer((_) async => ApiResult.success([venue('a'), venue('b')]));
      when(
        () => repo.setFavorite('a', favorite: false),
      ).thenAnswer((_) async => failure);
      final cubit = FavoritesCubit(exploreRepo: repo);
      await cubit.load();

      await cubit.remove('a');

      final state = cubit.state as FavoritesSuccess;
      expect(state.venues.map((v) => v.venueId), ['a', 'b']);
      expect(state.failure, 'errors.network');
      await cubit.close();
    });
  });
}
