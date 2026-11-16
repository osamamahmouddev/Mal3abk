import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mal3abk/core/location/location_service.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/booking/data/models/booking_quote_request_body.dart';
import 'package:mal3abk/features/booking/data/models/booking_quote_response_model.dart';
import 'package:mal3abk/features/booking/data/models/create_booking_request_body.dart';
import 'package:mal3abk/features/booking/domain/repos/booking_repo.dart';
import 'package:mal3abk/features/booking/domain/use_cases/create_booking_use_case.dart';
import 'package:mal3abk/features/booking/domain/use_cases/get_booking_quote_use_case.dart';
import 'package:mal3abk/features/explore/data/models/explore_filter_model.dart';
import 'package:mal3abk/features/explore/data/models/explore_result_model.dart';
import 'package:mal3abk/features/explore/data/models/explore_venue_card_model.dart';
import 'package:mal3abk/features/explore/data/models/localized_item_model.dart';
import 'package:mal3abk/features/explore/data/models/map_bounds_model.dart';
import 'package:mal3abk/features/explore/data/models/map_venue_pin_model.dart';
import 'package:mal3abk/features/explore/data/models/opening_hours_day_model.dart';
import 'package:mal3abk/features/explore/data/models/pitch_details_model.dart';
import 'package:mal3abk/features/explore/data/models/public_deposit_policy_model.dart';
import 'package:mal3abk/features/explore/data/models/venue_availability_model.dart';
import 'package:mal3abk/features/explore/data/models/venue_details_model.dart';
import 'package:mal3abk/features/explore/domain/repos/explore_repo.dart';
import 'package:mal3abk/features/explore/domain/use_cases/explore_venues_use_case.dart';
import 'package:mal3abk/features/explore/domain/use_cases/get_venue_availability_use_case.dart';
import 'package:mal3abk/features/explore/domain/use_cases/get_venue_details_use_case.dart';
import 'package:mal3abk/features/explore/domain/use_cases/get_venue_pitches_use_case.dart';
import 'package:mal3abk/features/explore/presentation/cubit/pitch_booking_cubit.dart';
import 'package:mal3abk/features/explore/presentation/cubit/pitch_booking_state.dart';
import 'package:mal3abk/features/explore/presentation/cubit/pitch_slot_filter.dart';
import 'package:mal3abk/features/explore/presentation/cubit/venue_profile_cubit.dart';
import 'package:mal3abk/features/explore/presentation/cubit/venue_profile_state.dart';

import 'package:mal3abk/core/utils/cairo_time.dart';

class MockExploreRepo extends Mock implements ExploreRepo {}
class MockBookingRepo extends Mock implements BookingRepo {}

