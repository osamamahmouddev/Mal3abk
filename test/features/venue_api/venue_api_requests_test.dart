import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/turnstile_token_provider.dart';
import 'package:mal3abk/core/config/env_config.dart';
import 'package:mal3abk/core/utils/cairo_time.dart';
import 'package:mal3abk/core/utils/image_sanitizer.dart';
import 'package:mal3abk/features/venue_account/data/apis/venue_account_api_service.dart';
import 'package:mal3abk/features/venue_account/data/repos/venue_account_repo_impl.dart';
import 'package:mal3abk/features/venue_auth/data/apis/venue_auth_api_service.dart';
import 'package:mal3abk/features/venue_auth/data/models/register_owner_request_body.dart';
import 'package:mal3abk/features/venue_auth/data/repos/venue_auth_repo_impl.dart';
import 'package:mal3abk/features/venue_bookings/data/apis/venue_bookings_api_service.dart';
import 'package:mal3abk/features/venue_bookings/data/models/venue_bookings_query.dart';
import 'package:mal3abk/features/venue_bookings/data/repos/venue_bookings_repo_impl.dart';
import 'package:mal3abk/features/venue_calendar/data/apis/venue_calendar_api_service.dart';
import 'package:mal3abk/features/venue_calendar/data/models/manual_booking_request_body.dart';
import 'package:mal3abk/features/venue_calendar/data/repos/venue_calendar_repo_impl.dart';
import 'package:mal3abk/features/venue_customers/data/apis/venue_customers_api_service.dart';
import 'package:mal3abk/features/venue_customers/data/repos/venue_customers_repo_impl.dart';
import 'package:mal3abk/features/venue_overview/data/apis/venue_overview_api_service.dart';
import 'package:mal3abk/features/venue_overview/data/repos/venue_overview_repo_impl.dart';
import 'package:mal3abk/features/venue_policies/data/apis/venue_policies_api_service.dart';
import 'package:mal3abk/features/venue_policies/data/models/booking_policy_model.dart';
import 'package:mal3abk/features/venue_policies/data/repos/venue_policies_repo_impl.dart';
import 'package:mal3abk/features/venue_pricing/data/apis/venue_pricing_api_service.dart';
import 'package:mal3abk/features/venue_pricing/data/models/price_rule_model.dart';
import 'package:mal3abk/features/venue_pricing/data/repos/venue_pricing_repo_impl.dart';
import 'package:mal3abk/features/venue_reports/data/apis/venue_reports_api_service.dart';
import 'package:mal3abk/features/venue_reports/data/repos/venue_reports_repo_impl.dart';
import 'package:mal3abk/features/venue_schedule/data/apis/venue_schedule_api_service.dart';
import 'package:mal3abk/features/venue_schedule/data/models/venue_schedule_models.dart';
import 'package:mal3abk/features/venue_schedule/data/repos/venue_schedule_repo_impl.dart';
import 'package:mal3abk/features/venue_setup/data/apis/venue_setup_api_service.dart';
import 'package:mal3abk/features/venue_setup/data/models/venue_setup_form.dart';
import 'package:mal3abk/features/venue_setup/data/repos/venue_setup_repo_impl.dart';
import 'package:mal3abk/features/venue_setup/domain/repos/venue_setup_repo.dart';
import 'package:mal3abk/features/venue_shell/data/apis/venue_shell_api_service.dart';
import 'package:mal3abk/features/venue_shell/data/models/venue_pitch_model.dart';
import 'package:mal3abk/features/venue_shell/data/repos/venue_shell_repo_impl.dart';
import 'package:mal3abk/features/venue_staff/data/apis/venue_staff_api_service.dart';
import 'package:mal3abk/features/venue_staff/data/repos/venue_staff_repo_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fake_auth_token_storage.dart';
import '../../helpers/fake_http_adapter.dart';

class _MockEnvConfig extends Mock implements EnvConfig {}

class _PassThroughSanitizer extends ImageSanitizer {
  const _PassThroughSanitizer();
  @override
  Future<Uint8List?> sanitize(Uint8List bytes) async => bytes;
}

