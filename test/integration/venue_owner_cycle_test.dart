@Tags(['integration'])
library;

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:mal3abk/core/config/env_config.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/turnstile_token_provider.dart';
import 'package:mal3abk/core/utils/cairo_time.dart';
import 'package:mal3abk/features/notifications/data/apis/notifications_api_service.dart';
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
import 'package:mal3abk/features/venue_calendar/presentation/cubit/venue_calendar_cubit.dart';
import 'package:mal3abk/features/venue_customers/data/apis/venue_customers_api_service.dart';
import 'package:mal3abk/features/venue_customers/data/repos/venue_customers_repo_impl.dart';
import 'package:mal3abk/features/venue_notifications/presentation/cubit/venue_notifications_cubit.dart';
import 'package:mal3abk/features/venue_overview/data/apis/venue_overview_api_service.dart';
import 'package:mal3abk/features/venue_overview/data/repos/venue_overview_repo_impl.dart';
import 'package:mal3abk/features/venue_policies/data/apis/venue_policies_api_service.dart';
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
import 'package:mal3abk/features/venue_shell/data/models/my_permissions_model.dart';
import 'package:mal3abk/features/venue_shell/data/repos/venue_shell_repo_impl.dart';
import 'package:mal3abk/features/venue_staff/data/apis/venue_staff_api_service.dart';
import 'package:mal3abk/features/venue_staff/data/repos/venue_staff_repo_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fake_auth_token_storage.dart';
import 'support/local_stack.dart';

class _Env extends Mock implements EnvConfig {}

