import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/reference/data/models/filter_options_model.dart';
import 'package:mal3abk/features/reference/domain/repos/reference_repo.dart';
import 'package:mal3abk/features/venue_setup/data/models/venue_setup_form.dart';
import 'package:mal3abk/features/venue_setup/data/repos/venue_setup_repo_impl.dart';
import 'package:mal3abk/features/venue_setup/domain/repos/venue_setup_repo.dart';
import 'package:mal3abk/features/venue_setup/presentation/cubit/venue_setup_cubit.dart';
import 'package:mal3abk/features/venue_shell/data/models/venue_model.dart';
import 'package:mocktail/mocktail.dart';

class MockVenueSetupRepo extends Mock implements VenueSetupRepo {}

class MockReferenceRepo extends Mock implements ReferenceRepo {}

class FakeForm extends Fake implements VenueSetupForm {}

const notFound = AppApiFailure(message: 'errors.not_found');

VenueSetupForm form({double? lat = 30.04, double? lng = 31.23}) =>
    VenueSetupForm(
      name: 'Al Nasr',
      city: 'القاهرة',
      area: 'مدينة نصر',
      phoneNumber: '01012345678',
      address: 'Street 1',
      description: '',
      facilities: const ['parking'],
      latitude: lat,
      longitude: lng,
    );

void main() {
  setUpAll(() => registerFallbackValue(FakeForm()));

  group('VenueSetupForm', () {
    test('reads coordinates from links and plain numbers', () {
      expect(
        VenueSetupForm.parseCoordinates(
          'https://www.google.com/maps/place/x/@30.0444,31.2357,17z',
        ),
        (30.0444, 31.2357),
      );
      expect(
        VenueSetupForm.parseCoordinates('https://maps.google.com/?q=30.1,31.2'),
        (30.1, 31.2),
      );
      expect(VenueSetupForm.parseCoordinates('30.5, 31.5'), (30.5, 31.5));
      expect(
        VenueSetupForm.parseCoordinates('https://maps.app.goo.gl/x'),
        isNull,
      );
    });

    test('needs a location inside Egypt', () {
      expect(form().isValid, isTrue);
      expect(form(lat: null).isValid, isFalse);
      expect(form(lat: 51.5, lng: -0.12).isValid, isFalse);
    });
  });

  test('media id comes from uploaded photo paths only', () {
    expect(VenueSetupRepoImpl.mediaIdOf('/api/v1/media/abc/medium'), 'abc');
    expect(
      VenueSetupRepoImpl.mediaIdOf('https://cdn.example.com/x.jpg'),
      isNull,
    );
  });

  group('VenueSetupCubit', () {
    late MockVenueSetupRepo repo;
    late MockReferenceRepo reference;

    setUp(() {
      repo = MockVenueSetupRepo();
      reference = MockReferenceRepo();
      when(
        () => reference.getGovernorates(),
      ).thenAnswer((_) async => const ApiResult.success([]));
      when(() => reference.getFilterOptions()).thenAnswer(
        (_) async => const ApiResult.success(
          FilterOptionsModel(pitchTypes: [], surfaces: [], facilities: []),
        ),
      );
      when(
        () => repo.getPitches(any()),
      ).thenAnswer((_) async => const ApiResult.success([]));
      when(
        () => repo.getSchedules(any()),
      ).thenAnswer((_) async => const ApiResult.success([]));
    });

    test(
      'the first save creates the venue and opens the pitches step',
      () async {
        const created = VenueModel(
          id: 'v1',
          name: 'Al Nasr',
          address: 'Street 1',
          city: 'القاهرة',
          area: 'مدينة نصر',
          phoneNumber: '01012345678',
          approvalStatus: 'Draft',
          isApproved: false,
          isPublished: false,
        );
        when(
          () => repo.saveVenue(any(), any()),
        ).thenAnswer((_) async => const ApiResult.success(created));
        when(
          () => repo.getApproval('v1'),
        ).thenAnswer((_) async => const ApiResult.failure(notFound));
        final cubit = VenueSetupCubit(
          venueSetupRepo: repo,
          referenceRepo: reference,
        );
        await cubit.init();
        expect(cubit.state.step, 1);
        cubit.goTo(2);
        expect(cubit.state.step, 1, reason: 'no venue yet');

        await cubit.saveVenue(form());
        expect(cubit.venueId, 'v1');
        expect(cubit.state.step, 2);
        await cubit.close();
      },
    );

    test('saves the week with only open days', () async {
      Map<int, DayHours>? sentWeek;
      when(() => repo.saveSchedules('v1', any())).thenAnswer((inv) async {
        sentWeek = inv.positionalArguments[1] as Map<int, DayHours>;
        return const ApiResult.success(null);
      });
      when(
        () => repo.getApproval('v1'),
      ).thenAnswer((_) async => const ApiResult.failure(notFound));
      const venue = VenueModel(
        id: 'v1',
        name: 'n',
        address: 'a',
        city: 'c',
        area: 'ar',
        phoneNumber: '0',
        approvalStatus: 'Draft',
        isApproved: false,
        isPublished: false,
      );
      final cubit = VenueSetupCubit(
        venueSetupRepo: repo,
        referenceRepo: reference,
        venue: venue,
      );
      cubit.setDay(5, const DayHours(on: false, open: '14:00', close: '02:00'));
      await cubit.saveSchedules();
      expect(sentWeek?[5]?.on, isFalse);
      expect(cubit.state.step, 4);
      await cubit.close();
    });
  });
}