/// Answers every venue endpoint with a minimal valid body and records what
/// the app sent, so each request's method, path, query and body are checked
/// against the API contract.
ResponseBody _respond(RequestOptions o) {
  final p = o.path;
  final m = o.method;
  Map<String, dynamic> venue() => {
    'id': 'v1',
    'name': 'V',
    'slug': 'v',
    'ownerId': 'u',
    'address': 'a',
    'city': 'c',
    'area': 'ar',
    'phoneNumber': '0',
    'approvalStatus': 'Draft',
    'isApproved': false,
    'isPublished': false,
    'facilities': <String>[],
    'photos': <String>[],
    'pitches': <Object>[],
    'pricingModel': 'Commission',
  };
  Map<String, dynamic> pitch() => {
    'id': 'p1',
    'venueId': 'v1',
    'name': 'P',
    'turfType': 'ArtificialTurf',
    'surfaceDisplayName': 's',
    'surfaceArabicDisplayName': 's',
    'capacity': 5,
    'format': 'FiveASide',
    'isActive': true,
    'photos': <String>[],
  };
  ResponseBody json(Object body) => ResponseBody.fromString(
    jsonEncode(body),
    200,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );
  ResponseBody empty() => ResponseBody.fromString('', 204);

  if (p == '/api/v1/auth/login') {
    return json({
      'userId': 'u',
      'fullName': 'Owner',
      'roles': ['VenueOwner'],
      'accessToken': 'at',
      'expiresIn': 600,
      'refreshToken': 'rt',
      'refreshTokenExpiresAtUtc': '2030-01-01T00:00:00Z',
    });
  }
  if (p == '/api/v1/venue-manager/venues' && m == 'GET') return json([venue()]);
  if (p == '/api/v1/venue-manager/venues' && m == 'POST') return json(venue());
  if (p == '/api/v1/venue-manager/venues/v1' && m == 'PUT') {
    return json(venue());
  }
  if (p == '/api/v1/me/permissions') {
    return json({
      'roles': <String>[],
      'permissions': <String>[],
      'venues': <Object>[],
    });
  }
  if (p.endsWith('/dashboard')) {
    return json({
      'businessDate': '2026-01-01',
      'today': <String, Object>{},
      'todayOccupancy': {'date': '2026-01-01'},
      'generatedAtUtc': '2026-01-01T00:00:00Z',
    });
  }
  if (p.endsWith('/approval') || p.endsWith('/approval/submit')) {
    return json({
      'venueId': 'v1',
      'approvalStatus': 'Submitted',
      'history': <Object>[],
    });
  }
  if (p.endsWith('/bookings') && m == 'GET') {
    return json({
      'items': <Object>[],
      'totalCount': 0,
      'page': 1,
      'pageSize': 20,
    });
  }
  if (p.endsWith('/bookings/b1') && m == 'GET') {
    return json({
      'id': 'b1',
      'reference': 'R',
      'venueId': 'v1',
      'pitchId': 'p1',
      'playerId': 'u',
      'startUtc': '2026-01-01T18:00:00Z',
      'endUtc': '2026-01-01T19:00:00Z',
      'status': 5,
      'proofs': <Object>[],
      'statusHistory': <Object>[],
      'createdAtUtc': '2026-01-01T00:00:00Z',
    });
  }
  if (p.endsWith('/calendar') || p.endsWith('/schedules') && m == 'GET') {
    return json(<Object>[]);
  }
  if (p.endsWith('/schedules') && m == 'PUT') return json(<Object>[]);
  if (p.endsWith('/bookings/manual/bulk')) {
    return json({
      'succeeded': 1,
      'failed': 1,
      'slots': [
        {'succeeded': true},
        {'succeeded': false, 'errorCode': 'Booking.PriceUnavailable'},
      ],
    });
  }
  if (p.endsWith('/bulk-release')) {
    return json({'succeeded': 1, 'failed': 0, 'items': <Object>[]});
  }
  if (p.endsWith('/customers') && m == 'GET') {
    return json({'items': <Object>[], 'totalCount': 0});
  }
  if (p.endsWith('/customers/c1') && m == 'GET') {
    return json({
      'customer': {'customerKey': 'c1', 'name': 'Ali'},
      'bookings': <Object>[],
      'notes': <Object>[],
    });
  }
  if (p.endsWith('/price-rules/preview')) {
    return json({
      'current': {'subtotal': 400, 'discount': 0, 'total': 400, 'deposit': 100},
    });
  }
  if (p.endsWith('/price-rules') && m == 'GET') return json(<Object>[]);
  if (p.endsWith('/booking-policy') && m == 'GET') {
    return json([
      {
        'version': 3,
        'isCurrent': true,
        'policy': {
          'depositType': 'Percentage',
          'depositValue': 30,
          'refundEligibility': 'PartialRefund',
          'noShowRule': 'NoPenalty',
          'proofSubmissionWindowMinutes': 15,
        },
      },
    ]);
  }
  if (p.endsWith('/special-schedules')) {
    return json({
      'exceptions': <Object>[],
      'pitchHours': <Object>[],
      'rules': <Object>[],
    });
  }
  if (p.endsWith('/schedules/impact')) {
    return json({'affectedBookings': <Object>[]});
  }
  if (p.endsWith('/weekly-hours')) {
    return ResponseBody.fromString(
      jsonEncode({
        'applied': false,
        'affectedBookings': [
          {
            'bookingId': 'b9',
            'reference': 'R9',
            'startUtc': '2026-01-01T18:00:00Z',
          },
        ],
      }),
      409,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
  if (p.endsWith('/reports')) {
    return json({
      'from': '2026-01-01',
      'to': '2026-01-07',
      'revenue': <String, Object>{},
    });
  }
  if (p.endsWith('/bookings.csv')) {
    return ResponseBody.fromString(
      'a,b',
      200,
      headers: {
        Headers.contentTypeHeader: ['text/csv'],
      },
    );
  }
  if (p.endsWith('/payouts')) return json({'balance': <String, Object>{}});
  if (p.endsWith('/staff') && m == 'GET') return json(<String, Object>{});
  if (p.endsWith('/pitches') && m == 'GET') return json([pitch()]);
  if (p.endsWith('/pitches') && m == 'POST') return json(pitch());
  if (p == '/api/v1/venue-manager/pitches/p1' && m == 'PUT') {
    return json(pitch());
  }
  if (p.endsWith('/active')) {
    return json({'pitch': pitch(), 'upcomingBookings': 2});
  }
  if (p == '/api/v1/media/uploads') {
    return json({
      'mediaId': 'm1',
      'uploadUrl': '/api/v1/media/m1/upload',
      'expiresAtUtc': '2030-01-01T00:00:00Z',
      'maxBytes': 1000,
    });
  }
  if (p == '/api/v1/me' && m == 'GET') {
    return json({
      'fullName': 'Owner',
      'phoneNumber': '+201',
      'email': 'o@x.com',
    });
  }
  if (p == '/api/v1/auth/step-up') return json({'stepUpToken': 'su'});
  if (p == '/api/v1/auth/2fa/totp/enroll') {
    return json({'secret': 'S', 'provisioningUri': 'otpauth://x'});
  }
  if (p == '/api/v1/me/phone-change/start') return json({'requestId': 'rq'});
  return empty();
}

void main() {
  late FakeHttpAdapter adapter;
  late Dio dio;

  setUpAll(CairoTime.initialize);
  setUp(() {
    adapter = FakeHttpAdapter(_respond);
    dio = Dio(BaseOptions(baseUrl: 'http://api'))..httpClientAdapter = adapter;
  });

  RequestOptions last() => adapter.requests.last;
  Map<String, dynamic> body() {
    final data = last().data;
    return data is Map<String, dynamic> ? data : jsonDecode(data as String);
  }

  void expectRequest(String method, String path) {
    expect(last().method, method);
    expect(last().path, path);
  }

  test(
    'owner sign-in sends the credentials and saves a venue session',
    () async {
      final env = _MockEnvConfig();
      when(() => env.turnstileToken).thenReturn('dev');
      final storage = FakeAuthTokenStorage();
      final repo = VenueAuthRepoImpl(
        apiService: VenueAuthApiService(dio),
        tokenStorage: storage,
        turnstileTokenProvider: TurnstileTokenProvider(envConfig: env),
      );
      expect(
        await repo.login(email: ' o@x.com ', password: 'p', totpCode: '123456'),
        isA<Success<void>>(),
      );
      expectRequest('POST', '/api/v1/auth/login');
      expect(body(), {
        'email': 'o@x.com',
        'password': 'p',
        'totpCode': '123456',
        'turnstileToken': 'dev',
      });
      expect(storage.venueSession, isTrue);
      expect(storage.refreshToken, 'rt');

      await repo.registerOwner(
        const RegisterOwnerRequestBody(
          fullName: 'O',
          email: 'o@x.com',
          phoneNumber: '+201012345678',
          password: '1234567890',
        ),
      );
      expectRequest('POST', '/api/v1/auth/register/venue-owner');
      expect(body()['phoneNumber'], '+201012345678');
      await repo.resendVerification('o@x.com');
      expectRequest('POST', '/api/v1/auth/email/resend');
      await repo.forgotPassword('o@x.com');
      expectRequest('POST', '/api/v1/auth/password/forgot');
      expect(body(), {'email': 'o@x.com'});
    },
  );

  test('shell, overview and bookings requests', () async {
    final shell = VenueShellRepoImpl(apiService: VenueShellApiService(dio));
    await shell.getVenues();
    expectRequest('GET', '/api/v1/venue-manager/venues');
    await shell.getPermissions();
    expectRequest('GET', '/api/v1/me/permissions');

    final overview = VenueOverviewRepoImpl(
      apiService: VenueOverviewApiService(dio),
    );
    expect(await overview.getDashboard('v1'), isA<Success<Object?>>());
    expectRequest('GET', '/api/v1/venue-manager/venues/v1/dashboard');
    await overview.getApproval('v1');
    expectRequest('GET', '/api/v1/venue-manager/venues/v1/approval');

    final bookings = VenueBookingsRepoImpl(
      apiService: VenueBookingsApiService(dio),
    );
    await bookings.getBookings(
      'v1',
      const VenueBookingsQuery(
        tab: VenueBookingsTab.pending,
        search: 'ali',
        pitchId: 'p1',
        source: VenueBookingsSource.manual,
        sort: VenueBookingsSort.priceDesc,
        range: VenueBookingsRange.today,
      ),
      page: 2,
    );
    expectRequest('GET', '/api/v1/venue-manager/venues/v1/bookings');
    final q = last().queryParameters;
    expect(q['statuses'], [2, 3, 4]);
    expect(q['search'], 'ali');
    expect(q['pitchId'], 'p1');
    expect(q['manual'], true);
    expect(q['sort'], 'price_desc');
    expect(q['page'], 2);
    expect(q['startDateUtc'], isA<String>());
    expect(q['endDateUtc'], isA<String>());
    // Repeated `statuses=2&statuses=3`, as ASP.NET binds arrays.
    expect(last().uri.query, contains('statuses=2&statuses=3&statuses=4'));

    await bookings.getBooking('v1', 'b1');
    expectRequest('GET', '/api/v1/venue-manager/venues/v1/bookings/b1');
    await bookings.confirmManual('v1', 'b1');
    expectRequest(
      'POST',
      '/api/v1/venue-manager/venues/v1/bookings/b1/confirm-deposit',
    );
    await bookings.cancel('v1', 'b1', ' rain ');
    expectRequest('POST', '/api/v1/venue-manager/venues/v1/bookings/b1/cancel');
    expect(body(), {'reason': 'rain'});
    await bookings.markNoShow('v1', 'b1', 'late');
    expectRequest(
      'POST',
      '/api/v1/venue-manager/venues/v1/bookings/b1/no-show',
    );
    expect(body(), {'reason': 'late'});
  });

  test('calendar, manual and bulk booking requests', () async {
    final repo = VenueCalendarRepoImpl(
      apiService: VenueCalendarApiService(dio),
    );
    final from = DateTime.utc(2026, 1, 1, 22);
    await repo.getCalendar(
      'v1',
      fromUtc: from,
      toUtc: from.add(const Duration(days: 2)),
      pitchId: 'p1',
    );
    expectRequest('GET', '/api/v1/venue-manager/venues/v1/calendar');
    expect(last().queryParameters['rangeStartUtc'], '2026-01-01T22:00:00.000Z');
    expect(last().queryParameters['pitchId'], 'p1');

    await repo.blockSlot(
      'v1',
      pitchId: 'p1',
      startUtc: from,
      endUtc: from.add(const Duration(hours: 2)),
      reason: ' fix ',
    );
    expectRequest('POST', '/api/v1/venue-manager/venues/v1/blocked-slots');
    expect(body()['reason'], 'fix');
    expect(body()['endUtc'], '2026-01-02T00:00:00.000Z');
    await repo.unblockSlot('v1', 's1');
    expectRequest('DELETE', '/api/v1/venue-manager/venues/v1/blocked-slots/s1');

    await repo.createManualBooking(
      'v1',
      const ManualBookingRequestBody(
        pitchId: 'p1',
        startUtc: 'a',
        endUtc: 'b',
        price: 400,
        paymentStatus: 1,
        depositAmount: 100,
      ),
    );
    expectRequest('POST', '/api/v1/venue-manager/venues/v1/bookings/manual');
    expect(body(), {
      'pitchId': 'p1',
      'startUtc': 'a',
      'endUtc': 'b',
      'price': 400.0,
      'currency': 'EGP',
      'paymentStatus': 1,
      'depositAmount': 100.0,
    });

    final bulk = await repo.bulkBook(
      'v1',
      hours: [
        CalendarHour(
          pitchId: 'p1',
          start: from,
          end: from.add(const Duration(hours: 1)),
        ),
      ],
      status: ManualPaymentStatus.unconfirmed,
      customerName: 'Ali',
    );
    expectRequest(
      'POST',
      '/api/v1/venue-manager/venues/v1/bookings/manual/bulk',
    );
    expect(body()['paymentStatus'], 3);
    expect(body()['customerName'], 'Ali');
    expect(body().containsKey('pricePerHour'), isFalse);
    final outcome = (bulk as Success<BulkOutcome>).data;
    expect(outcome.succeeded, 1);
    expect(outcome.failed, 1);
    expect(outcome.firstErrorCode, 'Booking.PriceUnavailable');

    final freed = await repo.release(
      'v1',
      bookingIds: ['b1'],
      blockedSlotIds: ['s1'],
    );
    expect((freed as Success<BulkOutcome>).data.succeeded, 2);
    expect(
      adapter.requests
          .map((r) => '${r.method} ${r.path}')
          .toList()
          .sublist(adapter.requests.length - 2),
      [
        'POST /api/v1/venue-manager/venues/v1/bookings/manual/bulk-release',
        'DELETE /api/v1/venue-manager/venues/v1/blocked-slots/s1',
      ],
    );

    await repo.searchCustomers('v1', ' ali ');
    expect(last().queryParameters['search'], 'ali');
    expect(
      await repo.previewPrice(
        'v1',
        pitchId: 'p1',
        startUtc: from,
        endUtc: from,
      ),
      400,
    );
    expectRequest(
      'POST',
      '/api/v1/venue-manager/venues/v1/price-rules/preview',
    );
  });

  test('setup and pitches requests', () async {
    final repo = VenueSetupRepoImpl(
      apiService: VenueSetupApiService(dio),
      dio: dio,
      imageSanitizer: const _PassThroughSanitizer(),
    );
    const form = VenueSetupForm(
      name: 'Venue',
      city: 'القاهرة',
      area: 'مدينة نصر',
      phoneNumber: '0100',
      address: 'st',
      description: '',
      facilities: ['parking'],
      latitude: 30,
      longitude: 31,
    );
    await repo.saveVenue(null, form);
    expectRequest('POST', '/api/v1/venue-manager/venues');
    expect(body()['description'], isNull);
    expect(body()['latitude'], 30.0);
    await repo.saveVenue('v1', form);
    expectRequest('PUT', '/api/v1/venue-manager/venues/v1');

    await repo.addPitch(
      'v1',
      name: ' P ',
      turfType: 'Grass',
      capacity: 7,
      photos: const [],
    );
    expectRequest('POST', '/api/v1/venue-manager/venues/v1/pitches');
    expect(body()['name'], 'P');
    await repo.deletePitch('p1');
    expectRequest('DELETE', '/api/v1/venue-manager/pitches/p1');
    const pitch = VenuePitchModel(
      id: 'p1',
      venueId: 'v1',
      name: 'P',
      turfType: 'Grass',
      capacity: 5,
      format: 'FiveASide',
      isActive: true,
    );
    await repo.updatePitch(
      pitch,
      name: 'P2',
      turfType: 'Grass',
      capacity: 6,
      lengthMeters: 40,
    );
    expectRequest('PUT', '/api/v1/venue-manager/pitches/p1');
    expect(body()['lengthMeters'], 40.0);
    expect(
      await repo.setPitchActive('p1', false),
      isA<Success<int>>().having((s) => s.data, 'upcoming', 2),
    );
    expectRequest('PUT', '/api/v1/venue-manager/pitches/p1/active');
    expect(body(), {'isActive': false});
    await repo.publishVenue('v1', true);
    expectRequest('POST', '/api/v1/venue-manager/venues/v1/publish');

    final upload = await repo.uploadImage(
      Uint8List.fromList([1, 2, 3]),
      VenueMediaPurpose.pitchPhoto,
    );
    expect((upload as Success<String>).data, '/api/v1/media/m1/medium');
    final ticketRequest = adapter.requests[adapter.requests.length - 2];
    expect(ticketRequest.path, '/api/v1/media/uploads');
    expect(ticketRequest.data, {'purpose': 1});
    expectRequest('PUT', '/api/v1/media/m1/upload');

    await repo.addVenuePhoto('v1', '/api/v1/media/m1/medium');
    expectRequest('POST', '/api/v1/venue-manager/venues/v1/gallery');
    expect(body(), {'mediaId': 'm1'});
    await repo.removePitchPhoto('v1', 'p1', '/api/v1/media/m1/medium');
    expectRequest(
      'DELETE',
      '/api/v1/venue-manager/venues/v1/pitches/p1/gallery/m1',
    );

    await repo.saveSchedules('v1', {
      ...DayHours.defaultWeek(),
      5: const DayHours(on: false, open: '14:00', close: '02:00'),
    });
    expectRequest('PUT', '/api/v1/venue-manager/venues/v1/schedules');
    final days = (body()['schedules'] as List).cast<Map<String, dynamic>>();
    expect(days.length, 6);
    expect(days.first, {
      'dayOfWeek': 6,
      'openTime': '16:00:00',
      'closeTime': '02:00:00',
      'slotDurationMinutes': 60,
      'isActive': true,
    });
    await repo.submitForReview('v1', '  ');
    expectRequest('POST', '/api/v1/venue-manager/venues/v1/approval/submit');
    expect(body(), {'message': null});
  });

  test('schedule requests and the 409 hold-back', () async {
    final repo = VenueScheduleRepoImpl(
      apiService: VenueScheduleApiService(dio),
    );
    await repo.previewVenueWeek('v1', DayHours.defaultWeek());
    expectRequest('POST', '/api/v1/venue-manager/venues/v1/schedules/impact');
    expect((body()['days'] as List).length, 7);

    final held = await repo.savePitchWeek(
      'v1',
      'p1',
      DayHours.defaultWeek(),
      confirm: false,
    );
    expectRequest(
      'PUT',
      '/api/v1/venue-manager/venues/v1/pitches/p1/weekly-hours',
    );
    expect(body()['confirm'], false);
    final change = (held as Success<ScheduleChangeResult>).data;
    expect(change.applied, isFalse);
    expect(change.affected.single.reference, 'R9');

    await repo.addOverride(
      'v1',
      startDate: '2026-02-01',
      kind: ScheduleOverrideKind.closure,
      fromTime: '15:00',
      reason: ' x ',
      confirm: true,
    );
    expectRequest('POST', '/api/v1/venue-manager/venues/v1/schedule-overrides');
    expect(body()['kind'], 0);
    expect(body()['fromTime'], isNull);
    expect(body()['endDate'], isNull);
    await repo.addOverride(
      'v1',
      startDate: '2026-02-01',
      kind: ScheduleOverrideKind.breakTime,
      fromTime: '15:00',
      toTime: '16:00',
      reason: 'b',
      confirm: false,
    );
    expect(body()['kind'], 2);
    expect(body()['fromTime'], '15:00:00');

    await repo.closeHolidays('v1', year: 2026, confirm: false);
    expectRequest(
      'POST',
      '/api/v1/venue-manager/venues/v1/schedule-overrides/holidays',
    );
    expect(body(), {'year': 2026, 'pitchId': null, 'confirm': false});
    await repo.removeOverride('v1', 'o1');
    expectRequest(
      'DELETE',
      '/api/v1/venue-manager/venues/v1/schedule-overrides/o1',
    );
    expect(last().queryParameters['confirm'], true);
    await repo.saveRules('v1', const BookingRulesModel(maxAdvanceDays: 30));
    expectRequest('PUT', '/api/v1/venue-manager/venues/v1/booking-rules');
    expect(body()['maxAdvanceDays'], 30);
  });

  test('pricing, policy and customer requests', () async {
    final pricing = VenuePricingRepoImpl(
      apiService: VenuePricingApiService(dio),
    );
    await pricing.getRules('v1');
    expectRequest('GET', '/api/v1/venue-manager/venues/v1/price-rules');
    await pricing.saveRule(
      'v1',
      PriceRuleDraft.empty(
        'Peak',
        'Peak',
      ).copyWith(value: '20', adjustment: 'Percentage'),
    );
    expectRequest('POST', '/api/v1/venue-manager/venues/v1/price-rules');
    expect(body()['kind'], 1);
    expect(body()['adjustment'], 1);
    expect(body()['percent'], 20.0);
    expect(body()['amount'], isNull);
    expect(body()['startTime'], '18:00:00');
    final edited = PriceRuleDraft.fromRule(
      const PriceRuleModel(
        id: 'r1',
        kind: 'Base',
        adjustment: 'FixedHourlyRate',
        name: 'B',
        amount: 300,
      ),
    );
    await pricing.saveRule('v1', edited);
    expectRequest('PUT', '/api/v1/venue-manager/venues/v1/price-rules/r1');
    expect(body()['amount'], 300.0);
    expect(body()['days'], isNull);
    await pricing.deleteRule('v1', 'r1');
    expectRequest('DELETE', '/api/v1/venue-manager/venues/v1/price-rules/r1');

    final policies = VenuePoliciesRepoImpl(
      apiService: VenuePoliciesApiService(dio),
    );
    final policy =
        (await policies.getPolicy('v1') as Success<BookingPolicyModel>).data;
    expect(policy.version, 3);
    expect(policy.values['refundEligibility'], 1);
    expect(policy.values['noShowRule'], 2);
    await policies.savePolicy(
      'v1',
      policy.patch({'lateArrivalGraceMinutes': 10}),
    );
    expectRequest('PUT', '/api/v1/venue-manager/venues/v1/booking-policy');
    expect(body()['lateArrivalGraceMinutes'], 10);
    expect(body()['refundEligibility'], 1);

    final customers = VenueCustomersRepoImpl(
      apiService: VenueCustomersApiService(dio),
    );
    await customers.getCustomers('v1', search: 'ali', page: 2);
    expect(last().queryParameters, {
      'search': 'ali',
      'page': 2,
      'pageSize': 25,
    });
    await customers.getCustomer('v1', 'c1');
    expectRequest('GET', '/api/v1/venue-manager/venues/v1/customers/c1');
    await customers.addNote('v1', 'c1', ' cash ');
    expectRequest('POST', '/api/v1/venue-manager/venues/v1/customers/c1/notes');
    expect(body(), {'text': 'cash'});
    await customers.deleteNote('v1', 'c1', 'n1');
    expectRequest(
      'DELETE',
      '/api/v1/venue-manager/venues/v1/customers/c1/notes/n1',
    );
  });

  test('reports, staff and account requests', () async {
    final reports = VenueReportsRepoImpl(
      apiService: VenueReportsApiService(dio),
    );
    await reports.getReport(
      'v1',
      from: '2026-01-01',
      to: '2026-01-07',
      groupBy: 0,
    );
    expect(last().queryParameters, {
      'from': '2026-01-01',
      'to': '2026-01-07',
      'groupBy': 0,
    });
    final csv = await reports.exportBookingsCsv(
      'v1',
      from: 'a',
      to: 'b',
      pitchId: 'p1',
    );
    expectRequest(
      'GET',
      '/api/v1/venue-manager/venues/v1/reports/bookings.csv',
    );
    expect(utf8.decode((csv as Success<List<int>>).data), 'a,b');
    await reports.getPayouts('v1');
    expectRequest('GET', '/api/v1/venue-manager/venues/v1/payouts');

    final staff = VenueStaffRepoImpl(apiService: VenueStaffApiService(dio));
    await staff.getStaff('v1');
    expectRequest('GET', '/api/v1/venue-manager/venues/v1/staff');
    await staff.invite('v1', '010 1234 5678', 'Accountant');
    expectRequest('POST', '/api/v1/venue-manager/venues/v1/staff/invitations');
    expect(body(), {'email': null, 'phoneNumber': '01012345678', 'role': 2});
    await staff.invite('v1', 'a@b.com', 'Manager');
    expect(body(), {'email': 'a@b.com', 'phoneNumber': null, 'role': 0});
    await staff.resendInvitation('v1', 'i1');
    expectRequest(
      'POST',
      '/api/v1/venue-manager/venues/v1/staff/invitations/i1/resend',
    );
    await staff.cancelInvitation('v1', 'i1');
    expectRequest(
      'DELETE',
      '/api/v1/venue-manager/venues/v1/staff/invitations/i1',
    );
    await staff.changeRole('v1', 'm1', 'Receptionist');
    expectRequest('PUT', '/api/v1/venue-manager/venues/v1/staff/members/m1');
    expect(body(), {'role': 1});
    await staff.removeMember('v1', 'm1');
    expectRequest('DELETE', '/api/v1/venue-manager/venues/v1/staff/members/m1');

    final account = VenueAccountRepoImpl(
      apiService: VenueAccountApiService(dio),
    );
    final profile = await account.getProfile();
    expect((profile as Success).data, isNotNull);
    await account.updateName(' Owner ');
    expectRequest('PATCH', '/api/v1/me');
    expect(body(), {'fullName': 'Owner'});
    await account.changePassword('old', 'new-password');
    expectRequest('POST', '/api/v1/auth/password/change');
    expect(body(), {'currentPassword': 'old', 'newPassword': 'new-password'});
    expect(
      (await account.enrollTotp() as Success<(String, String)>).data.$1,
      'S',
    );
    await account.confirmTotp('123456');
    expectRequest('POST', '/api/v1/auth/2fa/totp/confirm');

    await account.startEmailChange('n@x.com', 'pw');
    final stepUp = adapter.requests[adapter.requests.length - 2];
    expect(stepUp.path, '/api/v1/auth/step-up');
    expect(stepUp.data, {'scope': 'change_email', 'method': 0, 'secret': 'pw'});
    expectRequest('POST', '/api/v1/me/email-change/start');
    expect(body(), {'newEmail': 'n@x.com', 'stepUpToken': 'su'});
    await account.confirmEmailChange('111111');
    expectRequest('POST', '/api/v1/me/email-change/confirm');

    final requestId = await account.startPhoneChange('+201099999999', 'pw');
    expect((requestId as Success<String>).data, 'rq');
    expect(body(), {'newPhoneNumber': '+201099999999', 'stepUpToken': 'su'});
    await account.verifyOldPhone('rq', '1');
    expectRequest('POST', '/api/v1/me/phone-change/verify-old');
    await account.verifyNewPhone('rq', '2');
    expectRequest('POST', '/api/v1/me/phone-change/verify-new');
    expect(body(), {'requestId': 'rq', 'code': '2'});
  });
}
