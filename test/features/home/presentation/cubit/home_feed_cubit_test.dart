import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/location/location_service.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/home/domain/use_cases/get_home_feed_use_case.dart';
import 'package:mal3abk/features/home/presentation/cubit/home_feed_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/auth_fixtures.dart';

class MockGetHomeFeedUseCase extends Mock implements GetHomeFeedUseCase {}

class FakeLocation extends LocationService {
  const FakeLocation(this.point);

  final GeoPoint? point;

  @override
  Future<GeoPoint?> current({bool ask = false}) async => point;
}

void main() {
  late MockGetHomeFeedUseCase useCase;
  late HomeFeedCubit cubit;

  setUp(() {
    useCase = MockGetHomeFeedUseCase();
    when(
      () => useCase(
        city: any(named: 'city'),
        area: any(named: 'area'),
        near: any(named: 'near'),
      ),
    ).thenAnswer((_) async => const ApiResult.failure(serverFailure));
    cubit = HomeFeedCubit(getHomeFeedUseCase: useCase);
  });

  tearDown(() => cubit.close());

  test('refreshing keeps the area the player picked', () async {
    await cubit.fetchFeed(city: 'giza', area: 'dokki');

    await cubit.fetchFeed();

    verify(() => useCase(city: 'giza', area: 'dokki', near: null)).called(2);
  });

  test('shows all of Egypt until the player picks an area', () async {
    await cubit.fetchFeed();

    verify(() => useCase(city: null, area: null, near: null)).called(1);
  });

  test('choosing all of Egypt drops the picked area', () async {
    await cubit.fetchFeed(city: 'giza', area: 'dokki');

    await cubit.showAllEgypt();
    await cubit.fetchFeed();

    verify(() => useCase(city: null, area: null, near: null)).called(2);
  });

  test('near me loads around the player and keeps it on refresh', () async {
    const here = GeoPoint(latitude: 30.1, longitude: 31.3);
    final located = HomeFeedCubit(
      getHomeFeedUseCase: useCase,
      locationService: const FakeLocation(here),
    );

    final found = await located.showNearMe();
    await located.fetchFeed();

    expect(found, isTrue);
    verify(() => useCase(city: null, area: null, near: here)).called(2);
    await located.close();
  });

  test('near me leaves the feed alone when location is unavailable', () async {
    final located = HomeFeedCubit(
      getHomeFeedUseCase: useCase,
      locationService: const FakeLocation(null),
    );

    final found = await located.showNearMe();

    expect(found, isFalse);
    verifyNever(
      () => useCase(
        city: any(named: 'city'),
        area: any(named: 'area'),
        near: any(named: 'near'),
      ),
    );
    await located.close();
  });
}
