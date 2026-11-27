import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/explore/data/models/sponsored_item_model.dart';
import 'package:mal3abk/features/explore/domain/repos/explore_repo.dart';
import 'package:mal3abk/features/explore/presentation/cubit/featured_venues_cubit.dart';
import 'package:mal3abk/features/home/data/models/home_feed_model.dart';
import 'package:mal3abk/features/home/data/models/located_home_feed_model.dart';
import 'package:mal3abk/features/home/domain/use_cases/get_home_feed_use_case.dart';
import 'package:mal3abk/features/home/presentation/cubit/home_feed_cubit.dart';
import 'package:mal3abk/features/home/presentation/cubit/home_feed_state.dart';
import 'package:mal3abk/features/home/presentation/widgets/home_sponsored_bloc_builder.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/pump_localized.dart';

class MockExploreRepo extends Mock implements ExploreRepo {}

class MockGetHomeFeedUseCase extends Mock implements GetHomeFeedUseCase {}

Map<String, dynamic> venueJson(String id, String name) => {
  'venueId': id,
  'name': name,
  'slug': id,
  'city': 'القاهرة',
  'area': 'حلوان',
};

Map<String, dynamic> section() => {'status': 'Ok', 'items': <Object>[]};

Map<String, dynamic> feedJson({Object? sponsored}) => {
  'nearby': section(),
  'popularNearYou': section(),
  'recentlyViewed': section(),
  'generatedAtUtc': '2026-11-27T10:00:00Z',
  'sponsored': sponsored,
};

/// The home feed cubit in a fixed state, for the widget under test.
class FixedHomeFeedCubit extends HomeFeedCubit {
  FixedHomeFeedCubit(HomeFeedState state)
    : super(getHomeFeedUseCase: MockGetHomeFeedUseCase()) {
    emit(state);
  }
}

void main() {
  group('reading the home feed', () {
    test('a running ad arrives with its label, title and venue', () {
      final feed = HomeFeedModel.fromJson(
        feedJson(
          sponsored: {
            'status': 'Ok',
            'items': [
              {
                'label': 'sponsored',
                'title': 'خصم ٢٠٪ للصبح',
                'venue': venueJson('v1', 'ملعب ولاد البلد'),
              },
            ],
          },
        ),
      );

      final ad = feed.sponsored!.items.single;
      expect(ad.label, 'sponsored');
      expect(ad.title, 'خصم ٢٠٪ للصبح');
      expect(ad.venue.name, 'ملعب ولاد البلد');
    });

    test(
      'ads switched off (null) or an older server without the field still read',
      () {
        expect(HomeFeedModel.fromJson(feedJson()).sponsored, isNull);
        final withoutField = feedJson()..remove('sponsored');
        expect(HomeFeedModel.fromJson(withoutField).sponsored, isNull);
      },
    );
  });

  group('featured venues on explore', () {
    late MockExploreRepo repo;

    setUp(() => repo = MockExploreRepo());

    test('loads the running ads', () async {
      final ad = SponsoredItemModel.fromJson({
        'label': 'sponsored',
        'title': 'ملعب ولاد البلد',
        'venue': venueJson('v1', 'ملعب ولاد البلد'),
      });
      when(
        () => repo.getFeaturedVenues(),
      ).thenAnswer((_) async => ApiResult.success([ad]));
      final cubit = FeaturedVenuesCubit(exploreRepo: repo);
      addTearDown(cubit.close);

      await cubit.load();

      expect(cubit.state.single.venue.venueId, 'v1');
    });

    test(
      'a failure leaves the strip empty instead of showing an error',
      () async {
        when(() => repo.getFeaturedVenues()).thenAnswer(
          (_) async =>
              const ApiResult.failure(AppApiFailure(message: 'errors.network')),
        );
        final cubit = FeaturedVenuesCubit(exploreRepo: repo);
        addTearDown(cubit.close);

        await cubit.load();

        expect(cubit.state, isEmpty);
      },
    );
  });

  group('the home section', () {
    Future<void> pumpWith(WidgetTester tester, HomeFeedModel feed) async {
      final cubit = FixedHomeFeedCubit(
        HomeFeedState.success(LocatedHomeFeedModel(feed: feed)),
      );
      addTearDown(cubit.close);
      await pumpLocalized(
        tester,
        BlocProvider<HomeFeedCubit>.value(
          value: cubit,
          child: const HomeSponsoredBlocBuilder(),
        ),
      );
    }

    testWidgets(
      'every promoted venue is tagged «إعلان», with the admin\'s line',
      (tester) async {
        await pumpWith(
          tester,
          HomeFeedModel.fromJson(
            feedJson(
              sponsored: {
                'status': 'Ok',
                'items': [
                  {
                    'label': 'sponsored',
                    'title': 'خصم ٢٠٪ للصبح',
                    'venue': venueJson('v1', 'ملعب ولاد البلد'),
                  },
                  {
                    'label': 'sponsored',
                    'title': 'ملعب النجوم',
                    'venue': venueJson('v2', 'ملعب النجوم'),
                  },
                ],
              },
            ),
          ),
        );

        expect(find.text('ملاعب مميزة'), findsOneWidget);
        expect(find.text('إعلان'), findsNWidgets(2));
        expect(find.text('ملعب ولاد البلد'), findsOneWidget);
        expect(find.text('خصم ٢٠٪ للصبح'), findsOneWidget);
      },
    );

    testWidgets('nothing shows while ads are off or none is running', (
      tester,
    ) async {
      await pumpWith(tester, HomeFeedModel.fromJson(feedJson()));
      expect(find.text('ملاعب مميزة'), findsNothing);
      expect(find.text('إعلان'), findsNothing);

      await pumpWith(
        tester,
        HomeFeedModel.fromJson(feedJson(sponsored: section())),
      );
      expect(find.text('ملاعب مميزة'), findsNothing);
    });
  });
}
