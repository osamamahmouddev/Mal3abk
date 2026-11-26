import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/core/utils/cairo_time.dart';
import 'package:mal3abk/features/notifications/data/apis/notifications_api_service.dart';
import 'package:mal3abk/features/notifications/data/models/notification_model.dart';
import 'package:mal3abk/features/notifications/data/models/notification_page_model.dart';
import 'package:mal3abk/features/reference/data/models/filter_options_model.dart';
import 'package:mal3abk/features/reference/domain/repos/reference_repo.dart';
import 'package:mal3abk/features/venue_account/domain/repos/venue_account_repo.dart';
import 'package:mal3abk/features/venue_account/presentation/cubit/venue_account_cubit.dart';
import 'package:mal3abk/features/venue_bookings/data/models/venue_booking_detail_model.dart';
import 'package:mal3abk/features/venue_bookings/data/models/venue_booking_item_model.dart';
import 'package:mal3abk/features/venue_bookings/data/models/venue_bookings_query.dart';
import 'package:mal3abk/features/venue_bookings/domain/repos/venue_bookings_repo.dart';
import 'package:mal3abk/features/venue_bookings/presentation/cubit/venue_booking_detail_cubit.dart';
import 'package:mal3abk/features/venue_bookings/presentation/cubit/venue_booking_detail_state.dart';
import 'package:mal3abk/features/venue_bookings/presentation/cubit/venue_bookings_cubit.dart';
import 'package:mal3abk/features/venue_bookings/presentation/widgets/venue_bookings_csv.dart';
import 'package:mal3abk/features/venue_calendar/data/models/venue_customer_model.dart';
import 'package:mal3abk/features/venue_customers/data/models/venue_customer_detail_model.dart';
import 'package:mal3abk/features/venue_customers/domain/repos/venue_customers_repo.dart';
import 'package:mal3abk/features/venue_customers/presentation/cubit/venue_customers_cubit.dart';
import 'package:mal3abk/features/venue_notifications/presentation/cubit/venue_notifications_cubit.dart';
import 'package:mal3abk/features/venue_overview/data/models/venue_approval_model.dart';
import 'package:mal3abk/features/venue_overview/data/models/venue_dashboard_model.dart';
import 'package:mal3abk/features/venue_overview/domain/repos/venue_overview_repo.dart';
import 'package:mal3abk/features/venue_overview/presentation/cubit/venue_overview_cubit.dart';
import 'package:mal3abk/features/venue_overview/presentation/cubit/venue_overview_state.dart';
import 'package:mal3abk/features/venue_pitches/presentation/cubit/venue_pitches_cubit.dart';
import 'package:mal3abk/features/venue_policies/data/models/booking_policy_model.dart';
import 'package:mal3abk/features/venue_policies/domain/repos/venue_policies_repo.dart';
import 'package:mal3abk/features/venue_policies/presentation/cubit/venue_policies_cubit.dart';
import 'package:mal3abk/features/venue_pricing/data/models/price_rule_model.dart';
import 'package:mal3abk/features/venue_pricing/domain/repos/venue_pricing_repo.dart';
import 'package:mal3abk/features/venue_pricing/presentation/cubit/venue_pricing_cubit.dart';
import 'package:mal3abk/features/venue_reports/data/models/venue_report_models.dart';
import 'package:mal3abk/features/venue_reports/domain/repos/venue_reports_repo.dart';
import 'package:mal3abk/features/venue_reports/presentation/cubit/venue_reports_cubit.dart';
import 'package:mal3abk/features/venue_schedule/data/models/venue_schedule_models.dart';
import 'package:mal3abk/features/venue_schedule/domain/repos/venue_schedule_repo.dart';
import 'package:mal3abk/features/venue_schedule/presentation/cubit/venue_schedule_cubit.dart';
import 'package:mal3abk/features/venue_setup/data/models/venue_setup_form.dart';
import 'package:mal3abk/features/venue_setup/domain/repos/venue_setup_repo.dart';
import 'package:mal3abk/features/venue_setup/presentation/cubit/venue_setup_cubit.dart';
import 'package:mal3abk/features/venue_setup/presentation/cubit/venue_setup_state.dart';
import 'package:mal3abk/features/venue_shell/data/models/venue_model.dart';
import 'package:mal3abk/features/venue_shell/data/models/venue_pitch_model.dart';
import 'package:mal3abk/features/venue_staff/data/models/venue_staff_model.dart';
import 'package:mal3abk/features/venue_staff/domain/repos/venue_staff_repo.dart';
import 'package:mal3abk/features/venue_staff/presentation/cubit/venue_staff_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockOverviewRepo extends Mock implements VenueOverviewRepo {}

class MockBookingsRepo extends Mock implements VenueBookingsRepo {}

class MockSetupRepo extends Mock implements VenueSetupRepo {}

class MockReferenceRepo extends Mock implements ReferenceRepo {}

class MockScheduleRepo extends Mock implements VenueScheduleRepo {}

class MockPricingRepo extends Mock implements VenuePricingRepo {}

class MockPoliciesRepo extends Mock implements VenuePoliciesRepo {}

class MockCustomersRepo extends Mock implements VenueCustomersRepo {}

