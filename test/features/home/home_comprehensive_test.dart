import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mal3abk/core/location/location_service.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/explore/data/models/explore_venue_card_model.dart';
import 'package:mal3abk/features/explore/domain/repos/explore_repo.dart';
import 'package:mal3abk/features/home/data/models/home_feed_model.dart';
import 'package:mal3abk/features/home/data/models/home_team_activity_model.dart';
import 'package:mal3abk/features/home/data/models/located_home_feed_model.dart';
import 'package:mal3abk/features/home/data/models/play_time_model.dart';
import 'package:mal3abk/features/home/domain/repos/home_repo.dart';
import 'package:mal3abk/features/home/domain/use_cases/get_home_feed_use_case.dart';
import 'package:mal3abk/features/home/domain/use_cases/get_home_team_activity_use_case.dart';
import 'package:mal3abk/features/home/presentation/cubit/home_feed_cubit.dart';
import 'package:mal3abk/features/home/presentation/cubit/home_feed_state.dart';
import 'package:mal3abk/features/home/presentation/cubit/home_team_activity_cubit.dart';
import 'package:mal3abk/features/home/presentation/cubit/home_team_activity_state.dart';
import 'package:mal3abk/features/home/presentation/cubit/recently_viewed_cubit.dart';
import 'package:mal3abk/features/matches/data/models/match_details_model.dart';
import 'package:mal3abk/features/matches/data/models/match_model.dart';
import 'package:mal3abk/features/matches/domain/repos/matches_repo.dart';
import 'package:mal3abk/features/teams/domain/repos/teams_repo.dart';
import '../../helpers/matches_fixtures.dart';
import '../../helpers/teams_fixtures.dart';

class MockHomeRepo extends Mock implements HomeRepo {}

class MockGetHomeFeedUseCase extends Mock implements GetHomeFeedUseCase {}

class MockGetHomeTeamActivityUseCase extends Mock
    implements GetHomeTeamActivityUseCase {}

class MockExploreRepo extends Mock implements ExploreRepo {}

class MockTeamsRepo extends Mock implements TeamsRepo {}

class MockMatchesRepo extends Mock implements MatchesRepo {}

class FakeLocation extends LocationService {
  const FakeLocation(this.point);
  final GeoPoint? point;

  @override
  Future<GeoPoint?> current({bool ask = false}) async => point;
}