/// Everything a venue owner does from the app, against the local stack (API
/// on :5000, Mailpit on :8025): sign up, activate by text, sign in, set the
/// venue up, prices, hours, closures, manual and bulk bookings, blocks,
/// bookings list and actions, customers, reports, payouts, staff, account.
/// Uses the app's own API services and repos. Skips when the stack is down.
void main() {
  var up = false;
  setUpAll(() async {
    CairoTime.initialize();
    up = await LocalStack.start();
  });

  test('venue owner full cycle', () async {
    if (!LocalStack.ready(up)) return;
    final api = LocalStack.apiUrl;
    final env = _Env();
    when(() => env.turnstileToken).thenReturn('dev');
    final storage = FakeAuthTokenStorage();
    final anon = paced(Dio(BaseOptions(baseUrl: api)));
    final auth = VenueAuthRepoImpl(
      apiService: VenueAuthApiService(anon),
      tokenStorage: storage,
      turnstileTokenProvider: TurnstileTokenProvider(envConfig: env),
    );

    // 1. Sign up from the app; the activation link arrives by text.
    final phone = LocalStack.newPhone();
    final email = 'owner.${LocalStack.runId}@malabak.local';
    const password = 'Pitch-Owner-2026!';
    ok(
      await auth.registerOwner(
        RegisterOwnerRequestBody(
          fullName: 'Cycle Owner',
          email: email,
          phoneNumber: phone,
          password: password,
        ),
      ),
      'register',
    );
    expect(
      await auth.login(email: email, password: password),
      isA<ApiFailure<void>>().having(
        (f) => f.failure.code,
        'code',
        'Identity.EmailNotVerified',
      ),
    );
    final token = await _activationToken(phone);
    await anon.post<dynamic>(
      '/api/v1/auth/email/verify',
      data: {'token': token},
    );

    // 2. Sign in: the session is a venue one.
    ok(await auth.login(email: email, password: password), 'login');
    expect(storage.venueSession, isTrue);
    final dio = paced(
      Dio(
        BaseOptions(
          baseUrl: api,
          headers: {'Authorization': 'Bearer ${storage.accessToken}'},
        ),
      ),
    );

    final shell = VenueShellRepoImpl(apiService: VenueShellApiService(dio));
    expect(ok(await shell.getVenues(), 'venues'), isEmpty);

    // 3. Set the venue up.
    final setup = VenueSetupRepoImpl(
      apiService: VenueSetupApiService(dio),
      dio: dio,
    );
    final venue = ok(
      await setup.saveVenue(
        null,
        const VenueSetupForm(
          name: 'Cycle Arena',
          city: 'القاهرة',
          area: 'مدينة نصر',
          phoneNumber: '01012345678',
          address: '1 Test St',
          description: 'From the app cycle',
          facilities: [],
          latitude: 30.05,
          longitude: 31.33,
        ),
      ),
      'create venue',
    );
    final venueId = venue.id;
    expect(venue.approvalStatus, 'Draft');

    final photo = img.encodePng(img.Image(width: 32, height: 32));
    final photoPath = ok(
      await setup.uploadImage(photo, VenueMediaPurpose.venuePhoto),
      'upload venue photo',
    );
    ok(await setup.addVenuePhoto(venueId, photoPath), 'add venue photo');

    ok(
      await setup.addPitch(
        venueId,
        name: 'Pitch A',
        turfType: 'ArtificialTurf',
        capacity: 5,
        photos: const [],
      ),
      'add pitch',
    );
    final pitches = ok(await setup.getPitches(venueId), 'pitches');
    final pitch = pitches.single;
    final pitchPhoto = ok(
      await setup.uploadImage(photo, VenueMediaPurpose.pitchPhoto),
      'pitch photo',
    );
    ok(
      await setup.addPitchPhoto(venueId, pitch.id, pitchPhoto),
      'add pitch photo',
    );
    ok(
      await setup.updatePitch(
        pitch,
        name: 'Pitch A1',
        turfType: pitch.turfType,
        capacity: 6,
        lengthMeters: 40,
        widthMeters: 20,
      ),
      'edit pitch',
    );

    // Open every day 08:00 – 02:00 so the slots below are inside the hours.
    final week = {
      for (final d in DayHours.dayOrder)
        d: const DayHours(on: true, open: '08:00', close: '02:00'),
    };
    ok(await setup.saveSchedules(venueId, week), 'hours');

    final venues = ok(await shell.getVenues(), 'venues after setup');
    expect(
      venues.single.photos.map(VenueSetupRepoImpl.mediaIdOf),
      contains(VenueSetupRepoImpl.mediaIdOf(photoPath)),
    );
    final perms = ok(await shell.getPermissions(), 'permissions');
    expect(perms.forVenue(venueId), contains(VenuePermissions.bookingsApprove));

    // 4. Prices: a base price, a discount, try it.
    final pricing = VenuePricingRepoImpl(
      apiService: VenuePricingApiService(dio),
    );
    ok(
      await pricing.saveRule(
        venueId,
        PriceRuleDraft.empty('Base', 'Base').copyWith(value: '300'),
      ),
      'base price',
    );
    final tomorrow = CairoTime.today().add(const Duration(days: 2));
    final start = VenueCalendarCubit.dayStartUtc(
      tomorrow,
    ).add(const Duration(hours: 20));
    final quote = ok(
      await pricing.preview(
        venueId,
        pitchId: pitch.id,
        startUtc: start,
        endUtc: start.add(const Duration(hours: 1)),
      ),
      'price preview',
    );
    expect(quote.total, 300);
    ok(
      await pricing.saveRule(
        venueId,
        PriceRuleDraft.discount(
          name: 'Cycle deal',
          today:
              '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-01',
          weekLater: '${tomorrow.year + 1}-01-01',
        ).copyWith(value: '10'),
      ),
      'discount',
    );
    final rules = ok(await pricing.getRules(venueId), 'rules');
    expect(rules.map((r) => r.kind), containsAll(['Base', 'Discount']));
    final discount = rules.firstWhere((r) => r.kind == 'Discount');
    ok(
      await pricing.saveRule(
        venueId,
        PriceRuleDraft.fromRule(discount).copyWith(isActive: false),
      ),
      'pause discount',
    );
    ok(await pricing.deleteRule(venueId, discount.id), 'delete discount');

    // 5. Hours: impact check, booking rules, a closure and its removal.
    final schedule = VenueScheduleRepoImpl(
      apiService: VenueScheduleApiService(dio),
    );
    ok(await schedule.previewVenueWeek(venueId, week), 'hours impact');
    ok(
      await schedule.saveRules(
        venueId,
        const BookingRulesModel(maxAdvanceDays: 30),
      ),
      'booking rules',
    );
    final closureDay = CairoTime.today().add(const Duration(days: 20));
    final closure = ok(
      await schedule.addOverride(
        venueId,
        startDate:
            '${closureDay.year}-${closureDay.month.toString().padLeft(2, '0')}-${closureDay.day.toString().padLeft(2, '0')}',
        kind: ScheduleOverrideKind.closure,
        reason: 'Cycle maintenance',
        confirm: false,
      ),
      'closure',
    );
    expect(closure.applied, isTrue);
    final special = ok(
      await schedule.getSpecialSchedules(venueId),
      'special schedules',
    );
    ok(
      await schedule.removeOverride(venueId, special.exceptions.single.id),
      'remove closure',
    );

    // 6. Policies.
    final policies = VenuePoliciesRepoImpl(
      apiService: VenuePoliciesApiService(dio),
    );
    final policy = ok(await policies.getPolicy(venueId), 'policy');
    ok(
      await policies.savePolicy(
        venueId,
        policy.patch({'lateArrivalGraceMinutes': 10}),
      ),
      'save policy',
    );
    expect(
      ok(
        await policies.getPolicy(venueId),
        'policy again',
      ).values['lateArrivalGraceMinutes'],
      10,
    );

    // 7. Calendar: block and unblock, a manual booking, bulk hold and free.
    final calendar = VenueCalendarRepoImpl(
      apiService: VenueCalendarApiService(dio),
    );
    ok(
      await calendar.blockSlot(
        venueId,
        pitchId: pitch.id,
        startUtc: start,
        endUtc: start.add(const Duration(hours: 1)),
        reason: 'Cycle block',
      ),
      'block',
    );
    var slots = ok(
      await calendar.getCalendar(
        venueId,
        fromUtc: start,
        toUtc: start.add(const Duration(hours: 6)),
        pitchId: pitch.id,
      ),
      'calendar',
    );
    final block = slots.singleWhere((s) => s.isBlocked);
    ok(await calendar.unblockSlot(venueId, block.id), 'unblock');

    final bookingStart = start.add(const Duration(hours: 1));
    ok(
      await calendar.createManualBooking(
        venueId,
        ManualBookingRequestBody(
          pitchId: pitch.id,
          startUtc: bookingStart.toIso8601String(),
          endUtc: bookingStart.add(const Duration(hours: 1)).toIso8601String(),
          price: 300,
          paymentStatus: ManualPaymentStatus.deposit.value,
          depositAmount: 100,
          customerName: 'Cycle Customer',
          customerPhone: '01098765432',
        ),
      ),
      'manual booking',
    );
    final bulk = ok(
      await calendar.bulkBook(
        venueId,
        hours: [
          for (var h = 2; h <= 3; h++)
            CalendarHour(
              pitchId: pitch.id,
              start: start.add(Duration(hours: h)),
              end: start.add(Duration(hours: h + 1)),
            ),
        ],
        status: ManualPaymentStatus.unconfirmed,
      ),
      'bulk hold',
    );
    // Consecutive hours on one pitch become a single booking.
    expect(bulk.succeeded, 1);
    expect(bulk.failed, 0);
    slots = ok(
      await calendar.getCalendar(
        venueId,
        fromUtc: start,
        toUtc: start.add(const Duration(hours: 6)),
        pitchId: pitch.id,
      ),
      'calendar after bookings',
    );
    expect(slots.length, 2);
    final held = slots.where((s) => s.isTentative).map((s) => s.id).toList();
    expect(held.length, 1);
    final freed = ok(
      await calendar.release(
        venueId,
        bookingIds: held,
        blockedSlotIds: const [],
      ),
      'free held',
    );
    expect(freed.succeeded, 1);
    final customers = ok(
      await calendar.searchCustomers(venueId, 'Cycle'),
      'customer search',
    );
    expect(customers.single.name, 'Cycle Customer');

    // 8. Bookings list, details and the venue's actions.
    final bookings = VenueBookingsRepoImpl(
      apiService: VenueBookingsApiService(dio),
    );
    final page = ok(
      await bookings.getBookings(
        venueId,
        const VenueBookingsQuery(
          tab: VenueBookingsTab.confirmed,
          source: VenueBookingsSource.manual,
        ),
      ),
      'bookings',
    );
    final booking = page.items.single;
    expect(booking.customerName, 'Cycle Customer');
    final detail = ok(
      await bookings.getBooking(venueId, booking.id),
      'booking detail',
    );
    expect(detail.depositAmount, 100);
    ok(await bookings.cancel(venueId, booking.id, 'Cycle cancel'), 'cancel');
    final closed = ok(
      await bookings.getBookings(
        venueId,
        const VenueBookingsQuery(tab: VenueBookingsTab.closed),
      ),
      'closed bookings',
    );
    expect(closed.items.map((b) => b.id), contains(booking.id));

    // 9. Customers with a staff note.
    final customerRepo = VenueCustomersRepoImpl(
      apiService: VenueCustomersApiService(dio),
    );
    final customer = ok(
      await customerRepo.getCustomers(venueId),
      'customers',
    ).items.single;
    ok(
      await customerRepo.addNote(venueId, customer.customerKey, 'Pays cash'),
      'note',
    );
    final profile = ok(
      await customerRepo.getCustomer(venueId, customer.customerKey),
      'customer detail',
    );
    expect(profile.notes.single.text, 'Pays cash');
    ok(
      await customerRepo.deleteNote(
        venueId,
        customer.customerKey,
        profile.notes.single.id,
      ),
      'delete note',
    );

    // 10. Overview, reports, CSV and payouts.
    final overview = VenueOverviewRepoImpl(
      apiService: VenueOverviewApiService(dio),
    );
    ok(await overview.getDashboard(venueId), 'dashboard');
    ok(await overview.getApproval(venueId), 'approval');
    final reports = VenueReportsRepoImpl(
      apiService: VenueReportsApiService(dio),
    );
    final from = CairoTime.today();
    final to = from.add(const Duration(days: 6));
    String d(DateTime x) =>
        '${x.year}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}';
    ok(
      await reports.getReport(venueId, from: d(from), to: d(to), groupBy: 0),
      'report',
    );
    final csv = ok(
      await reports.exportBookingsCsv(venueId, from: d(from), to: d(to)),
      'csv',
    );
    expect(csv, isNotEmpty);
    ok(await reports.getPayouts(venueId), 'payouts');

    // 11. Staff: invite, see it pending, cancel.
    final staff = VenueStaffRepoImpl(apiService: VenueStaffApiService(dio));
    ok(
      await staff.invite(
        venueId,
        'staff.${LocalStack.runId}@malabak.local',
        'Receptionist',
      ),
      'invite',
    );
    final team = ok(await staff.getStaff(venueId), 'staff');
    final invitation = team.pendingInvitations.single;
    ok(
      await staff.resendInvitation(venueId, invitation.invitationId),
      'resend invite',
    );
    final again = ok(
      await staff.getStaff(venueId),
      'staff again',
    ).pendingInvitations.single;
    ok(
      await staff.cancelInvitation(venueId, again.invitationId),
      'cancel invite',
    );

    // 12. Pause and resume the pitch; send the venue for review.
    ok(await setup.setPitchActive(pitch.id, false), 'pause pitch');
    ok(await setup.setPitchActive(pitch.id, true), 'resume pitch');
    final approval = ok(
      await setup.submitForReview(venueId, 'From the app'),
      'submit',
    );
    expect(approval.approvalStatus, 'Submitted');

    // 13. Notifications of the venue surface.
    final notifications = VenueNotificationsCubit(
      notificationsApiService: NotificationsApiService(dio),
    );
    await notifications.load();
    expect(notifications.state.error, isNull);
    await notifications.close();

    // 14. Account: name, two-factor enrollment, password change.
    final account = VenueAccountRepoImpl(
      apiService: VenueAccountApiService(dio),
    );
    expect(ok(await account.getProfile(), 'profile').email, email);
    ok(await account.updateName('Cycle Owner 2'), 'rename');
    expect(
      ok(await account.enrollTotp(), 'totp enroll').$2,
      startsWith('otpauth://'),
    );
    const newPassword = 'Pitch-Owner-2027!';
    ok(await account.changePassword(password, newPassword), 'change password');
    ok(
      await auth.login(email: email, password: newPassword),
      'login with new password',
    );
  }, timeout: const Timeout(Duration(minutes: 5)));
}

/// The activation token from the text message Mailpit captured.
Future<String> _activationToken(String phone) async {
  final digits = phone.replaceAll('+', '');
  for (var i = 0; i < 60; i++) {
    final list = await LocalStack.plain.get<Map<String, dynamic>>(
      '${LocalStack.mailpitUrl}/api/v1/search',
      queryParameters: {'query': 'to:sms+$digits@malabak.local'},
    );
    for (final m
        in (list.data!['messages'] as List).cast<Map<String, dynamic>>()) {
      final detail = await LocalStack.plain.get<Map<String, dynamic>>(
        '${LocalStack.mailpitUrl}/api/v1/message/${m['ID']}',
      );
      final match = RegExp(
        r'token=([A-Za-z0-9_\-%.~]+)',
      ).firstMatch(detail.data!['Text'] as String);
      if (match != null) return Uri.decodeComponent(match.group(1)!);
    }
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
  throw TestFailure(
    'no activation text reached Mailpit for $phone (${Platform.localHostname})',
  );
}