class MockReportsRepo extends Mock implements VenueReportsRepo {}

class MockStaffRepo extends Mock implements VenueStaffRepo {}

class MockAccountRepo extends Mock implements VenueAccountRepo {}

class MockNotificationsApi extends Mock implements NotificationsApiService {}

const failure = AppApiFailure(message: 'errors.server');

const venue = VenueModel(
  id: 'v1',
  name: 'V',
  address: 'a',
  city: 'c',
  area: 'ar',
  phoneNumber: '0',
  approvalStatus: 'Draft',
  isApproved: false,
  isPublished: false,
);

const pitch = VenuePitchModel(
  id: 'p1',
  venueId: 'v1',
  name: 'P',
  turfType: 'Grass',
  capacity: 5,
  format: 'FiveASide',
  isActive: true,
  photos: ['/api/v1/media/m1/medium', 'https://cdn/x.jpg'],
);

const dashboard = VenueDashboardModel(
  businessDate: '2026-01-01',
  today: DashboardCountsModel(),
  todayOccupancy: OccupancyPointModel(date: '2026-01-01'),
);

void main() {
  setUpAll(() {
    CairoTime.initialize();
    registerFallbackValue(const VenueBookingsQuery());
    registerFallbackValue(DayHours.defaultWeek());
    registerFallbackValue(ScheduleOverrideKind.closure);
    registerFallbackValue(const BookingRulesModel());
    registerFallbackValue(PriceRuleDraft.empty('Base', 'B'));
    registerFallbackValue(
      const BookingPolicyModel(BookingPolicyModel.defaults),
    );
    registerFallbackValue(pitch);
    registerFallbackValue(Uint8List(0));
    registerFallbackValue(VenueMediaPurpose.pitchPhoto);
    registerFallbackValue(DateTime(2026));
  });

  group('VenueOverviewCubit', () {
    test('loads numbers and the admin note for a venue under review', () async {
      final repo = MockOverviewRepo();
      when(
        () => repo.getDashboard('v1'),
      ).thenAnswer((_) async => const ApiResult.success(dashboard));
      when(() => repo.getApproval('v1')).thenAnswer(
        (_) async => const ApiResult.success(
          VenueApprovalModel(
            venueId: 'v1',
            approvalStatus: 'NeedsInfo',
            history: [
              VenueApprovalEventModel(
                action: 'Submitted',
                createdAtUtc: 'x',
                message: 'mine',
              ),
              VenueApprovalEventModel(
                action: 'InfoRequested',
                createdAtUtc: 'y',
                message: 'add photos',
              ),
            ],
          ),
        ),
      );
      final cubit = VenueOverviewCubit(
        venueOverviewRepo: repo,
        refreshInterval: Duration.zero,
      );
      await cubit.load('v1', isApproved: false);
      expect((cubit.state as VenueOverviewSuccess).adminMessage, 'add photos');

      when(
        () => repo.getDashboard('v1'),
      ).thenAnswer((_) async => const ApiResult.failure(failure));
      await cubit.load('v1', isApproved: true);
      expect(
        cubit.state,
        isA<VenueOverviewSuccess>(),
        reason: 'a failed refresh keeps the last numbers',
      );
      await cubit.close();
    });

    test('a first failure is an error', () async {
      final repo = MockOverviewRepo();
      when(
        () => repo.getDashboard('v1'),
      ).thenAnswer((_) async => const ApiResult.failure(failure));
      final cubit = VenueOverviewCubit(
        venueOverviewRepo: repo,
        refreshInterval: Duration.zero,
      );
      await cubit.load('v1', isApproved: true);
      expect(cubit.state, const VenueOverviewState.error('errors.server'));
      verifyNever(() => repo.getApproval(any()));
      await cubit.close();
    });
  });

  group('bookings', () {
    late MockBookingsRepo repo;
    setUp(() {
      repo = MockBookingsRepo();
      when(
        () => repo.getBookings(
          any(),
          any(),
          tab: any(named: 'tab'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenAnswer(
        (_) async =>
            const ApiResult.success(VenueBookingPageModel(totalCount: 0)),
      );
    });

    test('search waits for typing to stop and filters reload', () async {
      final cubit = VenueBookingsCubit(
        venueBookingsRepo: repo,
        searchDebounce: const Duration(milliseconds: 20),
      );
      await cubit.start('v1');
      cubit.setSearch('a');
      cubit.setSearch('ali ');
      await Future<void>.delayed(const Duration(milliseconds: 60));
      expect(cubit.query.search, 'ali');
      await cubit.setQuery(
        cubit.query.copyWith(
          source: VenueBookingsSource.app,
          range: VenueBookingsRange.week,
        ),
      );
      expect(cubit.query.source, VenueBookingsSource.app);
      expect(cubit.query.hasFilters, isTrue);
      await cubit.setQuery(const VenueBookingsQuery());
      expect(cubit.query.hasFilters, isFalse);
      await cubit.close();
    });

    test('confirming from the list returns the failure key', () async {
      when(
        () => repo.getBookings(
          any(),
          any(),
          tab: any(named: 'tab'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenAnswer(
        (_) async => ApiResult.success(
          VenueBookingPageModel(items: [_item()], totalCount: 1),
        ),
      );
      when(
        () => repo.confirmManual('v1', 'b1'),
      ).thenAnswer((_) async => const ApiResult.failure(failure));
      final cubit = VenueBookingsCubit(venueBookingsRepo: repo);
      await cubit.start('v1');
      expect(await cubit.confirmManual('b1'), 'errors.server');
      await cubit.close();
    });

    test(
      'details: cancel and no-show succeed and mark the list changed',
      () async {
        when(
          () => repo.getBooking('v1', 'b1'),
        ).thenAnswer((_) async => const ApiResult.success(_detail));
        when(
          () => repo.cancel('v1', 'b1', 'rain'),
        ).thenAnswer((_) async => const ApiResult.success(null));
        when(
          () => repo.markNoShow('v1', 'b1', 'late'),
        ).thenAnswer((_) async => const ApiResult.success(null));
        final cubit = VenueBookingDetailCubit(venueBookingsRepo: repo);
        await cubit.load('v1', 'b1');
        await cubit.cancel('rain');
        expect(
          (cubit.state as VenueBookingDetailSuccess).done,
          VenueBookingAction.cancel,
        );
        await cubit.markNoShow('late');
        expect(
          (cubit.state as VenueBookingDetailSuccess).done,
          VenueBookingAction.noShow,
        );
        expect(cubit.changed, isTrue);
        await cubit.close();
      },
    );

    test('CSV cells are quoted and formulas neutralised', () {
      expect(VenueBookingsCsv.cell('Ali "A"'), '"Ali ""A"""');
      expect(VenueBookingsCsv.cell('=HYPERLINK()'), '"\'=HYPERLINK()"');
      expect(VenueBookingsCsv.cell('+2010'), '"\'+2010"');
    });
  });

  group('VenueSetupCubit photos, pitches and review', () {
    late MockSetupRepo repo;
    late MockReferenceRepo reference;
    setUp(() {
      repo = MockSetupRepo();
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
      ).thenAnswer((_) async => const ApiResult.success([pitch]));
      when(
        () => repo.getSchedules(any()),
      ).thenAnswer((_) async => const ApiResult.success([]));
      when(
        () => repo.getApproval(any()),
      ).thenAnswer((_) async => const ApiResult.failure(failure));
      when(() => repo.uploadImage(any(), any())).thenAnswer(
        (_) async => const ApiResult.success('/api/v1/media/m2/medium'),
      );
    });

    test('before the venue exists photos wait for the first save', () async {
      final cubit = VenueSetupCubit(
        venueSetupRepo: repo,
        referenceRepo: reference,
      );
      await cubit.uploadVenuePhoto(Uint8List(1));
      expect(cubit.state.pendingVenuePhotos, ['/api/v1/media/m2/medium']);
      await cubit.removeVenuePhoto('/api/v1/media/m2/medium');
      expect(cubit.state.pendingVenuePhotos, isEmpty);
      verifyNever(() => repo.addVenuePhoto(any(), any()));
      await cubit.close();
    });

    test(
      'an existing venue adds photos to its gallery; pitches add and delete',
      () async {
        when(
          () => repo.addVenuePhoto('v1', any()),
        ).thenAnswer((_) async => const ApiResult.success(null));
        when(
          () => repo.removeVenuePhoto('v1', any()),
        ).thenAnswer((_) async => const ApiResult.success(null));
        when(
          () => repo.addPitch(
            'v1',
            name: any(named: 'name'),
            turfType: any(named: 'turfType'),
            capacity: any(named: 'capacity'),
            photos: any(named: 'photos'),
          ),
        ).thenAnswer((_) async => const ApiResult.success(null));
        when(
          () => repo.deletePitch('p1'),
        ).thenAnswer((_) async => const ApiResult.success(null));
        when(
          () => repo.addPitchPhoto('v1', 'p1', any()),
        ).thenAnswer((_) async => const ApiResult.success(null));
        when(
          () => repo.removePitchPhoto('v1', 'p1', any()),
        ).thenAnswer((_) async => const ApiResult.success(null));
        when(() => repo.submitForReview('v1', 'hi')).thenAnswer(
          (_) async => const ApiResult.success(
            VenueApprovalModel(venueId: 'v1', approvalStatus: 'Submitted'),
          ),
        );

        final cubit = VenueSetupCubit(
          venueSetupRepo: repo,
          referenceRepo: reference,
          venue: venue,
        );
        await cubit.init();
        expect(cubit.state.pitches.single.id, 'p1');
        await cubit.uploadVenuePhoto(Uint8List(1));
        expect(cubit.state.venue!.photos, ['/api/v1/media/m2/medium']);
        await cubit.removeVenuePhoto('/api/v1/media/m2/medium');
        expect(cubit.state.venue!.photos, isEmpty);

        await cubit.uploadDraftPitchPhoto(Uint8List(1));
        expect(
          await cubit.addPitch(name: 'P2', turfType: 'Grass', capacity: 7),
          isTrue,
        );
        verify(
          () => repo.addPitch(
            'v1',
            name: 'P2',
            turfType: 'Grass',
            capacity: 7,
            photos: ['/api/v1/media/m2/medium'],
          ),
        ).called(1);
        expect(cubit.state.draftPitchPhotos, isEmpty);
        await cubit.uploadPitchPhoto('p1', Uint8List(1));
        await cubit.removePitchPhoto('p1', '/api/v1/media/m1/medium');
        await cubit.deletePitch('p1');

        expect(cubit.state.canSubmit, isTrue);
        await cubit.submitForReview('hi');
        expect(cubit.state.approvalStatus, 'Submitted');
        expect(cubit.state.canSubmit, isFalse);
        await cubit.close();
      },
    );

    test('a failed upload shows its error', () async {
      when(() => repo.uploadImage(any(), any())).thenAnswer(
        (_) async => const ApiResult.failure(
          AppApiFailure(message: 'errors.media.invalid_image'),
        ),
      );
      final cubit = VenueSetupCubit(
        venueSetupRepo: repo,
        referenceRepo: reference,
        venue: venue,
      );
      await cubit.uploadVenuePhoto(Uint8List(1));
      expect(cubit.state.error, 'errors.media.invalid_image');
      expect(cubit.state.uploading, isFalse);
      await cubit.close();
    });
  });

  group('VenuePitchesCubit', () {
    late MockSetupRepo repo;
    late MockReferenceRepo reference;
    setUp(() {
      repo = MockSetupRepo();
      reference = MockReferenceRepo();
      when(() => reference.getFilterOptions()).thenAnswer(
        (_) async => const ApiResult.success(
          FilterOptionsModel(pitchTypes: [], surfaces: [], facilities: []),
        ),
      );
      when(
        () => repo.getPitches('v1'),
      ).thenAnswer((_) async => const ApiResult.success([pitch]));
    });

    test(
      'pausing reports the upcoming bookings; links are dropped by saving',
      () async {
        when(
          () => repo.setPitchActive('p1', false),
        ).thenAnswer((_) async => const ApiResult.success(3));
        when(
          () => repo.updatePitch(
            any(),
            name: any(named: 'name'),
            turfType: any(named: 'turfType'),
            capacity: any(named: 'capacity'),
            lengthMeters: any(named: 'lengthMeters'),
            widthMeters: any(named: 'widthMeters'),
            photos: any(named: 'photos'),
          ),
        ).thenAnswer((_) async => const ApiResult.success(pitch));
        when(
          () => repo.removePitchPhoto('v1', 'p1', any()),
        ).thenAnswer((_) async => const ApiResult.success(null));
        when(
          () => repo.publishVenue('v1', true),
        ).thenAnswer((_) async => const ApiResult.failure(failure));

        final cubit = VenuePitchesCubit(
          venueSetupRepo: repo,
          referenceRepo: reference,
          venueId: 'v1',
        );
        await cubit.load();
        final paused = await cubit.toggleActive(pitch);
        expect((paused as PitchActionDone).upcomingBookings, 3);

        await cubit.removePhoto(pitch, '/api/v1/media/m1/medium');
        verify(
          () => repo.removePitchPhoto('v1', 'p1', '/api/v1/media/m1/medium'),
        ).called(1);
        await cubit.removePhoto(pitch, 'https://cdn/x.jpg');
        verify(
          () => repo.updatePitch(
            pitch,
            name: 'P',
            turfType: 'Grass',
            capacity: 5,
            photos: ['/api/v1/media/m1/medium'],
          ),
        ).called(1);

        final publish = await cubit.publishVenue('v1', true);
        expect((publish as PitchActionFailed).message, 'errors.server');
        expect(cubit.state.busyId, isNull);
        await cubit.close();
      },
    );

    test('adding a pitch returns the new one for editing', () async {
      var calls = 0;
      when(() => repo.getPitches('v1')).thenAnswer((_) async {
        calls++;
        return ApiResult.success(
          calls == 1
              ? [pitch]
              : [
                  pitch,
                  const VenuePitchModel(
                    id: 'p2',
                    venueId: 'v1',
                    name: 'Pitch 2',
                    turfType: 'ArtificialTurf',
                    capacity: 5,
                    format: 'FiveASide',
                    isActive: true,
                  ),
                ],
        );
      });
      when(
        () => repo.addPitch(
          'v1',
          name: 'Pitch 2',
          turfType: 'ArtificialTurf',
          capacity: 5,
          photos: const [],
        ),
      ).thenAnswer((_) async => const ApiResult.success(null));
      final cubit = VenuePitchesCubit(
        venueSetupRepo: repo,
        referenceRepo: reference,
        venueId: 'v1',
      );
      await cubit.load();
      final (result, added) = await cubit.addPitch('Pitch 2');
      expect(result, isA<PitchActionDone>());
      expect(added?.id, 'p2');
      await cubit.close();
    });
  });

  group('VenueScheduleCubit', () {
    late MockScheduleRepo repo;
    setUp(() {
      repo = MockScheduleRepo();
      when(() => repo.getSpecialSchedules('v1')).thenAnswer(
        (_) async => const ApiResult.success(
          SpecialSchedulesModel(
            pitchHours: [
              PitchWeeklyHoursModel(
                pitchId: 'p1',
                dayOfWeek: 5,
                openTime: '10:00:00',
                closeTime: '22:00:00',
              ),
            ],
            rules: [BookingRulesModel(maxAdvanceDays: 7)],
          ),
        ),
      );
      when(
        () => repo.getVenueWeek('v1'),
      ).thenAnswer((_) async => const ApiResult.success([]));
    });

    test(
      'venue hours ask about affected bookings, then save on confirm',
      () async {
        when(() => repo.previewVenueWeek('v1', any())).thenAnswer(
          (_) async => const ApiResult.success([
            UpcomingBookingRefModel(
              bookingId: 'b',
              reference: 'R',
              startUtc: 's',
            ),
          ]),
        );
        when(
          () => repo.saveVenueWeek('v1', any()),
        ).thenAnswer((_) async => const ApiResult.success(null));
        final cubit = VenueScheduleCubit(
          venueScheduleRepo: repo,
          venueId: 'v1',
        );
        await cubit.load();
        expect(cubit.currentRules.maxAdvanceDays, 7);
        final first = await cubit.saveWeek();
        expect((first as ScheduleNeedsConfirm).affected.single.reference, 'R');
        verifyNever(() => repo.saveVenueWeek(any(), any()));
        expect(await cubit.saveWeek(confirm: true), isA<ScheduleSaved>());
        await cubit.close();
      },
    );

    test(
      'a pitch with its own hours loads them; the API holds back a clash',
      () async {
        when(
          () => repo.savePitchWeek('v1', 'p1', any(), confirm: false),
        ).thenAnswer(
          (_) async => const ApiResult.success(
            ScheduleChangeResult(
              applied: false,
              affected: [
                UpcomingBookingRefModel(
                  bookingId: 'b',
                  reference: 'R',
                  startUtc: 's',
                ),
              ],
            ),
          ),
        );
        when(
          () => repo.savePitchWeek('v1', 'p1', any(), confirm: true),
        ).thenAnswer(
          (_) async =>
              const ApiResult.success(ScheduleChangeResult(applied: true)),
        );
        final cubit = VenueScheduleCubit(
          venueScheduleRepo: repo,
          venueId: 'v1',
        );
        await cubit.load();
        await cubit.selectPitch('p1');
        expect(cubit.hasOwnPitchHours, isTrue);
        expect(cubit.state.week[5]!.open, '10:00');
        expect(cubit.state.week[6]!.on, isFalse);
        expect(await cubit.saveWeek(), isA<ScheduleNeedsConfirm>());
        expect(await cubit.saveWeek(confirm: true), isA<ScheduleSaved>());
        await cubit.close();
      },
    );

    test('closures, holidays, removal and rules', () async {
      when(
        () => repo.addOverride(
          'v1',
          pitchId: any(named: 'pitchId'),
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          kind: any(named: 'kind'),
          fromTime: any(named: 'fromTime'),
          toTime: any(named: 'toTime'),
          reason: any(named: 'reason'),
          confirm: any(named: 'confirm'),
        ),
      ).thenAnswer(
        (_) async =>
            const ApiResult.success(ScheduleChangeResult(applied: true)),
      );
      when(
        () => repo.closeHolidays(
          'v1',
          year: 2026,
          pitchId: any(named: 'pitchId'),
          confirm: false,
        ),
      ).thenAnswer((_) async => const ApiResult.failure(failure));
      when(
        () => repo.removeOverride('v1', 'o1'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.saveRules('v1', any()),
      ).thenAnswer((_) async => const ApiResult.success(null));
      final cubit = VenueScheduleCubit(venueScheduleRepo: repo, venueId: 'v1');
      await cubit.load();
      await cubit.selectPitch('p1');
      await cubit.addOverride(
        kind: ScheduleOverrideKind.closure,
        startDate: '2026-12-01',
        reason: 'x',
        allPitches: false,
      );
      verify(
        () => repo.addOverride(
          'v1',
          pitchId: 'p1',
          startDate: '2026-12-01',
          endDate: null,
          kind: ScheduleOverrideKind.closure,
          fromTime: null,
          toTime: null,
          reason: 'x',
          confirm: false,
        ),
      ).called(1);
      final holidays = await cubit.closeHolidays(year: 2026, allPitches: true);
      expect((holidays as ScheduleSaveFailed).message, 'errors.server');
      expect(await cubit.removeOverride('o1'), isA<ScheduleSaved>());
      await cubit.saveRules(const BookingRulesModel(minDurationMinutes: 90));
      final sent =
          verify(() => repo.saveRules('v1', captureAny())).captured.single
              as BookingRulesModel;
      expect(sent.pitchId, 'p1');
      expect(sent.minDurationMinutes, 90);
      await cubit.close();
    });
  });

  group('pricing', () {
    test('draft validation follows the web rules', () {
      PriceRuleDraft d(String kind, String adj, String value) =>
          PriceRuleDraft.empty(
            kind,
            kind,
          ).copyWith(adjustment: adj, value: value);
      expect(
        d('Base', 'FixedHourlyRate', '').error,
        'venue.pricing.errors.value',
      );
      expect(
        d('Base', 'FixedHourlyRate', '0').error,
        'venue.pricing.errors.positive',
      );
      expect(
        d('Peak', 'Percentage', '0').error,
        'venue.pricing.errors.percent_range',
      );
      expect(
        d('Peak', 'Percentage', '400').error,
        'venue.pricing.errors.percent_range',
      );
      expect(
        d('Discount', 'Percentage', '120').error,
        'venue.pricing.errors.discount_percent_range',
      );
      expect(
        d('SpecialDate', 'FixedHourlyRate', '300').error,
        'venue.pricing.errors.dates_required',
      );
      expect(
        d(
          'SpecialDate',
          'FixedHourlyRate',
          '300',
        ).copyWith(startDate: '2026-02-02', endDate: '2026-02-01').error,
        'venue.pricing.errors.dates_order',
      );
      expect(
        d('Peak', 'FixedHourlyRate', '300').copyWith(endTime: '').error,
        'venue.pricing.errors.hours_pair',
      );
      expect(d('Peak', 'FixedHourlyRate', '300').error, isNull);
      expect(PriceRuleDraft.empty('Weekend', 'W').days, [4, 5]);
      expect(PriceRuleDraft.empty('Base', 'B').toJson()['startTime'], isNull);
    });

    test('cubit saves, toggles, deletes and previews', () async {
      final repo = MockPricingRepo();
      const rule = PriceRuleModel(
        id: 'r1',
        kind: 'Base',
        adjustment: 'FixedHourlyRate',
        name: 'B',
        amount: 300,
      );
      when(
        () => repo.getRules('v1'),
      ).thenAnswer((_) async => const ApiResult.success([rule]));
      when(
        () => repo.saveRule('v1', any()),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.deleteRule('v1', 'r1'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.preview(
          'v1',
          pitchId: 'p1',
          startUtc: any(named: 'startUtc'),
          endUtc: any(named: 'endUtc'),
        ),
      ).thenAnswer(
        (_) async => const ApiResult.failure(
          AppApiFailure(message: 'x', code: 'Pricing.NoBasePrice'),
        ),
      );
      final cubit = VenuePricingCubit(venuePricingRepo: repo, venueId: 'v1');
      await cubit.load();
      expect(cubit.state.hasBase, isTrue);
      expect(
        await cubit.save(PriceRuleDraft.empty('Base', '')),
        'venue.pricing.errors.name',
      );
      expect(await cubit.toggle(rule), isNull);
      final toggled =
          verify(() => repo.saveRule('v1', captureAny())).captured.single
              as PriceRuleDraft;
      expect(toggled.isActive, isFalse);
      expect(toggled.id, 'r1');
      expect(await cubit.delete(rule), isNull);
      await cubit.preview(
        pitchId: 'p1',
        startUtc: DateTime.utc(2026),
        endUtc: DateTime.utc(2026),
      );
      expect(cubit.state.quoteError, 'venue.pricing.preview.no_base');
      cubit.setPitchFilter('p9');
      expect(cubit.state.visible, [
        rule,
      ], reason: 'rules for every pitch stay visible');
      await cubit.close();
    });
  });

  group('policies', () {
    test('options match, patch and save', () async {
      final repo = MockPoliciesRepo();
      when(() => repo.getPolicy('v1')).thenAnswer(
        (_) async => const ApiResult.success(
          BookingPolicyModel(BookingPolicyModel.defaults),
        ),
      );
      when(
        () => repo.savePolicy('v1', any()),
      ).thenAnswer((_) async => const ApiResult.success(null));
      final cubit = VenuePoliciesCubit(venuePoliciesRepo: repo, venueId: 'v1');
      await cubit.load();
      expect(
        PolicyOptionGroup.selected(cubit.state.policy, 'refund'),
        'refund_full',
      );
      cubit.choose({'refundEligibility': 1, 'refundPercentage': 50});
      expect(cubit.state.dirty, isTrue);
      expect(
        PolicyOptionGroup.selected(cubit.state.policy, 'refund'),
        'refund_half',
      );
      cubit.setTerms('   ');
      expect(cubit.state.policy.values['terms'], isNull);
      expect(await cubit.save(), isNull);
      final saved =
          verify(() => repo.savePolicy('v1', captureAny())).captured.single
              as BookingPolicyModel;
      expect(saved.values['refundPercentage'], 50);
      await cubit.close();
    });

    test('reads the current version, with defaults when there is none', () {
      expect(
        BookingPolicyModel.fromVersions(const []).values,
        BookingPolicyModel.defaults,
      );
      final p = BookingPolicyModel.fromVersions([
        {
          'version': 1,
          'isCurrent': false,
          'policy': {'depositType': 'Full'},
        },
        {
          'version': 2,
          'isCurrent': true,
          'policy': {'depositType': 'FixedAmount', 'allowReschedule': false},
        },
      ]);
      expect(p.version, 2);
      expect(p.values['depositType'], 1);
      expect(PolicyOptionGroup.selected(p, 'reschedule'), isNull);
    });
  });

  group('customers', () {
    test('filters, search and notes', () async {
      final repo = MockCustomersRepo();
      when(
        () => repo.getCustomers(
          'v1',
          search: any(named: 'search'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenAnswer(
        (_) async => const ApiResult.success(
          VenueCustomerPageModel(
            items: [
              VenueCustomerModel(
                customerKey: 'a',
                name: 'A',
                totalBookings: 12,
              ),
              VenueCustomerModel(customerKey: 'b', name: 'B', noShows: 1),
              VenueCustomerModel(customerKey: 'c', name: 'C'),
            ],
            totalCount: 60,
          ),
        ),
      );
      final cubit = VenueCustomersCubit(
        venueCustomersRepo: repo,
        venueId: 'v1',
        debounce: Duration.zero,
      );
      await cubit.load();
      expect(cubit.state.pages, 3);
      cubit.setFilter(VenueCustomersFilter.regular);
      expect(cubit.state.visible.map((c) => c.customerKey), ['a']);
      cubit.setFilter(VenueCustomersFilter.noShow);
      expect(cubit.state.visible.map((c) => c.customerKey), ['b']);
      cubit.setSearch(' ali ');
      await Future<void>.delayed(const Duration(milliseconds: 10));
      verify(
        () => repo.getCustomers('v1', search: 'ali', page: 1, pageSize: 25),
      ).called(1);
      await cubit.close();

      when(() => repo.getCustomer('v1', 'a')).thenAnswer(
        (_) async => const ApiResult.success(
          VenueCustomerDetailModel(
            customer: VenueCustomerModel(customerKey: 'a', name: 'A'),
          ),
        ),
      );
      when(
        () => repo.addNote('v1', 'a', 'cash'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.deleteNote('v1', 'a', 'n1'),
      ).thenAnswer((_) async => const ApiResult.failure(failure));
      final detail = VenueCustomerDetailCubit(
        venueCustomersRepo: repo,
        venueId: 'v1',
        customerKey: 'a',
      );
      await detail.load();
      expect(detail.state, isA<Success<VenueCustomerDetailModel>>());
      expect(await detail.addNote(' '), 'venue.customers.note_empty');
      expect(await detail.addNote('cash'), isNull);
      expect(await detail.deleteNote('n1'), 'errors.server');
      await detail.close();
    });
  });

  group('reports and payouts', () {
    test(
      'presets pick the range and grouping; CSV is named by the range',
      () async {
        final repo = MockReportsRepo();
        when(
          () => repo.getReport(
            'v1',
            from: any(named: 'from'),
            to: any(named: 'to'),
            groupBy: any(named: 'groupBy'),
            pitchId: any(named: 'pitchId'),
          ),
        ).thenAnswer(
          (_) async => const ApiResult.success(
            VenueReportModel(from: 'a', to: 'b', revenue: RevenueSplitModel()),
          ),
        );
        when(
          () => repo.exportBookingsCsv(
            'v1',
            from: any(named: 'from'),
            to: any(named: 'to'),
            pitchId: any(named: 'pitchId'),
          ),
        ).thenAnswer((_) async => const ApiResult.success([97, 98]));
        final cubit = VenueReportsCubit(venueReportsRepo: repo, venueId: 'v1');
        expect(cubit.range.$3, 0);
        cubit.setPreset(ReportPreset.month);
        expect(cubit.range.$3, 1);
        cubit.setPreset(ReportPreset.quarter);
        expect(cubit.range.$3, 2);
        expect(cubit.range.$2.difference(cubit.range.$1).inDays, 89);
        cubit.setCustom(from: DateTime(2026, 1, 1), to: DateTime(2026, 3, 15));
        expect(cubit.range.$3, 1, reason: '73 days groups by week');
        cubit.setPitch('p1');
        await Future<void>.delayed(Duration.zero);
        final (bytes, name, error) = await cubit.exportCsv();
        expect(bytes, [97, 98]);
        expect(name, 'bookings-2026-01-01-2026-03-15.csv');
        expect(error, isNull);
        verify(
          () => repo.exportBookingsCsv(
            'v1',
            from: '2026-01-01',
            to: '2026-03-15',
            pitchId: 'p1',
          ),
        ).called(1);
        await cubit.close();

        when(() => repo.getPayouts('v1')).thenAnswer(
          (_) async => const ApiResult.success(
            VenuePayoutStatementModel(
              balance: VenuePayoutBalanceModel(balance: 500),
            ),
          ),
        );
        final payouts = VenuePayoutsCubit(
          venueReportsRepo: repo,
          venueId: 'v1',
        );
        await payouts.load();
        expect(
          (payouts.state as Success<VenuePayoutStatementModel>)
              .data
              .balance
              .balance,
          500,
        );
        await payouts.close();
      },
    );
  });

  group('staff', () {
    test('invite needs a contact; every action reloads', () async {
      final repo = MockStaffRepo();
      when(
        () => repo.getStaff('v1'),
      ).thenAnswer((_) async => const ApiResult.success(VenueStaffModel()));
      when(
        () => repo.invite('v1', 'a@b.com', 'Manager'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.resendInvitation('v1', 'i'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.cancelInvitation('v1', 'i'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.changeRole('v1', 'm', 'Accountant'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.removeMember('v1', 'm'),
      ).thenAnswer((_) async => const ApiResult.failure(failure));
      final cubit = VenueStaffCubit(venueStaffRepo: repo, venueId: 'v1');
      await cubit.load();
      expect(
        await cubit.invite(' ', 'Manager'),
        'venue.staff.contact_required',
      );
      expect(await cubit.invite(' a@b.com ', 'Manager'), isNull);
      expect(await cubit.resend('i'), isNull);
      expect(await cubit.cancelInvitation('i'), isNull);
      expect(await cubit.changeRole('m', 'Accountant'), isNull);
      expect(await cubit.remove('m'), 'errors.server');
      expect(StaffRoles.valueOf('Accountant'), 2);
      await cubit.close();
    });
  });

  group('account', () {
    test('validates, enrolls two-factor and walks the phone change', () async {
      final repo = MockAccountRepo();
      when(() => repo.getProfile()).thenAnswer(
        (_) async => const ApiResult.success(
          VenueAccountProfile(fullName: 'O', phoneNumber: '+20'),
        ),
      );
      when(
        () => repo.updateName('New'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.changePassword('old', '1234567890'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.enrollTotp(),
      ).thenAnswer((_) async => const ApiResult.success(('S', 'otpauth://x')));
      when(
        () => repo.confirmTotp('123456'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.startPhoneChange('+201099999999', 'pw'),
      ).thenAnswer((_) async => const ApiResult.success('rq'));
      when(
        () => repo.verifyOldPhone('rq', '1'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.verifyNewPhone('rq', '2'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      when(
        () => repo.startEmailChange('n@x.com', 'pw'),
      ).thenAnswer((_) async => const ApiResult.failure(failure));
      final cubit = VenueAccountCubit(venueAccountRepo: repo);
      await cubit.load();
      expect(cubit.state.profile?.fullName, 'O');
      expect(await cubit.updateName(' '), 'venue_auth.register.name_required');
      expect(await cubit.updateName('New'), isNull);
      expect(
        await cubit.changePassword('', 'x'),
        'venue.settings.password_current_required',
      );
      expect(
        await cubit.changePassword('old', 'short'),
        'venue_auth.register.password_short',
      );
      expect(await cubit.changePassword('old', '1234567890'), isNull);
      expect(await cubit.enrollTotp(), isNull);
      expect(cubit.state.totpUri, 'otpauth://x');
      expect(await cubit.confirmTotp('123456'), isNull);
      expect(cubit.state.totpUri, isNull);
      expect(await cubit.startPhoneChange('+201099999999', 'pw'), isNull);
      expect(await cubit.verifyOldPhone('1'), isNull);
      expect(await cubit.verifyNewPhone('2'), isNull);
      expect(await cubit.startEmailChange('n@x.com', 'pw'), 'errors.server');
      await cubit.close();
    });
  });

  group('notifications', () {
    test('venue surface, mark read and where each type leads', () async {
      final api = MockNotificationsApi();
      final n = NotificationModel(
        id: 'n1',
        type: 'booking.confirmed',
        category: 'Bookings',
        title: 't',
        body: 'b',
        isRead: false,
        createdAtUtc: DateTime.utc(2026),
      );
      when(
        () => api.getNotifications(page: any(named: 'page'), surface: 1),
      ).thenAnswer(
        (_) async => NotificationPageModel(
          items: [n],
          page: 1,
          pageSize: 20,
          totalCount: 1,
          unreadCount: 1,
        ),
      );
      when(() => api.markRead('n1')).thenAnswer((_) async {});
      when(() => api.markAllRead(surface: 1)).thenAnswer((_) async {});
      final cubit = VenueNotificationsCubit(notificationsApiService: api);
      await cubit.load();
      expect(cubit.state.unreadCount, 1);
      await cubit.markRead(n);
      expect(cubit.state.items.single.isRead, isTrue);
      expect(cubit.state.unreadCount, 0);
      await cubit.markAllRead();
      verify(() => api.markAllRead(surface: 1)).called(1);
      await cubit.close();

      expect(
        VenueNotificationsCubit.targetOf('payment.proof_submitted'),
        'bookings',
      );
      expect(
        VenueNotificationsCubit.targetOf('staff.invitation_accepted'),
        'staff',
      );
      expect(VenueNotificationsCubit.targetOf('payout.recorded'), 'payouts');
      expect(VenueNotificationsCubit.targetOf('venue.rejected'), 'setup');
      expect(VenueNotificationsCubit.targetOf('venue.approved'), 'overview');
      expect(
        VenueNotificationsCubit.targetOf('security.new_device'),
        'settings',
      );
      expect(VenueNotificationsCubit.targetOf('team.joined'), isNull);
    });

    test('a failed load shows the error', () async {
      final api = MockNotificationsApi();
      when(
        () => api.getNotifications(page: any(named: 'page'), surface: 1),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.connectionError,
        ),
      );
      final cubit = VenueNotificationsCubit(notificationsApiService: api);
      await cubit.load();
      expect(cubit.state.error, 'errors.network');
      await cubit.close();
    });
  });
}

VenueBookingItemModel _item() => const VenueBookingItemModel(
  id: 'b1',
  reference: 'R',
  pitchId: 'p1',
  startUtc: '2026-01-01T18:00:00Z',
  endUtc: '2026-01-01T19:00:00Z',
  status: 2,
  isManual: true,
);

const _detail = VenueBookingDetailModel(
  id: 'b1',
  reference: 'R',
  pitchId: 'p1',
  startUtc: '2026-01-01T18:00:00Z',
  endUtc: '2026-01-01T19:00:00Z',
  status: 5,
);