void main() {
  setUpAll(() {
    registerFallbackValue(const GeoPoint(latitude: 30.0, longitude: 31.0));
  });

  group('Home Models Serialization Tests', () {
    test('1. HomeSectionModel fromJson and toJson with items', () {
      final json = {
        'status': 'ok',
        'items': [
          {
            'venueId': 'v-101',
            'name': 'Venue 101',
            'slug': 'v-101',
            'city': 'Cairo',
            'area': 'Maadi',
            'isFavorite': true,
          },
        ],
      };
      final section = HomeSectionModel.fromJson(json);
      expect(section.status, 'ok');
      expect(section.items.length, 1);
      expect(section.items.first.venueId, 'v-101');
      expect(section.toJson()['status'], 'ok');
    });

    test('2. HomeSectionModel handles empty items list', () {
      final json = {'status': 'empty', 'items': <dynamic>[]};
      final section = HomeSectionModel.fromJson(json);
      expect(section.status, 'empty');
      expect(section.items, isEmpty);
    });

    test('3. HomeSectionModel default items is empty list', () {
      final json = {'status': 'error'};
      final section = HomeSectionModel.fromJson(json);
      expect(section.status, 'error');
      expect(section.items, isEmpty);
    });

    test('4. HomeFeedModel parses all sections correctly', () {
      final json = {
        'nearby': {
          'status': 'ok',
          'items': [
            {
              'venueId': 'v1',
              'name': 'Nearby 1',
              'slug': 'n1',
              'city': 'Cairo',
              'area': 'Nasr City',
            },
          ],
        },
        'popularNearYou': {
          'status': 'ok',
          'items': [
            {
              'venueId': 'v2',
              'name': 'Popular 1',
              'slug': 'p1',
              'city': 'Cairo',
              'area': 'Heliopolis',
            },
          ],
        },
        'recentlyViewed': {'status': 'ok', 'items': []},
        'generatedAtUtc': '2026-05-01T12:00:00Z',
      };

      final feed = HomeFeedModel.fromJson(json);
      expect(feed.nearby.status, 'ok');
      expect(feed.nearby.items.length, 1);
      expect(feed.popularNearYou.items.first.name, 'Popular 1');
      expect(feed.recentlyViewed.items, isEmpty);
      expect(feed.generatedAtUtc, '2026-05-01T12:00:00Z');
      expect(feed.toJson()['generatedAtUtc'], '2026-05-01T12:00:00Z');
    });

    test('5. LocatedHomeFeedModel holds feed and place details', () {
      const feed = HomeFeedModel(
        nearby: HomeSectionModel(status: 'ok', items: []),
        popularNearYou: HomeSectionModel(status: 'ok', items: []),
        recentlyViewed: HomeSectionModel(status: 'ok', items: []),
        generatedAtUtc: '2026-05-01T12:00:00Z',
      );
      const located = LocatedHomeFeedModel(
        feed: feed,
        city: 'Giza',
        area: 'Dokki',
      );
      expect(located.feed, feed);
      expect(located.city, 'Giza');
      expect(located.area, 'Dokki');
      expect(located.near, isNull);
    });

    test('6. LocatedHomeFeedModel with GeoPoint for near-me', () {
      const feed = HomeFeedModel(
        nearby: HomeSectionModel(status: 'ok', items: []),
        popularNearYou: HomeSectionModel(status: 'ok', items: []),
        recentlyViewed: HomeSectionModel(status: 'ok', items: []),
        generatedAtUtc: '2026-05-01T12:00:00Z',
      );
      const point = GeoPoint(latitude: 30.0444, longitude: 31.2357);
      const located = LocatedHomeFeedModel(feed: feed, near: point);
      expect(located.near?.latitude, 30.0444);
      expect(located.city, isNull);
      expect(located.area, isNull);
    });
  });

  group('HomeTeamActivityModel Tests', () {
    test(
      '7. isQuiet is true when no challenge, no match awaiting, no next match',
      () {
        const activity = HomeTeamActivityModel(hasTeams: true);
        expect(activity.hasTeams, isTrue);
        expect(activity.isQuiet, isTrue);
      },
    );

    test('8. isQuiet is false when has challengeAwaitingReply', () {
      final challenge = testChallenge(isMyTurn: true);
      final activity = HomeTeamActivityModel(
        hasTeams: true,
        challengeAwaitingReply: challenge,
      );
      expect(activity.isQuiet, isFalse);
    });

    test('9. isQuiet is false when has matchAwaitingResult', () {
      final match = testMatch(id: 'm-1', status: MatchModel.inProgress);
      final details = MatchDetailsModel(match: match, myTeam: myTeam);

      final activity = HomeTeamActivityModel(
        hasTeams: true,
        matchAwaitingResult: details,
      );
      expect(activity.isQuiet, isFalse);
    });

    test('10. isQuiet is false when has nextMatch', () {
      final match = testMatch(id: 'm-2', status: MatchModel.scheduled);
      final activity = HomeTeamActivityModel(hasTeams: true, nextMatch: match);
      expect(activity.isQuiet, isFalse);
    });

    test('11. hasTeams is false indicates no teams joined', () {
      const activity = HomeTeamActivityModel(hasTeams: false);
      expect(activity.hasTeams, isFalse);
      expect(activity.isQuiet, isTrue);
    });
  });

  group('PlayTimeModel Comprehensive Tests', () {
    test('12. PlayTimeModel constants', () {
      expect(PlayTimeModel.days, 7);
      expect(PlayTimeModel.quietFrom, 2);
      expect(PlayTimeModel.quietUntil, 9);
    });

    test('13. Equality and hashCode for same dayOffset and hour', () {
      const p1 = PlayTimeModel(dayOffset: 0, hour: 19);
      const p2 = PlayTimeModel(dayOffset: 0, hour: 19);
      expect(p1, equals(p2));
      expect(p1.hashCode, equals(p2.hashCode));
    });

    test('14. Inequality for different dayOffset', () {
      const p1 = PlayTimeModel(dayOffset: 0, hour: 19);
      const p2 = PlayTimeModel(dayOffset: 1, hour: 19);
      expect(p1, isNot(equals(p2)));
    });

    test('15. Inequality for different hour', () {
      const p1 = PlayTimeModel(dayOffset: 0, hour: 18);
      const p2 = PlayTimeModel(dayOffset: 0, hour: 19);
      expect(p1, isNot(equals(p2)));
    });

    test('16. hoursFor today (dayOffset == 0) offers only upcoming hours', () {
      final now14 = DateTime(2026, 5, 1, 14, 30);
      final hours = PlayTimeModel.hoursFor(0, now14);
      expect(hours.first, 15);
      expect(hours.last, 23);
      expect(hours.length, 9);
    });

    test('17. hoursFor today at 23:30 returns empty list', () {
      final lateNow = DateTime(2026, 5, 1, 23, 30);
      final hours = PlayTimeModel.hoursFor(0, lateNow);
      expect(hours, isEmpty);
    });

    test('18. hoursFor later days (dayOffset > 0) offers all 24 hours', () {
      final now = DateTime(2026, 5, 1, 14, 30);
      final hours = PlayTimeModel.hoursFor(1, now);
      expect(hours.length, 24);
      expect(hours.first, 0);
      expect(hours.last, 23);
    });

    test('19. suggest just after midnight suggests 1 AM today', () {
      final midnight = DateTime(2026, 5, 1, 0, 5);
      final s = PlayTimeModel.suggest(midnight);
      expect(s.dayOffset, 0);
      expect(s.hour, 1);
    });

    test('20. suggest at 10 AM suggests the next hour', () {
      final morning = DateTime(2026, 5, 1, 10, 0);
      final s = PlayTimeModel.suggest(morning);
      expect(s.dayOffset, 0);
      expect(s.hour, 11);
    });

    test('21. suggest at 19:15 suggests 20:00 today', () {
      final evening = DateTime(2026, 5, 1, 19, 15);
      final s = PlayTimeModel.suggest(evening);
      expect(s.dayOffset, 0);
      expect(s.hour, 20);
    });

    test('22. suggest at 20:15 suggests next hour 21:00 today', () {
      final pastEvening = DateTime(2026, 5, 1, 20, 15);
      final s = PlayTimeModel.suggest(pastEvening);
      expect(s.dayOffset, 0);
      expect(s.hour, 21);
    });

    test('23. suggest at 21:05 suggests next hour 22:00 today', () {
      final late = DateTime(2026, 5, 1, 21, 5);
      final s = PlayTimeModel.suggest(late);
      expect(s.dayOffset, 0);
      expect(s.hour, 22);
    });

    test('24. suggest at 22:00 suggests next hour 23:00 today', () {
      final late = DateTime(2026, 5, 1, 22, 0);
      final s = PlayTimeModel.suggest(late);
      expect(s.dayOffset, 0);
      expect(s.hour, 23);
    });

    test('25. suggest at 23:15 suggests 9 AM tomorrow', () {
      final veryLate = DateTime(2026, 5, 1, 23, 15);
      final s = PlayTimeModel.suggest(veryLate);
      expect(s.dayOffset, 1);
      expect(s.hour, 9);
    });

    test('26. onDay preserves hour if available on target day', () {
      const choice = PlayTimeModel(dayOffset: 0, hour: 18);
      final now14 = DateTime(2026, 5, 1, 14, 0);
      final onTomorrow = choice.onDay(1, now14);
      expect(onTomorrow.dayOffset, 1);
      expect(onTomorrow.hour, 18);
    });

    test(
      '27. onDay picks first available hour if original hour passed today',
      () {
        const choice = PlayTimeModel(dayOffset: 1, hour: 12);
        final now15 = DateTime(2026, 5, 1, 15, 0);
        // switching back to today where 12 has already passed
        final onToday = choice.onDay(0, now15);
        expect(onToday.dayOffset, 0);
        expect(onToday.hour, 16);
      },
    );

    test(
      '28. onDay falls back to suggest when target day has no hours left',
      () {
        const choice = PlayTimeModel(dayOffset: 2, hour: 18);
        final lateNow = DateTime(2026, 5, 1, 23, 30);
        final onToday = choice.onDay(0, lateNow);
        expect(onToday.dayOffset, 1);
        expect(onToday.hour, PlayTimeModel.quietUntil);
      },
    );

    test('29. dayFrom calculates exact date across month end', () {
      const model = PlayTimeModel(dayOffset: 3, hour: 20);
      final endOfMonth = DateTime(2026, 5, 30);
      final target = model.dayFrom(endOfMonth);
      expect(target.year, 2026);
      expect(target.month, 6);
      expect(target.day, 2);
    });

    test('30. dayFrom calculates exact date across year end', () {
      const model = PlayTimeModel(dayOffset: 2, hour: 21);
      final endOfYear = DateTime(2026, 12, 31);
      final target = model.dayFrom(endOfYear);
      expect(target.year, 2027);
      expect(target.month, 1);
      expect(target.day, 2);
    });
  });

  group('GetHomeFeedUseCase Tests', () {
    late MockHomeRepo mockHomeRepo;
    late GetHomeFeedUseCase useCase;

    const mockFeed = HomeFeedModel(
      nearby: HomeSectionModel(status: 'ok', items: []),
      popularNearYou: HomeSectionModel(status: 'ok', items: []),
      recentlyViewed: HomeSectionModel(status: 'ok', items: []),
      generatedAtUtc: '2026-05-01T12:00:00Z',
    );

    setUp(() {
      mockHomeRepo = MockHomeRepo();
      useCase = GetHomeFeedUseCase(homeRepo: mockHomeRepo);
    });

    test('31. calls repo without arguments for All of Egypt', () async {
      when(
        () => mockHomeRepo.getHomeFeed(city: null, area: null),
      ).thenAnswer((_) async => const ApiResult.success(mockFeed));

      final res = await useCase();
      expect(res, isA<Success<LocatedHomeFeedModel>>());
      final data = (res as Success<LocatedHomeFeedModel>).data;
      expect(data.city, isNull);
      expect(data.area, isNull);
      expect(data.near, isNull);
      verify(() => mockHomeRepo.getHomeFeed(city: null, area: null)).called(1);
    });

    test('32. calls repo with city and area when provided', () async {
      when(
        () => mockHomeRepo.getHomeFeed(city: 'Cairo', area: 'Zamalek'),
      ).thenAnswer((_) async => const ApiResult.success(mockFeed));

      final res = await useCase(city: 'Cairo', area: 'Zamalek');
      expect(res, isA<Success<LocatedHomeFeedModel>>());
      final data = (res as Success<LocatedHomeFeedModel>).data;
      expect(data.city, 'Cairo');
      expect(data.area, 'Zamalek');
      verify(
        () => mockHomeRepo.getHomeFeed(city: 'Cairo', area: 'Zamalek'),
      ).called(1);
    });

    test(
      '33. calls repo with lat and lng when near GeoPoint is provided',
      () async {
        const point = GeoPoint(latitude: 30.05, longitude: 31.25);
        when(
          () => mockHomeRepo.getHomeFeed(lat: 30.05, lng: 31.25),
        ).thenAnswer((_) async => const ApiResult.success(mockFeed));

        final res = await useCase(near: point);
        expect(res, isA<Success<LocatedHomeFeedModel>>());
        final data = (res as Success<LocatedHomeFeedModel>).data;
        expect(data.near, point);
        expect(data.city, isNull);
        expect(data.area, isNull);
        verify(
          () => mockHomeRepo.getHomeFeed(lat: 30.05, lng: 31.25),
        ).called(1);
      },
    );

    test('34. propagates server error failure from repo', () async {
      when(
        () => mockHomeRepo.getHomeFeed(
          city: any(named: 'city'),
          area: any(named: 'area'),
        ),
      ).thenAnswer(
        (_) async =>
            const ApiResult.failure(AppApiFailure(message: 'errors.server')),
      );

      final res = await useCase();
      expect(res, isA<ApiFailure>());
    });

    test('35. propagates network timeout failure from repo', () async {
      when(
        () => mockHomeRepo.getHomeFeed(
          city: any(named: 'city'),
          area: any(named: 'area'),
        ),
      ).thenAnswer(
        (_) async =>
            const ApiResult.failure(AppApiFailure(message: 'errors.timeout')),
      );

      final res = await useCase();
      expect(res, isA<ApiFailure>());
    });
  });

  group('HomeFeedCubit Comprehensive Tests', () {
    late MockGetHomeFeedUseCase mockUseCase;

    const testFeed = HomeFeedModel(
      nearby: HomeSectionModel(status: 'ok', items: []),
      popularNearYou: HomeSectionModel(status: 'ok', items: []),
      recentlyViewed: HomeSectionModel(status: 'ok', items: []),
      generatedAtUtc: '2026-05-01',
    );

    const testLocated = LocatedHomeFeedModel(
      feed: testFeed,
      city: 'Cairo',
      area: 'Nasr City',
    );

    setUp(() {
      mockUseCase = MockGetHomeFeedUseCase();
    });

    test('36. Initial state is HomeFeedState.initial()', () {
      final cubit = HomeFeedCubit(getHomeFeedUseCase: mockUseCase);
      expect(cubit.state, const HomeFeedState.initial());
      cubit.close();
    });

    test('37. fetchFeed emits [loading, success]', () async {
      final cubit = HomeFeedCubit(getHomeFeedUseCase: mockUseCase);
      when(
        () => mockUseCase(city: 'Cairo', area: 'Nasr City', near: null),
      ).thenAnswer((_) async => const ApiResult.success(testLocated));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const HomeFeedState.loading(),
          const HomeFeedState.success(testLocated),
        ]),
      );

      await cubit.fetchFeed(city: 'Cairo', area: 'Nasr City');
      cubit.close();
    });

    test(
      '38. subsequent fetchFeed() without parameters reuses previously picked area',
      () async {
        final cubit = HomeFeedCubit(getHomeFeedUseCase: mockUseCase);
        when(
          () => mockUseCase(city: 'Alexandria', area: 'Smouha', near: null),
        ).thenAnswer(
          (_) async => const ApiResult.success(
            LocatedHomeFeedModel(
              feed: testFeed,
              city: 'Alexandria',
              area: 'Smouha',
            ),
          ),
        );

        await cubit.fetchFeed(city: 'Alexandria', area: 'Smouha');
        await cubit.fetchFeed();

        verify(
          () => mockUseCase(city: 'Alexandria', area: 'Smouha', near: null),
        ).called(2);
        cubit.close();
      },
    );

    test(
      '39. showAllEgypt resets chosen area and loads feed for all Egypt',
      () async {
        final cubit = HomeFeedCubit(getHomeFeedUseCase: mockUseCase);
        when(
          () => mockUseCase(
            city: any(named: 'city'),
            area: any(named: 'area'),
            near: any(named: 'near'),
          ),
        ).thenAnswer(
          (_) async =>
              const ApiResult.success(LocatedHomeFeedModel(feed: testFeed)),
        );

        await cubit.fetchFeed(city: 'Cairo', area: 'Maadi');
        await cubit.showAllEgypt();

        verify(() => mockUseCase(city: null, area: null, near: null)).called(1);
        cubit.close();
      },
    );

    test(
      '40. showNearMe fetches location and queries feed with near GeoPoint',
      () async {
        const geo = GeoPoint(latitude: 30.0, longitude: 31.0);
        final cubit = HomeFeedCubit(
          getHomeFeedUseCase: mockUseCase,
          locationService: const FakeLocation(geo),
        );

        when(() => mockUseCase(city: null, area: null, near: geo)).thenAnswer(
          (_) async => const ApiResult.success(
            LocatedHomeFeedModel(feed: testFeed, near: geo),
          ),
        );

        final success = await cubit.showNearMe();
        expect(success, isTrue);
        verify(() => mockUseCase(city: null, area: null, near: geo)).called(1);
        cubit.close();
      },
    );

    test(
      '41. showNearMe returns false and leaves feed untouched when location is null',
      () async {
        final cubit = HomeFeedCubit(
          getHomeFeedUseCase: mockUseCase,
          locationService: const FakeLocation(null),
        );

        final success = await cubit.showNearMe();
        expect(success, isFalse);
        verifyNever(
          () => mockUseCase(
            city: any(named: 'city'),
            area: any(named: 'area'),
            near: any(named: 'near'),
          ),
        );
        cubit.close();
      },
    );

    test('42. fetchFeed emits [loading, error] on use case failure', () async {
      final cubit = HomeFeedCubit(getHomeFeedUseCase: mockUseCase);
      when(
        () => mockUseCase(
          city: any(named: 'city'),
          area: any(named: 'area'),
          near: any(named: 'near'),
        ),
      ).thenAnswer(
        (_) async =>
            const ApiResult.failure(AppApiFailure(message: 'errors.offline')),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const HomeFeedState.loading(),
          const HomeFeedState.error('errors.offline'),
        ]),
      );

      await cubit.fetchFeed();
      cubit.close();
    });

    test(
      '43. subsequent fetchFeed does not emit loading if state is already success',
      () async {
        final cubit = HomeFeedCubit(getHomeFeedUseCase: mockUseCase);
        when(
          () => mockUseCase(
            city: any(named: 'city'),
            area: any(named: 'area'),
            near: any(named: 'near'),
          ),
        ).thenAnswer((_) async => const ApiResult.success(testLocated));

        await cubit.fetchFeed();
        expect(cubit.state, isA<HomeFeedSuccess>());

        final states = <HomeFeedState>[];
        final sub = cubit.stream.listen(states.add);

        await cubit.fetchFeed();
        expect(states.whereType<HomeFeedLoading>(), isEmpty);
        await sub.cancel();
        cubit.close();
      },
    );
  });

  group('HomeTeamActivityCubit Tests', () {
    late MockGetHomeTeamActivityUseCase mockUseCase;

    setUp(() {
      mockUseCase = MockGetHomeTeamActivityUseCase();
    });

    test('44. Initial state is HomeTeamActivityState.initial()', () {
      final cubit = HomeTeamActivityCubit(
        getHomeTeamActivityUseCase: mockUseCase,
      );
      expect(cubit.state, const HomeTeamActivityState.initial());
      cubit.close();
    });

    test('45. load emits [loading, success]', () async {
      final cubit = HomeTeamActivityCubit(
        getHomeTeamActivityUseCase: mockUseCase,
      );
      const activity = HomeTeamActivityModel(hasTeams: false);
      when(
        () => mockUseCase(),
      ).thenAnswer((_) async => const ApiResult.success(activity));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const HomeTeamActivityState.loading(),
          const HomeTeamActivityState.success(activity),
        ]),
      );

      await cubit.load();
      cubit.close();
    });

    test('46. load emits [loading, error] on failure', () async {
      final cubit = HomeTeamActivityCubit(
        getHomeTeamActivityUseCase: mockUseCase,
      );
      when(() => mockUseCase()).thenAnswer(
        (_) async => const ApiResult.failure(
          AppApiFailure(message: 'errors.team_fetch_failed'),
        ),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const HomeTeamActivityState.loading(),
          const HomeTeamActivityState.error('errors.team_fetch_failed'),
        ]),
      );

      await cubit.load();
      cubit.close();
    });

    test(
      '47. subsequent load when already success does not emit loading again',
      () async {
        final cubit = HomeTeamActivityCubit(
          getHomeTeamActivityUseCase: mockUseCase,
        );
        const activity = HomeTeamActivityModel(hasTeams: true);
        when(
          () => mockUseCase(),
        ).thenAnswer((_) async => const ApiResult.success(activity));

        await cubit.load();
        expect(cubit.state, isA<HomeTeamActivitySuccess>());

        final states = <HomeTeamActivityState>[];
        final sub = cubit.stream.listen(states.add);

        await cubit.load();
        expect(states.whereType<HomeTeamActivityLoading>(), isEmpty);
        await sub.cancel();
        cubit.close();
      },
    );
  });

  group('RecentlyViewedCubit Comprehensive Tests', () {
    late MockExploreRepo mockRepo;

    const venue = ExploreVenueCardModel(
      venueId: 'v-recent',
      name: 'Recent Ground',
      slug: 'recent-ground',
      city: 'Cairo',
      area: 'Zamalek',
    );

    setUp(() {
      mockRepo = MockExploreRepo();
    });

    test('48. Initial state is empty list', () {
      final cubit = RecentlyViewedCubit(exploreRepo: mockRepo);
      expect(cubit.state, isEmpty);
      cubit.close();
    });

    test('49. load updates state with recently viewed venues', () async {
      final cubit = RecentlyViewedCubit(exploreRepo: mockRepo);
      when(
        () => mockRepo.getRecentlyViewed(),
      ).thenAnswer((_) async => const ApiResult.success([venue]));

      await cubit.load();
      expect(cubit.state, [venue]);
      cubit.close();
    });

    test(
      '50. load keeps state untouched when getRecentlyViewed fails',
      () async {
        final cubit = RecentlyViewedCubit(exploreRepo: mockRepo);
        when(() => mockRepo.getRecentlyViewed()).thenAnswer(
          (_) async =>
              const ApiResult.failure(AppApiFailure(message: 'errors.network')),
        );

        await cubit.load();
        expect(cubit.state, isEmpty);
        cubit.close();
      },
    );

    test('51. clear optimistically sets state to empty', () async {
      final cubit = RecentlyViewedCubit(exploreRepo: mockRepo);
      when(
        () => mockRepo.getRecentlyViewed(),
      ).thenAnswer((_) async => const ApiResult.success([venue]));
      when(
        () => mockRepo.clearRecentlyViewed(),
      ).thenAnswer((_) async => const ApiResult.success(null));

      await cubit.load();
      expect(cubit.state, [venue]);

      await cubit.clear();
      expect(cubit.state, isEmpty);
      verify(() => mockRepo.clearRecentlyViewed()).called(1);
      cubit.close();
    });

    test(
      '52. clear restores previous state if clearRecentlyViewed fails',
      () async {
        final cubit = RecentlyViewedCubit(exploreRepo: mockRepo);
        when(
          () => mockRepo.getRecentlyViewed(),
        ).thenAnswer((_) async => const ApiResult.success([venue]));
        when(() => mockRepo.clearRecentlyViewed()).thenAnswer(
          (_) async =>
              const ApiResult.failure(AppApiFailure(message: 'errors.server')),
        );

        await cubit.load();
        expect(cubit.state, [venue]);

        await cubit.clear();
        expect(cubit.state, [venue]);
        cubit.close();
      },
    );
  });

  group('Home Edge Cases & Time Transitions Tests', () {
    test('53. PlayTimeModel hoursFor dayOffset 0 at 22:45 returns [23]', () {
      final dt = DateTime(2026, 5, 1, 22, 45);
      final hours = PlayTimeModel.hoursFor(0, dt);
      expect(hours, [23]);
    });

    test('54. PlayTimeModel hoursFor dayOffset 0 at 23:00 returns empty', () {
      final dt = DateTime(2026, 5, 1, 23, 0);
      final hours = PlayTimeModel.hoursFor(0, dt);
      expect(hours, isEmpty);
    });

    test(
      '55. PlayTimeModel suggest at 01:00 skips the quiet hours to 9 AM',
      () {
        final dt = DateTime(2026, 5, 1, 1, 0);
        final s = PlayTimeModel.suggest(dt);
        expect(s.dayOffset, 0);
        expect(s.hour, 9);
      },
    );

    test('56. PlayTimeModel suggest at 18:59 suggests 19:00 today', () {
      final dt = DateTime(2026, 5, 1, 18, 59);
      final s = PlayTimeModel.suggest(dt);
      expect(s.dayOffset, 0);
      expect(s.hour, 19);
    });

    test('57. PlayTimeModel onDay across 6 days offset preserves hour', () {
      const choice = PlayTimeModel(dayOffset: 0, hour: 22);
      final now = DateTime(2026, 5, 1, 10, 0);
      final future = choice.onDay(6, now);
      expect(future.dayOffset, 6);
      expect(future.hour, 22);
    });

    test('58. PlayTimeModel dayFrom handles leap year Feb 28 to Feb 29', () {
      const choice = PlayTimeModel(dayOffset: 1, hour: 19);
      final feb28 = DateTime(2028, 2, 28);
      final target = choice.dayFrom(feb28);
      expect(target.year, 2028);
      expect(target.month, 2);
      expect(target.day, 29);
    });

    test('59. HomeFeedModel multiple items in popular section', () {
      final json = {
        'nearby': {'status': 'ok', 'items': <dynamic>[]},
        'popularNearYou': {
          'status': 'ok',
          'items': [
            {
              'venueId': 'p1',
              'name': 'Popular 1',
              'slug': 'p1',
              'city': 'C',
              'area': 'A',
            },
            {
              'venueId': 'p2',
              'name': 'Popular 2',
              'slug': 'p2',
              'city': 'C',
              'area': 'A',
            },
          ],
        },
        'recentlyViewed': {'status': 'ok', 'items': <dynamic>[]},
        'generatedAtUtc': '2026-05-01',
      };
      final feed = HomeFeedModel.fromJson(json);
      expect(feed.popularNearYou.items.length, 2);
    });

    test('60. HomeSectionModel preserves isFavorite flag on venue cards', () {
      final json = {
        'status': 'ok',
        'items': [
          {
            'venueId': 'v1',
            'name': 'V1',
            'slug': 'v1',
            'city': 'C',
            'area': 'A',
            'isFavorite': true,
          },
          {
            'venueId': 'v2',
            'name': 'V2',
            'slug': 'v2',
            'city': 'C',
            'area': 'A',
            'isFavorite': false,
          },
        ],
      };
      final section = HomeSectionModel.fromJson(json);
      expect(section.items[0].isFavorite, isTrue);
      expect(section.items[1].isFavorite, isFalse);
    });

    test('61. LocatedHomeFeedModel equality by reference check', () {
      const feed = HomeFeedModel(
        nearby: HomeSectionModel(status: 'ok', items: []),
        popularNearYou: HomeSectionModel(status: 'ok', items: []),
        recentlyViewed: HomeSectionModel(status: 'ok', items: []),
        generatedAtUtc: '2026-05-01',
      );
      const l1 = LocatedHomeFeedModel(feed: feed, city: 'C', area: 'A');
      expect(l1.city, 'C');
      expect(l1.area, 'A');
    });

    test('62. HomeTeamActivityModel quiet when hasTeams false', () {
      const activity = HomeTeamActivityModel(hasTeams: false);
      expect(activity.isQuiet, isTrue);
      expect(activity.hasTeams, isFalse);
    });

    test(
      '63. HomeFeedCubit nearMe preserved on subsequent fetchFeed() when location enabled',
      () async {
        const geo = GeoPoint(latitude: 30.0, longitude: 31.0);
        final mockUseCase = MockGetHomeFeedUseCase();
        const testFeed = HomeFeedModel(
          nearby: HomeSectionModel(status: 'ok', items: []),
          popularNearYou: HomeSectionModel(status: 'ok', items: []),
          recentlyViewed: HomeSectionModel(status: 'ok', items: []),
          generatedAtUtc: '2026-05-01',
        );
        final cubit = HomeFeedCubit(
          getHomeFeedUseCase: mockUseCase,
          locationService: const FakeLocation(geo),
        );

        when(() => mockUseCase(city: null, area: null, near: geo)).thenAnswer(
          (_) async => const ApiResult.success(
            LocatedHomeFeedModel(feed: testFeed, near: geo),
          ),
        );

        await cubit.showNearMe();
        await cubit.fetchFeed();

        verify(() => mockUseCase(city: null, area: null, near: geo)).called(2);
        cubit.close();
      },
    );

    test(
      '64. HomeFeedCubit switching from nearMe to specific city resets nearMe',
      () async {
        const geo = GeoPoint(latitude: 30.0, longitude: 31.0);
        final mockUseCase = MockGetHomeFeedUseCase();
        const testFeed = HomeFeedModel(
          nearby: HomeSectionModel(status: 'ok', items: []),
          popularNearYou: HomeSectionModel(status: 'ok', items: []),
          recentlyViewed: HomeSectionModel(status: 'ok', items: []),
          generatedAtUtc: '2026-05-01',
        );
        final cubit = HomeFeedCubit(
          getHomeFeedUseCase: mockUseCase,
          locationService: const FakeLocation(geo),
        );

        when(() => mockUseCase(city: null, area: null, near: geo)).thenAnswer(
          (_) async => const ApiResult.success(
            LocatedHomeFeedModel(feed: testFeed, near: geo),
          ),
        );
        when(
          () => mockUseCase(city: 'Suez', area: 'Arbaeen', near: null),
        ).thenAnswer(
          (_) async => const ApiResult.success(
            LocatedHomeFeedModel(feed: testFeed, city: 'Suez', area: 'Arbaeen'),
          ),
        );

        await cubit.showNearMe();
        await cubit.fetchFeed(city: 'Suez', area: 'Arbaeen');

        verify(
          () => mockUseCase(city: 'Suez', area: 'Arbaeen', near: null),
        ).called(1);
        cubit.close();
      },
    );

    test(
      '65. PlayTimeModel onDay 0 from day 3 keeps hour if still available',
      () {
        const choice = PlayTimeModel(dayOffset: 3, hour: 21);
        final now18 = DateTime(2026, 5, 1, 18, 0);
        final onToday = choice.onDay(0, now18);
        expect(onToday.dayOffset, 0);
        expect(onToday.hour, 21);
      },
    );

    test('66. PlayTimeModel suggest at 20:00 exact suggests 21:00', () {
      final now20 = DateTime(2026, 5, 1, 20, 0);
      final s = PlayTimeModel.suggest(now20);
      expect(s.dayOffset, 0);
      expect(s.hour, 21);
    });

    test('67. PlayTimeModel suggest at 21:00 exact suggests 22:00', () {
      final now21 = DateTime(2026, 5, 1, 21, 0);
      final s = PlayTimeModel.suggest(now21);
      expect(s.dayOffset, 0);
      expect(s.hour, 22);
    });

    test('68. PlayTimeModel suggest at 22:00 exact suggests 23:00', () {
      final now22 = DateTime(2026, 5, 1, 22, 0);
      final s = PlayTimeModel.suggest(now22);
      expect(s.dayOffset, 0);
      expect(s.hour, 23);
    });

    test('69. PlayTimeModel suggest at 23:00 exact suggests tomorrow 9 AM', () {
      final now23 = DateTime(2026, 5, 1, 23, 0);
      final s = PlayTimeModel.suggest(now23);
      expect(s.dayOffset, 1);
      expect(s.hour, 9);
    });

    test('70. RecentlyViewedCubit load multiple items', () async {
      final mockRepo = MockExploreRepo();
      const v1 = ExploreVenueCardModel(
        venueId: 'v1',
        name: 'V1',
        slug: 'v1',
        city: 'C',
        area: 'A',
      );
      const v2 = ExploreVenueCardModel(
        venueId: 'v2',
        name: 'V2',
        slug: 'v2',
        city: 'C',
        area: 'A',
      );
      final cubit = RecentlyViewedCubit(exploreRepo: mockRepo);
      when(
        () => mockRepo.getRecentlyViewed(),
      ).thenAnswer((_) async => const ApiResult.success([v1, v2]));

      await cubit.load();
      expect(cubit.state.length, 2);
      expect(cubit.state.map((v) => v.venueId), ['v1', 'v2']);
      cubit.close();
    });

    test('71. HomeSectionModel handles status offline', () {
      final json = {'status': 'offline', 'items': <dynamic>[]};
      final section = HomeSectionModel.fromJson(json);
      expect(section.status, 'offline');
    });

    test('72. HomeFeedModel toJson outputs all sections', () {
      const feed = HomeFeedModel(
        nearby: HomeSectionModel(status: 'ok', items: []),
        popularNearYou: HomeSectionModel(status: 'ok', items: []),
        recentlyViewed: HomeSectionModel(status: 'ok', items: []),
        generatedAtUtc: '2026-05-01',
      );
      final json = feed.toJson();
      expect(json.containsKey('nearby'), isTrue);
      expect(json.containsKey('popularNearYou'), isTrue);
      expect(json.containsKey('recentlyViewed'), isTrue);
      expect(json.containsKey('generatedAtUtc'), isTrue);
    });
  });
}