void main() {
  setUpAll(() {
    CairoTime.initialize();
    registerFallbackValue(const ExploreFilterModel());
    registerFallbackValue(const GeoPoint(latitude: 30.0, longitude: 31.0));
    registerFallbackValue(const BookingQuoteRequestBody(pitchId: '', startUtc: '', endUtc: ''));
    registerFallbackValue(const CreateBookingRequestBody(
      pitchId: '',
      startUtc: '',
      endUtc: '',
      quoteToken: '',
      expectedPrice: 0,
    ));
  });

  group('Explore Filter & Enums Tests', () {
    test('1. ExploreSortOption server names are correct', () {
      expect(ExploreSortOption.distance.serverName, 'Distance');
      expect(ExploreSortOption.popularity.serverName, 'Popularity');
      expect(ExploreSortOption.price.serverName, 'Price');
      expect(ExploreSortOption.name.serverName, 'Name');
    });

    test('2. ExploreTimeWindow ranges are defined properly', () {
      expect(ExploreTimeWindow.afternoon.from, '16:00');
      expect(ExploreTimeWindow.afternoon.to, '19:00');
      expect(ExploreTimeWindow.evening.from, '19:00');
      expect(ExploreTimeWindow.evening.to, '22:00');
      expect(ExploreTimeWindow.night.from, '22:00');
      expect(ExploreTimeWindow.night.to, '23:59');
    });

    test('3. ExploreFilterModel default values', () {
      const filter = ExploreFilterModel();
      expect(filter.sort, ExploreSortOption.popularity);
      expect(filter.timeWindow, isNull);
      expect(filter.maxPrice, isNull);
      expect(filter.pitchType, isNull);
      expect(filter.surface, isNull);
      expect(filter.facilities, isEmpty);
      expect(filter.day, isNull);
      expect(filter.startHour, isNull);
      expect(ExploreFilterModel.priceCaps, [150, 200, 250, 300]);
    });

    test('4. ExploreFilterModel copyWith preserves and overwrites correctly', () {
      const filter = ExploreFilterModel();
      final day = DateTime(2026, 5, 1);
      final updated = filter.copyWith(
        sort: ExploreSortOption.price,
        timeWindow: () => ExploreTimeWindow.evening,
        maxPrice: () => 200,
        pitchType: () => '5-a-side',
        surface: () => 'natural_grass',
        facilities: {'parking', 'wifi'},
        day: () => day,
        startHour: () => 18,
      );

      expect(updated.sort, ExploreSortOption.price);
      expect(updated.timeWindow, ExploreTimeWindow.evening);
      expect(updated.maxPrice, 200);
      expect(updated.pitchType, '5-a-side');
      expect(updated.surface, 'natural_grass');
      expect(updated.facilities, {'parking', 'wifi'});
      expect(updated.day, day);
      expect(updated.startHour, 18);
    });

    test('5. ExploreFilterModel copyWith clears timeWindow and startHour with null callbacks', () {
      final filter = ExploreFilterModel(
        timeWindow: ExploreTimeWindow.afternoon,
        startHour: 15,
        day: DateTime(2026, 6, 1),
      );
      final cleared = filter.copyWith(
        timeWindow: () => null,
        startHour: () => null,
      );
      expect(cleared.timeWindow, isNull);
      expect(cleared.startHour, isNull);
      expect(cleared.day, DateTime(2026, 6, 1));
    });

    test('6. ExploreFilterModel activeCount calculates non-default filters count', () {
      const empty = ExploreFilterModel();
      expect(empty.activeCount, 0);

      final withTime = const ExploreFilterModel().copyWith(timeWindow: () => ExploreTimeWindow.afternoon);
      expect(withTime.activeCount, 1);

      final withPriceAndPitch = withTime.copyWith(maxPrice: () => 150, pitchType: () => '5-a-side');
      expect(withPriceAndPitch.activeCount, 3);

      final withFacilities = withPriceAndPitch.copyWith(facilities: {'wifi', 'lockers'});
      expect(withFacilities.activeCount, 5);
    });

    test('7. ExploreFilterModel activeCount counts non-default sort option', () {
      const filter = ExploreFilterModel(sort: ExploreSortOption.price);
      expect(filter.activeCount, 1);
      const defaultFilter = ExploreFilterModel(sort: ExploreSortOption.popularity);
      expect(defaultFilter.activeCount, 0);
    });
  });

  group('Explore Models Serialization Tests', () {
    test('8. LocalizedItemModel fromJson and toJson', () {
      final json = {'code': 'fac-1', 'nameAr': 'واي فاي', 'nameEn': 'Wifi'};
      final model = LocalizedItemModel.fromJson(json);
      expect(model.code, 'fac-1');
      expect(model.nameAr, 'واي فاي');
      expect(model.nameEn, 'Wifi');
      expect(model.toJson(), json);
    });

    test('9. OpeningWindowModel fromJson and toJson', () {
      final json = {'open': '09:00', 'close': '23:00'};
      final model = OpeningWindowModel.fromJson(json);
      expect(model.open, '09:00');
      expect(model.close, '23:00');
      expect(model.toJson(), json);
    });

    test('10. OpeningHoursDayModel fromJson parses normal hours', () {
      final json = {
        'day': 1,
        'closed': false,
        'windows': [
          {'open': '09:00', 'close': '23:00'}
        ],
      };
      final model = OpeningHoursDayModel.fromJson(json);
      expect(model.day, 1);
      expect(model.closed, isFalse);
      expect(model.windows.length, 1);
      expect(model.windows.first.open, '09:00');
      expect(model.toJson()['day'], 1);
    });

    test('11. OpeningHoursDayModel parses closed day', () {
      final json = {
        'day': 5,
        'closed': true,
        'windows': <dynamic>[],
      };
      final model = OpeningHoursDayModel.fromJson(json);
      expect(model.day, 5);
      expect(model.closed, isTrue);
      expect(model.windows, isEmpty);
    });

    test('12. PublicDepositPolicyModel fromJson and toJson with percentage', () {
      final json = {
        'depositType': 'percentage',
        'depositValue': 25.0,
        'proofSubmissionWindowMinutes': 30,
        'cancellationDeadlineHours': 6,
        'refundEligibility': 'standard',
        'refundPercentage': 100.0,
        'noShowRule': 'forfeit',
        'lateArrivalGraceMinutes': 15,
        'allowReschedule': true,
        'rescheduleDeadlineHours': 4,
        'terms': 'Non-refundable within 6 hours',
      };
      final model = PublicDepositPolicyModel.fromJson(json);
      expect(model.depositType, 'percentage');
      expect(model.depositValue, 25.0);
      expect(model.proofSubmissionWindowMinutes, 30);
      expect(model.cancellationDeadlineHours, 6);
      expect(model.refundEligibility, 'standard');
      expect(model.refundPercentage, 100.0);
      expect(model.noShowRule, 'forfeit');
      expect(model.lateArrivalGraceMinutes, 15);
      expect(model.allowReschedule, isTrue);
      expect(model.rescheduleDeadlineHours, 4);
      expect(model.terms, 'Non-refundable within 6 hours');
      expect(model.toJson()['depositType'], 'percentage');
    });

    test('13. PublicDepositPolicyModel handles null terms', () {
      final json = {
        'depositType': 'fixed',
        'depositValue': 50.0,
        'proofSubmissionWindowMinutes': 20,
        'cancellationDeadlineHours': 12,
        'refundEligibility': 'partial',
        'refundPercentage': 50.0,
        'noShowRule': 'forfeit',
        'lateArrivalGraceMinutes': 10,
        'allowReschedule': false,
        'rescheduleDeadlineHours': 0,
      };
      final model = PublicDepositPolicyModel.fromJson(json);
      expect(model.terms, isNull);
      expect(model.depositType, 'fixed');
      expect(model.allowReschedule, isFalse);
    });

    test('14. SlotModel fromJson parses available slot (state == 0)', () {
      final json = {
        'startUtc': '2026-05-01T18:00:00Z',
        'endUtc': '2026-05-01T19:00:00Z',
        'startLocal': '20:00',
        'endLocal': '21:00',
        'state': 0,
        'price': 200.0,
      };
      final model = SlotModel.fromJson(json);
      expect(model.startUtc, '2026-05-01T18:00:00Z');
      expect(model.endUtc, '2026-05-01T19:00:00Z');
      expect(model.startLocal, '20:00');
      expect(model.endLocal, '21:00');
      expect(model.state, 0);
      expect(model.isAvailable, isTrue);
      expect(model.price, 200.0);
      expect(model.toJson()['state'], 0);
    });

    test('15. SlotModel isAvailable is false when state != 0', () {
      final json = {
        'startUtc': '2026-05-01T18:00:00Z',
        'endUtc': '2026-05-01T19:00:00Z',
        'startLocal': '20:00',
        'endLocal': '21:00',
        'state': 1,
        'price': 200.0,
      };
      final model = SlotModel.fromJson(json);
      expect(model.isAvailable, isFalse);
    });

    test('16. PitchSlotsModel parses list of slots', () {
      final json = {
        'pitchId': 'pitch-101',
        'name': 'Pitch Alpha',
        'slotMinutes': 60,
        'incrementMinutes': 60,
        'slots': [
          {
            'startUtc': '2026-05-01T18:00:00Z',
            'endUtc': '2026-05-01T19:00:00Z',
            'startLocal': '20:00',
            'endLocal': '21:00',
            'state': 0,
            'price': 200.0,
          }
        ],
      };
      final model = PitchSlotsModel.fromJson(json);
      expect(model.pitchId, 'pitch-101');
      expect(model.name, 'Pitch Alpha');
      expect(model.slots.length, 1);
      expect(model.slots.first.isAvailable, isTrue);
      expect(model.toJson()['pitchId'], 'pitch-101');
    });

    test('17. VenueAvailabilityModel fromJson and toJson', () {
      final json = {
        'venueId': 'ven-1',
        'businessDate': '2026-05-01',
        'currency': 'EGP',
        'pitches': [],
        'generatedAtUtc': '2026-05-01T08:00:00Z',
        'nextChangeUtc': '2026-05-01T12:00:00Z',
      };
      final model = VenueAvailabilityModel.fromJson(json);
      expect(model.venueId, 'ven-1');
      expect(model.businessDate, '2026-05-01');
      expect(model.currency, 'EGP');
      expect(model.pitches, isEmpty);
      expect(model.generatedAtUtc, '2026-05-01T08:00:00Z');
      expect(model.nextChangeUtc, '2026-05-01T12:00:00Z');
      expect(model.toJson()['venueId'], 'ven-1');
    });

    test('18. PitchDetailsModel fromJson and toJson', () {
      final json = {
        'pitchId': 'pitch-1',
        'name': 'Main Pitch',
        'pitchType': '5-a-side',
        'playersPerTeam': 5,
        'surface': {'code': 's-1', 'nameAr': 'نجيل', 'nameEn': 'Grass'},
        'lengthMeters': 40.0,
        'widthMeters': 20.0,
        'photos': ['https://example.com/pitch.jpg'],
        'baseHourlyPrice': 300.0,
        'currency': 'EGP',
      };
      final model = PitchDetailsModel.fromJson(json);
      expect(model.pitchId, 'pitch-1');
      expect(model.name, 'Main Pitch');
      expect(model.pitchType, '5-a-side');
      expect(model.playersPerTeam, 5);
      expect(model.surface.nameEn, 'Grass');
      expect(model.lengthMeters, 40.0);
      expect(model.widthMeters, 20.0);
      expect(model.photos, ['https://example.com/pitch.jpg']);
      expect(model.baseHourlyPrice, 300.0);
      expect(model.currency, 'EGP');
      expect(model.toJson()['pitchId'], 'pitch-1');
    });

    test('19. VenueDetailsModel parses complete venue profile', () {
      final json = {
        'venueId': 'ven-123',
        'name': 'Camp Nou Arena',
        'slug': 'camp-nou-arena',
        'description': 'Premium 5-a-side football ground',
        'address': '10 El Tahrir St',
        'city': 'Cairo',
        'area': 'Dokki',
        'latitude': 30.0444,
        'longitude': 31.2357,
        'photos': ['https://example.com/v1.jpg'],
        'facilities': [
          {'code': 'f1', 'nameAr': 'موقف', 'nameEn': 'Parking'}
        ],
        'openingHours': [
          {
            'day': 1,
            'closed': false,
            'windows': [
              {'open': '09:00', 'close': '23:00'}
            ]
          }
        ],
        'fromHourlyPrice': 250.0,
        'currency': 'EGP',
        'depositPolicy': {
          'depositType': 'percentage',
          'depositValue': 20.0,
          'proofSubmissionWindowMinutes': 30,
          'cancellationDeadlineHours': 12,
          'refundEligibility': 'full',
          'refundPercentage': 100.0,
          'noShowRule': 'forfeit',
          'lateArrivalGraceMinutes': 15,
          'allowReschedule': true,
          'rescheduleDeadlineHours': 6,
        },
        'pitchCount': 2,
        'pitchTypes': ['5-a-side'],
        'favoritesCount': 42,
      };

      final model = VenueDetailsModel.fromJson(json);
      expect(model.venueId, 'ven-123');
      expect(model.name, 'Camp Nou Arena');
      expect(model.slug, 'camp-nou-arena');
      expect(model.description, 'Premium 5-a-side football ground');
      expect(model.city, 'Cairo');
      expect(model.area, 'Dokki');
      expect(model.latitude, 30.0444);
      expect(model.longitude, 31.2357);
      expect(model.photos.length, 1);
      expect(model.facilities.first.nameEn, 'Parking');
      expect(model.openingHours.first.windows.first.open, '09:00');
      expect(model.fromHourlyPrice, 250.0);
      expect(model.currency, 'EGP');
      expect(model.depositPolicy?.depositValue, 20.0);
      expect(model.pitchCount, 2);
      expect(model.pitchTypes, ['5-a-side']);
      expect(model.favoritesCount, 42);
      expect(model.toJson()['name'], 'Camp Nou Arena');
    });

    test('20. VenueDetailsModel handles null optional fields gracefully', () {
      final json = {
        'venueId': 'ven-min',
        'name': 'Minimal Venue',
        'slug': 'min-venue',
        'address': 'Street 1',
        'city': 'Giza',
        'area': 'Haram',
      };
      final model = VenueDetailsModel.fromJson(json);
      expect(model.venueId, 'ven-min');
      expect(model.description, isNull);
      expect(model.latitude, isNull);
      expect(model.longitude, isNull);
      expect(model.photos, isEmpty);
      expect(model.facilities, isEmpty);
      expect(model.openingHours, isEmpty);
      expect(model.fromHourlyPrice, isNull);
      expect(model.depositPolicy, isNull);
      expect(model.pitchCount, 0);
      expect(model.pitchTypes, isEmpty);
      expect(model.favoritesCount, 0);
    });

    test('21. ExploreVenueCardModel fromJson and toJson', () {
      final json = {
        'venueId': 'v-card-1',
        'name': 'Al Ahly Club',
        'slug': 'al-ahly',
        'city': 'Cairo',
        'area': 'Gezira',
        'coverPhotoUrl': 'https://example.com/cover.jpg',
        'latitude': 30.05,
        'longitude': 31.22,
        'distanceKm': 2.5,
        'fromHourlyPrice': 200.0,
        'currency': 'EGP',
        'pitchTypes': ['5-a-side', '7-a-side'],
        'surfaces': ['Grass', 'Artificial'],
        'facilities': ['Parking', 'Showers'],
        'favoritesCount': 105,
        'nextAvailableStartUtc': '2026-05-01T17:00:00Z',
        'isFavorite': true,
      };

      final model = ExploreVenueCardModel.fromJson(json);
      expect(model.venueId, 'v-card-1');
      expect(model.name, 'Al Ahly Club');
      expect(model.distanceKm, 2.5);
      expect(model.fromHourlyPrice, 200.0);
      expect(model.isFavorite, isTrue);
      expect(model.favoritesCount, 105);
      expect(model.toJson()['venueId'], 'v-card-1');
    });

    test('22. ExploreResultModel fromJson and toJson', () {
      final json = {
        'items': [
          {
            'venueId': 'v1',
            'name': 'Venue 1',
            'slug': 'v1',
            'city': 'Cairo',
            'area': 'Maadi',
            'isFavorite': false,
          }
        ],
        'page': 1,
        'pageSize': 10,
        'totalCount': 50,
        'hasMore': true,
      };
      final model = ExploreResultModel.fromJson(json);
      expect(model.totalCount, 50);
      expect(model.page, 1);
      expect(model.pageSize, 10);
      expect(model.hasMore, isTrue);
      expect(model.items.length, 1);
      expect(model.items.first.name, 'Venue 1');
      expect(model.toJson()['totalCount'], 50);
    });

    test('23. MapBoundsModel constructor and isSearchable check', () {
      const smallBounds = MapBoundsModel(
        south: 29.9,
        west: 31.1,
        north: 30.1,
        east: 31.3,
      );
      expect(smallBounds.south, 29.9);
      expect(smallBounds.west, 31.1);
      expect(smallBounds.north, 30.1);
      expect(smallBounds.east, 31.3);
      expect(smallBounds.isSearchable, isTrue);

      const hugeBounds = MapBoundsModel(
        south: 20.0,
        west: 25.0,
        north: 32.0,
        east: 35.0,
      );
      expect(hugeBounds.isSearchable, isFalse);
    });

    test('24. MapVenuePinModel fromJson and toJson', () {
      final json = {
        'venueId': 'v-pin-1',
        'name': 'Pin Venue',
        'latitude': 30.01,
        'longitude': 31.21,
        'fromHourlyPrice': 180.0,
        'currency': 'EGP',
        'nextAvailableStartUtc': '2026-05-01T18:00:00Z',
        'isFavorite': true,
      };
      final model = MapVenuePinModel.fromJson(json);
      expect(model.venueId, 'v-pin-1');
      expect(model.name, 'Pin Venue');
      expect(model.latitude, 30.01);
      expect(model.longitude, 31.21);
      expect(model.fromHourlyPrice, 180.0);
      expect(model.isFavorite, isTrue);
      expect(model.toJson()['venueId'], 'v-pin-1');
    });

    test('25. MapSearchResultModel fromJson and toJson', () {
      final json = {
        'pins': [
          {
            'venueId': 'v-pin-1',
            'name': 'Pin Venue',
            'latitude': 30.01,
            'longitude': 31.21,
            'fromHourlyPrice': 180.0,
            'currency': 'EGP',
          }
        ],
        'totalCount': 1,
        'truncated': false,
      };
      final model = MapSearchResultModel.fromJson(json);
      expect(model.pins.length, 1);
      expect(model.totalCount, 1);
      expect(model.truncated, isFalse);
      expect(model.toJson()['totalCount'], 1);
    });
  });

  group('Explore UseCases Delegation Tests', () {
    late MockExploreRepo mockRepo;

    setUp(() {
      mockRepo = MockExploreRepo();
    });

    test('26. GetVenueDetailsUseCase calls getVenueDetails on repo', () async {
      final useCase = GetVenueDetailsUseCase(exploreRepo: mockRepo);
      const details = VenueDetailsModel(
        venueId: 'v-1',
        name: 'V1',
        slug: 'v1',
        address: 'Addr',
        city: 'Cairo',
        area: 'Nasr City',
      );
      when(() => mockRepo.getVenueDetails('v-1')).thenAnswer((_) async => const ApiResult.success(details));

      final res = await useCase('v-1');
      expect(res, isA<Success<VenueDetailsModel>>());
      verify(() => mockRepo.getVenueDetails('v-1')).called(1);
    });

    test('27. GetVenueDetailsUseCase propagates failure from repo', () async {
      final useCase = GetVenueDetailsUseCase(exploreRepo: mockRepo);
      when(() => mockRepo.getVenueDetails('v-err'))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.not_found')));

      final res = await useCase('v-err');
      expect(res, isA<ApiFailure>());
    });

    test('28. GetVenueAvailabilityUseCase calls getVenueAvailability on repo', () async {
      final useCase = GetVenueAvailabilityUseCase(exploreRepo: mockRepo);
      const avail = VenueAvailabilityModel(
        venueId: 'v-1',
        businessDate: '2026-05-01',
        currency: 'EGP',
        generatedAtUtc: '2026-05-01T00:00:00Z',
      );
      when(() => mockRepo.getVenueAvailability('v-1', '2026-05-01'))
          .thenAnswer((_) async => const ApiResult.success(avail));

      final res = await useCase('v-1', '2026-05-01');
      expect(res, isA<Success<VenueAvailabilityModel>>());
      verify(() => mockRepo.getVenueAvailability('v-1', '2026-05-01')).called(1);
    });

    test('29. GetVenueAvailabilityUseCase propagates failure from repo', () async {
      final useCase = GetVenueAvailabilityUseCase(exploreRepo: mockRepo);
      when(() => mockRepo.getVenueAvailability('v-1', '2026-05-01'))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.server')));

      final res = await useCase('v-1', '2026-05-01');
      expect(res, isA<ApiFailure>());
    });

    test('30. GetVenuePitchesUseCase calls getVenuePitches on repo', () async {
      final useCase = GetVenuePitchesUseCase(exploreRepo: mockRepo);
      const pitches = <PitchDetailsModel>[
        PitchDetailsModel(
          pitchId: 'p-1',
          name: 'P1',
          pitchType: '5-a-side',
          playersPerTeam: 5,
          surface: LocalizedItemModel(code: 's', nameAr: 'نجيل', nameEn: 'Grass'),
        ),
      ];
      when(() => mockRepo.getVenuePitches('v-1')).thenAnswer((_) async => const ApiResult.success(pitches));

      final res = await useCase('v-1');
      expect(res, isA<Success<List<PitchDetailsModel>>>());
      verify(() => mockRepo.getVenuePitches('v-1')).called(1);
    });

    test('31. GetVenuePitchesUseCase propagates failure from repo', () async {
      final useCase = GetVenuePitchesUseCase(exploreRepo: mockRepo);
      when(() => mockRepo.getVenuePitches('v-1'))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.timeout')));

      final res = await useCase('v-1');
      expect(res, isA<ApiFailure>());
    });

    test('32. ExploreVenuesUseCase passes near, city, area, and filter to repo', () async {
      final useCase = ExploreVenuesUseCase(exploreRepo: mockRepo);
      const resultModel = ExploreResultModel(items: [], totalCount: 0, page: 1, pageSize: 10, hasMore: false);
      const geo = GeoPoint(latitude: 30.0, longitude: 31.0);
      const filter = ExploreFilterModel(maxPrice: 200);

      when(() => mockRepo.exploreVenues(
            near: geo,
            city: 'Cairo',
            area: 'Zamalek',
            filter: filter,
            page: 1,
            pageSize: 20,
          )).thenAnswer((_) async => const ApiResult.success(resultModel));

      final res = await useCase(
        near: geo,
        city: 'Cairo',
        area: 'Zamalek',
        filter: filter,
        page: 1,
        pageSize: 20,
      );

      expect(res, isA<Success<ExploreResultModel>>());
      verify(() => mockRepo.exploreVenues(
            near: geo,
            city: 'Cairo',
            area: 'Zamalek',
            filter: filter,
            page: 1,
            pageSize: 20,
          )).called(1);
    });

    test('33. ExploreVenuesUseCase propagates network failure', () async {
      final useCase = ExploreVenuesUseCase(exploreRepo: mockRepo);
      when(() => mockRepo.exploreVenues(filter: any(named: 'filter')))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.network')));

      final res = await useCase();
      expect(res, isA<ApiFailure>());
    });
  });

  group('VenueProfileCubit Comprehensive Tests', () {
    late MockExploreRepo mockRepo;
    late GetVenueDetailsUseCase getDetailsUseCase;
    late GetVenuePitchesUseCase getPitchesUseCase;

    const mockVenue = VenueDetailsModel(
      venueId: 'venue-101',
      name: 'Wembley',
      slug: 'wembley',
      address: 'Olympic Way',
      city: 'Cairo',
      area: 'Heliopolis',
    );

    const mockPitches = [
      PitchDetailsModel(
        pitchId: 'p-101',
        name: 'Pitch 1',
        pitchType: '5-a-side',
        playersPerTeam: 5,
        surface: LocalizedItemModel(code: 's-1', nameAr: 'ترتان', nameEn: 'Turf'),
      ),
    ];

    setUp(() {
      mockRepo = MockExploreRepo();
      getDetailsUseCase = GetVenueDetailsUseCase(exploreRepo: mockRepo);
      getPitchesUseCase = GetVenuePitchesUseCase(exploreRepo: mockRepo);
    });

    test('34. Initial state is VenueProfileState.initial()', () {
      final cubit = VenueProfileCubit(
        getVenueDetailsUseCase: getDetailsUseCase,
        getVenuePitchesUseCase: getPitchesUseCase,
        exploreRepo: mockRepo,
      );
      expect(cubit.state, const VenueProfileState.initial());
      cubit.close();
    });

    test('35. Emits [loading, success] with favorite true when venueId in getFavorites', () async {
      final cubit = VenueProfileCubit(
        getVenueDetailsUseCase: getDetailsUseCase,
        getVenuePitchesUseCase: getPitchesUseCase,
        exploreRepo: mockRepo,
      );

      when(() => mockRepo.getVenueDetails('venue-101')).thenAnswer((_) async => const ApiResult.success(mockVenue));
      when(() => mockRepo.getVenuePitches('venue-101')).thenAnswer((_) async => const ApiResult.success(mockPitches));
      when(() => mockRepo.getFavorites()).thenAnswer((_) async => const ApiResult.success([
            ExploreVenueCardModel(
              venueId: 'venue-101',
              name: 'Wembley',
              slug: 'wembley',
              city: 'Cairo',
              area: 'Heliopolis',
            )
          ]));
      when(() => mockRepo.recordView('venue-101')).thenAnswer((_) async => const ApiResult.success(null));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const VenueProfileState.loading(),
          const VenueProfileState.success(
            venue: mockVenue,
            pitches: mockPitches,
            isFavorite: true,
          ),
        ]),
      );

      await cubit.loadVenue('venue-101');
      verify(() => mockRepo.recordView('venue-101')).called(1);
      cubit.close();
    });

    test('36. Emits [loading, success] with favorite false when venueId not in favorites', () async {
      final cubit = VenueProfileCubit(
        getVenueDetailsUseCase: getDetailsUseCase,
        getVenuePitchesUseCase: getPitchesUseCase,
        exploreRepo: mockRepo,
      );

      when(() => mockRepo.getVenueDetails('venue-101')).thenAnswer((_) async => const ApiResult.success(mockVenue));
      when(() => mockRepo.getVenuePitches('venue-101')).thenAnswer((_) async => const ApiResult.success(mockPitches));
      when(() => mockRepo.getFavorites()).thenAnswer((_) async => const ApiResult.success([]));
      when(() => mockRepo.recordView('venue-101')).thenAnswer((_) async => const ApiResult.success(null));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const VenueProfileState.loading(),
          const VenueProfileState.success(
            venue: mockVenue,
            pitches: mockPitches,
            isFavorite: false,
          ),
        ]),
      );

      await cubit.loadVenue('venue-101');
      cubit.close();
    });

    test('37. Tolerates getVenuePitches failure and defaults to empty pitches list', () async {
      final cubit = VenueProfileCubit(
        getVenueDetailsUseCase: getDetailsUseCase,
        getVenuePitchesUseCase: getPitchesUseCase,
        exploreRepo: mockRepo,
      );

      when(() => mockRepo.getVenueDetails('venue-101')).thenAnswer((_) async => const ApiResult.success(mockVenue));
      when(() => mockRepo.getVenuePitches('venue-101'))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.pitches_failed')));
      when(() => mockRepo.getFavorites()).thenAnswer((_) async => const ApiResult.success([]));
      when(() => mockRepo.recordView('venue-101')).thenAnswer((_) async => const ApiResult.success(null));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const VenueProfileState.loading(),
          const VenueProfileState.success(
            venue: mockVenue,
            pitches: [],
            isFavorite: false,
          ),
        ]),
      );

      await cubit.loadVenue('venue-101');
      cubit.close();
    });

    test('38. Tolerates getFavorites failure and defaults isFavorite to false', () async {
      final cubit = VenueProfileCubit(
        getVenueDetailsUseCase: getDetailsUseCase,
        getVenuePitchesUseCase: getPitchesUseCase,
        exploreRepo: mockRepo,
      );

      when(() => mockRepo.getVenueDetails('venue-101')).thenAnswer((_) async => const ApiResult.success(mockVenue));
      when(() => mockRepo.getVenuePitches('venue-101')).thenAnswer((_) async => const ApiResult.success(mockPitches));
      when(() => mockRepo.getFavorites())
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'auth.unauthorized')));
      when(() => mockRepo.recordView('venue-101')).thenAnswer((_) async => const ApiResult.success(null));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const VenueProfileState.loading(),
          const VenueProfileState.success(
            venue: mockVenue,
            pitches: mockPitches,
            isFavorite: false,
          ),
        ]),
      );

      await cubit.loadVenue('venue-101');
      cubit.close();
    });

    test('39. Emits [loading, error] when getVenueDetails fails', () async {
      final cubit = VenueProfileCubit(
        getVenueDetailsUseCase: getDetailsUseCase,
        getVenuePitchesUseCase: getPitchesUseCase,
        exploreRepo: mockRepo,
      );

      when(() => mockRepo.getVenueDetails('venue-404'))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.venue_not_found')));
      when(() => mockRepo.getVenuePitches('venue-404')).thenAnswer((_) async => const ApiResult.success([]));
      when(() => mockRepo.getFavorites()).thenAnswer((_) async => const ApiResult.success([]));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const VenueProfileState.loading(),
          const VenueProfileState.error('errors.venue_not_found'),
        ]),
      );

      await cubit.loadVenue('venue-404');
      verifyNever(() => mockRepo.recordView(any()));
      cubit.close();
    });

    test('40. Does not emit loading on subsequent refresh when state is already success', () async {
      final cubit = VenueProfileCubit(
        getVenueDetailsUseCase: getDetailsUseCase,
        getVenuePitchesUseCase: getPitchesUseCase,
        exploreRepo: mockRepo,
      );

      when(() => mockRepo.getVenueDetails('venue-101')).thenAnswer((_) async => const ApiResult.success(mockVenue));
      when(() => mockRepo.getVenuePitches('venue-101')).thenAnswer((_) async => const ApiResult.success(mockPitches));
      when(() => mockRepo.getFavorites()).thenAnswer((_) async => const ApiResult.success([]));
      when(() => mockRepo.recordView('venue-101')).thenAnswer((_) async => const ApiResult.success(null));

      await cubit.loadVenue('venue-101');
      expect(cubit.state, isA<VenueProfileSuccess>());

      final emittedStates = <VenueProfileState>[];
      final sub = cubit.stream.listen(emittedStates.add);

      await cubit.loadVenue('venue-101');
      expect(emittedStates.whereType<VenueProfileLoading>(), isEmpty);
      await sub.cancel();
      cubit.close();
    });
  });

  group('PitchBookingCubit Comprehensive Tests', () {
    late MockExploreRepo mockExploreRepo;
    late MockBookingRepo mockBookingRepo;
    late GetVenueAvailabilityUseCase getAvailabilityUseCase;
    late GetBookingQuoteUseCase getQuoteUseCase;
    late CreateBookingUseCase createBookingUseCase;

    const availableSlot = SlotModel(
      startUtc: '2026-05-01T18:00:00Z',
      endUtc: '2026-05-01T19:00:00Z',
      startLocal: '20:00',
      endLocal: '21:00',
      state: 0,
      price: 250.0,
    );

    const bookedSlot = SlotModel(
      startUtc: '2026-05-01T19:00:00Z',
      endUtc: '2026-05-01T20:00:00Z',
      startLocal: '21:00',
      endLocal: '22:00',
      state: 1,
      price: 250.0,
    );

    const testPitchSlots = PitchSlotsModel(
      pitchId: 'pitch-1',
      name: 'Pitch A',
      slotMinutes: 60,
      incrementMinutes: 60,
      slots: [availableSlot, bookedSlot],
    );

    const testAvailability = VenueAvailabilityModel(
      venueId: 'v-1',
      businessDate: '2026-05-01',
      currency: 'EGP',
      generatedAtUtc: '2026-05-01T10:00:00Z',
      pitches: [testPitchSlots],
    );

    const testQuote = BookingQuoteResponseModel(
      quoteToken: 'tok-abc',
      expiresAtUtc: '2026-05-01T11:00:00Z',
      currency: 'EGP',
      subtotal: 250.0,
      discount: 0.0,
      fees: 0.0,
      total: 250.0,
      deposit: 50.0,
      remainingBalance: 200.0,
      subjectToConfirmation: false,
      confirmationNote: '',
    );

    setUp(() {
      mockExploreRepo = MockExploreRepo();
      mockBookingRepo = MockBookingRepo();
      getAvailabilityUseCase = GetVenueAvailabilityUseCase(exploreRepo: mockExploreRepo);
      getQuoteUseCase = GetBookingQuoteUseCase(bookingRepo: mockBookingRepo);
      createBookingUseCase = CreateBookingUseCase(bookingRepo: mockBookingRepo);
    });

    test('41. Initial state is PitchBookingInitial', () {
      final cubit = PitchBookingCubit(
        getVenueAvailabilityUseCase: getAvailabilityUseCase,
        getBookingQuoteUseCase: getQuoteUseCase,
        createBookingUseCase: createBookingUseCase,
      );
      expect(cubit.state, const PitchBookingInitial());
      cubit.close();
    });

    test('42. loadAvailability selects first available slot and quotes it', () async {
      final cubit = PitchBookingCubit(
        getVenueAvailabilityUseCase: getAvailabilityUseCase,
        getBookingQuoteUseCase: getQuoteUseCase,
        createBookingUseCase: createBookingUseCase,
      );

      when(() => mockExploreRepo.getVenueAvailability(any(), any()))
          .thenAnswer((_) async => const ApiResult.success(testAvailability));
      when(() => mockBookingRepo.getQuote(any()))
          .thenAnswer((_) async => const ApiResult.success(testQuote));

      await cubit.loadAvailability('v-1');

      expect(cubit.state, isA<PitchBookingLoaded>());
      final loaded = cubit.state as PitchBookingLoaded;
      expect(loaded.selectedPitchIndex, 0);
      expect(loaded.selectedSlot?.startLocal, '20:00');
      expect(loaded.quote?.quoteToken, 'tok-abc');
      cubit.close();
    });

    test('43. loadAvailability handles empty pitches list without throwing', () async {
      final cubit = PitchBookingCubit(
        getVenueAvailabilityUseCase: getAvailabilityUseCase,
        getBookingQuoteUseCase: getQuoteUseCase,
        createBookingUseCase: createBookingUseCase,
      );

      const emptyAvail = VenueAvailabilityModel(
        venueId: 'v-1',
        businessDate: '2026-05-01',
        currency: 'EGP',
        generatedAtUtc: '2026-05-01T10:00:00Z',
        pitches: [],
      );

      when(() => mockExploreRepo.getVenueAvailability(any(), any()))
          .thenAnswer((_) async => const ApiResult.success(emptyAvail));

      await cubit.loadAvailability('v-1');

      expect(cubit.state, isA<PitchBookingLoaded>());
      final loaded = cubit.state as PitchBookingLoaded;
      expect(loaded.selectedSlot, isNull);
      expect(loaded.quote, isNull);
      cubit.close();
    });

    test('44. loadAvailability emits PitchBookingError on failure', () async {
      final cubit = PitchBookingCubit(
        getVenueAvailabilityUseCase: getAvailabilityUseCase,
        getBookingQuoteUseCase: getQuoteUseCase,
        createBookingUseCase: createBookingUseCase,
      );

      when(() => mockExploreRepo.getVenueAvailability(any(), any()))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.unavailable')));

      await cubit.loadAvailability('v-1');

      expect(cubit.state, isA<PitchBookingError>());
      expect((cubit.state as PitchBookingError).message, 'errors.unavailable');
      cubit.close();
    });

    test('45. selectSlot changes selected slot and requests new quote', () async {
      final cubit = PitchBookingCubit(
        getVenueAvailabilityUseCase: getAvailabilityUseCase,
        getBookingQuoteUseCase: getQuoteUseCase,
        createBookingUseCase: createBookingUseCase,
      );

      when(() => mockExploreRepo.getVenueAvailability(any(), any()))
          .thenAnswer((_) async => const ApiResult.success(testAvailability));
      when(() => mockBookingRepo.getQuote(any()))
          .thenAnswer((_) async => const ApiResult.success(testQuote));

      await cubit.loadAvailability('v-1');

      const anotherSlot = SlotModel(
        startUtc: '2026-05-01T21:00:00Z',
        endUtc: '2026-05-01T22:00:00Z',
        startLocal: '23:00',
        endLocal: '00:00',
        state: 0,
        price: 300.0,
      );

      await cubit.selectSlot(anotherSlot);

      final loaded = cubit.state as PitchBookingLoaded;
      expect(loaded.selectedSlot?.startLocal, '23:00');
      verify(() => mockBookingRepo.getQuote(any())).called(2);
      cubit.close();
    });

    test('46. fetchQuoteForSlot handles quote error gracefully', () async {
      final cubit = PitchBookingCubit(
        getVenueAvailabilityUseCase: getAvailabilityUseCase,
        getBookingQuoteUseCase: getQuoteUseCase,
        createBookingUseCase: createBookingUseCase,
      );

      when(() => mockExploreRepo.getVenueAvailability(any(), any()))
          .thenAnswer((_) async => const ApiResult.success(testAvailability));
      when(() => mockBookingRepo.getQuote(any()))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.quote_expired')));

      await cubit.loadAvailability('v-1');

      final loaded = cubit.state as PitchBookingLoaded;
      expect(loaded.isQuoting, isFalse);
      expect(loaded.quote, isNull);
      expect(loaded.quoteError, 'errors.quote_expired');
      cubit.close();
    });

    test('47. toggleSlotFilter toggles between all and booked/available', () async {
      final cubit = PitchBookingCubit(
        getVenueAvailabilityUseCase: getAvailabilityUseCase,
        getBookingQuoteUseCase: getQuoteUseCase,
        createBookingUseCase: createBookingUseCase,
      );

      when(() => mockExploreRepo.getVenueAvailability(any(), any()))
          .thenAnswer((_) async => const ApiResult.success(testAvailability));
      when(() => mockBookingRepo.getQuote(any()))
          .thenAnswer((_) async => const ApiResult.success(testQuote));

      await cubit.loadAvailability('v-1');
      var loaded = cubit.state as PitchBookingLoaded;
      expect(loaded.slotFilter, PitchSlotFilter.all);

      cubit.toggleSlotFilter(PitchSlotFilter.available);
      loaded = cubit.state as PitchBookingLoaded;
      expect(loaded.slotFilter, PitchSlotFilter.available);

      // Tapping available again reverts to all
      cubit.toggleSlotFilter(PitchSlotFilter.available);
      loaded = cubit.state as PitchBookingLoaded;
      expect(loaded.slotFilter, PitchSlotFilter.all);

      cubit.close();
    });

    test('48. selectPitch ignores out of bounds index', () async {
      final cubit = PitchBookingCubit(
        getVenueAvailabilityUseCase: getAvailabilityUseCase,
        getBookingQuoteUseCase: getQuoteUseCase,
        createBookingUseCase: createBookingUseCase,
      );

      when(() => mockExploreRepo.getVenueAvailability(any(), any()))
          .thenAnswer((_) async => const ApiResult.success(testAvailability));
      when(() => mockBookingRepo.getQuote(any()))
          .thenAnswer((_) async => const ApiResult.success(testQuote));

      await cubit.loadAvailability('v-1');
      await cubit.selectPitch(999);

      final loaded = cubit.state as PitchBookingLoaded;
      expect(loaded.selectedPitchIndex, 0);
      cubit.close();
    });

    test('49. selectDay reloads availability for new day index', () async {
      final cubit = PitchBookingCubit(
        getVenueAvailabilityUseCase: getAvailabilityUseCase,
        getBookingQuoteUseCase: getQuoteUseCase,
        createBookingUseCase: createBookingUseCase,
      );

      when(() => mockExploreRepo.getVenueAvailability(any(), any()))
          .thenAnswer((_) async => const ApiResult.success(testAvailability));
      when(() => mockBookingRepo.getQuote(any()))
          .thenAnswer((_) async => const ApiResult.success(testQuote));

      await cubit.loadAvailability('v-1');
      await cubit.selectDay(2);

      final loaded = cubit.state as PitchBookingLoaded;
      expect(loaded.selectedDayIndex, 2);
      verify(() => mockExploreRepo.getVenueAvailability('v-1', any())).called(2);
      cubit.close();
    });

    test('50. selectDay returns early when venueId is null and cubit uninitialized', () async {
      final cubit = PitchBookingCubit(
        getVenueAvailabilityUseCase: getAvailabilityUseCase,
        getBookingQuoteUseCase: getQuoteUseCase,
        createBookingUseCase: createBookingUseCase,
      );

      await cubit.selectDay(1);
      expect(cubit.state, const PitchBookingInitial());
      cubit.close();
    });

    test('51. selectSlot does nothing when state is not PitchBookingLoaded', () async {
      final cubit = PitchBookingCubit(
        getVenueAvailabilityUseCase: getAvailabilityUseCase,
        getBookingQuoteUseCase: getQuoteUseCase,
        createBookingUseCase: createBookingUseCase,
      );

      await cubit.selectSlot(availableSlot);
      expect(cubit.state, const PitchBookingInitial());
      cubit.close();
    });

    test('52. toggleSlotFilter does nothing when state is not PitchBookingLoaded', () {
      final cubit = PitchBookingCubit(
        getVenueAvailabilityUseCase: getAvailabilityUseCase,
        getBookingQuoteUseCase: getQuoteUseCase,
        createBookingUseCase: createBookingUseCase,
      );

      cubit.toggleSlotFilter(PitchSlotFilter.booked);
      expect(cubit.state, const PitchBookingInitial());
      cubit.close();
    });

    test('53. selectDay propagates error when second availability call fails', () async {
      final cubit = PitchBookingCubit(
        getVenueAvailabilityUseCase: getAvailabilityUseCase,
        getBookingQuoteUseCase: getQuoteUseCase,
        createBookingUseCase: createBookingUseCase,
      );

      var count = 0;
      when(() => mockExploreRepo.getVenueAvailability(any(), any())).thenAnswer((_) async {
        count++;
        if (count == 1) return const ApiResult.success(testAvailability);
        return const ApiResult.failure(AppApiFailure(message: 'errors.network_failure'));
      });
      when(() => mockBookingRepo.getQuote(any()))
          .thenAnswer((_) async => const ApiResult.success(testQuote));

      await cubit.loadAvailability('v-1');
      await cubit.selectDay(1);

      final loaded = cubit.state as PitchBookingLoaded;
      expect(loaded.bookingError, 'errors.network_failure');
      expect(loaded.isSlotsLoading, isFalse);
      cubit.close();
    });
  });

  group('Explore Extra Model Equality & Edge Case Tests', () {
    test('54. ExploreVenueCardModel distance display', () {
      const cardWithDist = ExploreVenueCardModel(
        venueId: 'v1',
        name: 'V1',
        slug: 'v1',
        city: 'C',
        area: 'A',
        distanceKm: 3.456,
      );
      expect(cardWithDist.distanceKm, 3.456);
    });

    test('55. ExploreVenueCardModel default values when omitted in constructor', () {
      const card = ExploreVenueCardModel(
        venueId: 'v-def',
        name: 'Def',
        slug: 'def',
        city: 'Cairo',
        area: 'Maadi',
      );
      expect(card.coverPhotoUrl, isNull);
      expect(card.latitude, isNull);
      expect(card.longitude, isNull);
      expect(card.distanceKm, isNull);
      expect(card.fromHourlyPrice, isNull);
      expect(card.currency, 'EGP');
      expect(card.pitchTypes, isEmpty);
      expect(card.surfaces, isEmpty);
      expect(card.facilities, isEmpty);
      expect(card.favoritesCount, 0);
      expect(card.nextAvailableStartUtc, isNull);
      expect(card.isFavorite, isFalse);
    });

    test('56. VenueDetailsModel pitchCount reflects pitch types count when zero', () {
      const venue = VenueDetailsModel(
        venueId: 'v-0',
        name: 'V0',
        slug: 'v0',
        address: 'A',
        city: 'C',
        area: 'Ar',
        pitchCount: 0,
      );
      expect(venue.pitchCount, 0);
      expect(venue.facilities, isEmpty);
    });

    test('57. PitchDetailsModel customHours list serialization', () {
      const hours = [
        OpeningHoursDayModel(day: 1, closed: false, windows: [OpeningWindowModel(open: '10:00', close: '22:00')]),
      ];
      const pitch = PitchDetailsModel(
        pitchId: 'p-custom',
        name: 'Custom Pitch',
        pitchType: '7-a-side',
        playersPerTeam: 7,
        surface: LocalizedItemModel(code: 's', nameAr: 'نجيل', nameEn: 'Grass'),
        customHours: hours,
      );
      expect(pitch.customHours?.first.day, 1);
      final json = pitch.toJson();
      expect(json['customHours'], isNotNull);
    });

    test('58. PitchBookingLoaded copyWith clears selectedSlot and quote on demand', () {
      const loaded = PitchBookingLoaded(
        availability: VenueAvailabilityModel(
          venueId: 'v-1',
          businessDate: '2026-05-01',
          currency: 'EGP',
          generatedAtUtc: '2026-05-01',
        ),
        selectedPitchIndex: 0,
        selectedDayIndex: 0,
        selectedSlot: SlotModel(startUtc: '', endUtc: '', startLocal: '', endLocal: '', state: 0),
        quote: BookingQuoteResponseModel(
          quoteToken: 'q',
          expiresAtUtc: '',
          currency: 'EGP',
          subtotal: 100,
          discount: 0,
          fees: 0,
          total: 100,
          deposit: 20,
          remainingBalance: 80,
          subjectToConfirmation: false,
          confirmationNote: '',
        ),
      );

      final cleared = loaded.copyWith(clearSelectedSlot: true, clearQuote: true);
      expect(cleared.selectedSlot, isNull);
      expect(cleared.quote, isNull);
    });

    test('59. PitchBookingLoaded currentPitch returns null when pitches empty', () {
      const loaded = PitchBookingLoaded(
        availability: VenueAvailabilityModel(
          venueId: 'v-1',
          businessDate: '2026-05-01',
          currency: 'EGP',
          generatedAtUtc: '2026-05-01',
          pitches: [],
        ),
        selectedPitchIndex: 0,
        selectedDayIndex: 0,
      );
      expect(loaded.currentPitch, isNull);
    });

    test('60. PitchBookingLoaded currentPitch returns pitch at selectedPitchIndex', () {
      const loaded = PitchBookingLoaded(
        availability: VenueAvailabilityModel(
          venueId: 'v-1',
          businessDate: '2026-05-01',
          currency: 'EGP',
          generatedAtUtc: '2026-05-01',
          pitches: [
            PitchSlotsModel(pitchId: 'p0', name: 'P0', slotMinutes: 60, incrementMinutes: 60),
            PitchSlotsModel(pitchId: 'p1', name: 'P1', slotMinutes: 60, incrementMinutes: 60),
          ],
        ),
        selectedPitchIndex: 1,
        selectedDayIndex: 0,
      );
      expect(loaded.currentPitch?.pitchId, 'p1');
    });

    test('61. MapVenuePinModel nextAvailableStartUtc can be null', () {
      final json = {
        'venueId': 'pin-no-img',
        'name': 'Pin No Image',
        'latitude': 30.0,
        'longitude': 31.0,
      };
      final pin = MapVenuePinModel.fromJson(json);
      expect(pin.nextAvailableStartUtc, isNull);
      expect(pin.fromHourlyPrice, isNull);
      expect(pin.isFavorite, isFalse);
    });

    test('62. MapSearchResultModel defaults truncated to false and pins to empty list', () {
      final json = {'pins': <dynamic>[], 'totalCount': 0, 'truncated': false};
      final res = MapSearchResultModel.fromJson(json);
      expect(res.pins, isEmpty);
      expect(res.totalCount, 0);
      expect(res.truncated, isFalse);
    });

    test('63. PublicDepositPolicyModel noShowRule and refundEligibility values', () {
      final json = {
        'depositType': 'none',
        'depositValue': 0.0,
        'proofSubmissionWindowMinutes': 0,
        'cancellationDeadlineHours': 0,
        'refundEligibility': 'none',
        'refundPercentage': 0.0,
        'noShowRule': 'none',
        'lateArrivalGraceMinutes': 0,
        'allowReschedule': false,
        'rescheduleDeadlineHours': 0,
      };
      final policy = PublicDepositPolicyModel.fromJson(json);
      expect(policy.terms, isNull);
      expect(policy.depositValue, 0.0);
      expect(policy.refundPercentage, 0.0);
      expect(policy.noShowRule, 'none');
    });

    test('64. ExploreFilterModel copyWith pitchType', () {
      const filter = ExploreFilterModel();
      final updated = filter.copyWith(pitchType: () => '11-a-side');
      expect(updated.pitchType, '11-a-side');
    });

    test('65. ExploreFilterModel copyWith surface', () {
      const filter = ExploreFilterModel();
      final updated = filter.copyWith(surface: () => 'tartan');
      expect(updated.surface, 'tartan');
    });

    test('66. ExploreFilterModel copyWith facilities', () {
      const filter = ExploreFilterModel();
      final updated = filter.copyWith(facilities: {'f1', 'f2'});
      expect(updated.facilities, {'f1', 'f2'});
    });

    test('67. ExploreFilterModel copyWith maxPrice', () {
      const filter = ExploreFilterModel();
      final updated = filter.copyWith(maxPrice: () => 300);
      expect(updated.maxPrice, 300);
    });

    test('68. ExploreFilterModel copyWith day', () {
      const filter = ExploreFilterModel();
      final date = DateTime(2026, 12, 31);
      final updated = filter.copyWith(day: () => date);
      expect(updated.day, date);
    });

    test('69. ExploreFilterModel copyWith startHour', () {
      const filter = ExploreFilterModel();
      final updated = filter.copyWith(startHour: () => 22);
      expect(updated.startHour, 22);
    });

    test('70. PitchSlotFilter enum contains all four states', () {
      expect(PitchSlotFilter.values, contains(PitchSlotFilter.all));
      expect(PitchSlotFilter.values, contains(PitchSlotFilter.selected));
      expect(PitchSlotFilter.values, contains(PitchSlotFilter.available));
      expect(PitchSlotFilter.values, contains(PitchSlotFilter.booked));
    });
  });
}
