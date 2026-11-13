@Tags(['integration'])
library;

import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:mal3abk/core/config/env_config.dart';
import 'package:mal3abk/core/device/device_identity_provider.dart';
import 'package:mal3abk/core/di/service_locator.dart';
import 'package:mal3abk/core/local_storage/auth_token_storage.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/auth/domain/use_cases/send_otp_use_case.dart';
import 'package:mal3abk/features/auth/domain/use_cases/verify_otp_use_case.dart';
import 'package:mal3abk/features/booking/data/models/booking_quote_request_body.dart';
import 'package:mal3abk/features/booking/data/models/booking_status.dart';
import 'package:mal3abk/features/booking/data/models/create_booking_request_body.dart';
import 'package:mal3abk/features/booking/domain/repos/booking_repo.dart';
import 'package:mal3abk/features/booking/domain/use_cases/create_booking_use_case.dart';
import 'package:mal3abk/features/booking/domain/use_cases/get_booking_detail_use_case.dart';
import 'package:mal3abk/features/booking/domain/use_cases/get_booking_quote_use_case.dart';
import 'package:mal3abk/features/booking/domain/use_cases/get_my_bookings_use_case.dart';
import 'package:mal3abk/features/explore/data/models/venue_availability_model.dart';
import 'package:mal3abk/features/explore/domain/use_cases/explore_venues_use_case.dart';
import 'package:mal3abk/features/explore/domain/use_cases/get_venue_availability_use_case.dart';
import 'package:mal3abk/features/explore/domain/use_cases/get_venue_pitches_use_case.dart';
import 'package:mal3abk/features/profile/data/models/complete_profile_request_body.dart';
import 'package:mal3abk/features/profile/data/models/player_attributes.dart';
import 'package:mal3abk/features/profile/domain/use_cases/get_my_profile_use_case.dart';
import 'package:mal3abk/features/profile/domain/use_cases/save_profile_use_case.dart';
import 'package:mal3abk/features/teams/data/models/create_team_request_body.dart';
import 'package:mal3abk/features/teams/domain/repos/teams_repo.dart';
import 'package:mal3abk/features/teams/domain/use_cases/create_team_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The player's whole journey through the app's real use cases, repos, Dio
/// stack and interceptors, against the local API (the `dev` flavor).
///
/// Needs the API on `DevEnvConfig.baseUrl` (host loopback here) delivering
/// OTP codes to Mailpit (`Identity:OtpDelivery:Provider=Sms` with no SMS
/// providers) on 127.0.0.1:8025. Run it with:
///
///     fvm flutter test test/integration/local_full_cycle_test.dart
///
/// It is skipped by `fvm flutter test --exclude-tags integration`, which is
/// what CI uses.
void main() {
  const mailpitUrl = 'http://127.0.0.1:8025';

  late _FakeDeviceIdentityProvider deviceIdentity;
  late Dio mailpit;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    // The test binding answers every HTTP request with 400; this suite talks
    // to the real local API.
    HttpOverrides.global = null;
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
    deviceIdentity = _FakeDeviceIdentityProvider();
    await setupServiceLocator(const _LoopbackDevEnv());
    await sl.unregister<DeviceIdentityProvider>();
    sl.registerSingleton<DeviceIdentityProvider>(deviceIdentity);
    mailpit = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 2),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
  });

  tearDownAll(() => sl.reset());

  Future<bool> localStackIsUp() async {
    try {
      await mailpit.get<dynamic>('$mailpitUrl/api/v1/messages');
      await Dio().get<dynamic>(
        '${sl<EnvConfig>().baseUrl}/api/v1/ping',
        options: Options(receiveTimeout: const Duration(seconds: 3)),
      );
      return true;
    } on DioException {
      return false;
    }
  }

  Future<String> latestOtpFor(String normalizedPhone) async {
    final digits = normalizedPhone.replaceAll('+', '');
    // Mailpit indexes messages by recipient tag; the newest one is first.
    final list = await mailpit.get<Map<String, dynamic>>(
      '$mailpitUrl/api/v1/search',
      queryParameters: {'query': 'to:sms+$digits@malabak.local'},
    );
    final messages = (list.data!['messages'] as List)
        .cast<Map<String, dynamic>>();
    expect(messages, isNotEmpty, reason: 'no OTP message for the player');
    final detail = await mailpit.get<Map<String, dynamic>>(
      '$mailpitUrl/api/v1/message/${messages.first['ID']}',
    );
    final code = RegExp(
      r'\b[0-9]{6}\b',
    ).firstMatch(detail.data!['Text'] as String)?.group(0);
    expect(code, isNotNull);
    return code!;
  }

  T unwrap<T>(ApiResult<T> result, String step) => result.when(
    success: (data) => data,
    failure: (failure) =>
        throw TestFailure('$step failed: ${failure.code} ${failure.message}'),
  );

  test('a new player signs up, books a pitch, pays, cancels and builds a '
      'team', () async {
    if (!await localStackIsUp()) {
      markTestSkipped('local API or Mailpit is not running');
      return;
    }

    // --- 1. Sign in with a phone number that has never been used ---------
    final phone = '010${10000000 + Random().nextInt(89999999)}';
    final sent = unwrap(await sl<SendOtpUseCase>()(phone), 'send otp');
    final code = await latestOtpFor(sent.normalizedPhoneNumber);

    final verified = unwrap(
      await sl<VerifyOtpUseCase>()(
        phoneNumber: sent.normalizedPhoneNumber,
        code: code,
      ),
      'verify otp',
    );
    expect(verified.isNewUser, isTrue, reason: 'first sign-in is a sign-up');
    expect(await sl<AuthTokenStorage>().hasSession(), isTrue);

    // A used code cannot be replayed.
    final replay = await sl<VerifyOtpUseCase>()(
      phoneNumber: sent.normalizedPhoneNumber,
      code: code,
    );
    expect(replay, isA<ApiFailure<dynamic>>());
    // The failed replay must not have signed the player out.
    expect(await sl<AuthTokenStorage>().hasSession(), isTrue);

    // --- 2. Finish the profile --------------------------------------------
    unwrap(
      await sl<SaveProfileUseCase>()(
        const CompleteProfileRequestBody(
          fullName: 'لاعب تجريبي',
          city: 'Cairo',
          area: 'Maadi',
          positions: [PlayerPosition.forward],
          skillLevel: SkillLevel.intermediate,
          language: 'ar',
        ),
        isOnboarding: true,
      ),
      'save profile',
    );
    final profile = unwrap(await sl<GetMyProfileUseCase>()(), 'get my profile');
    expect(profile.userId, verified.userId);
    expect(profile.fullName, 'لاعب تجريبي');

    // --- 3. Find a venue and a free slot ---------------------------------
    final explored = unwrap(await sl<ExploreVenuesUseCase>()(), 'explore');
    expect(explored.items, isNotEmpty, reason: 'the demo venues are seeded');
    final venue = explored.items.first;

    final pitches = unwrap(
      await sl<GetVenuePitchesUseCase>()(venue.venueId),
      'venue pitches',
    );
    expect(pitches, isNotEmpty);

    // Ten days out so the demo bookings the seeder created never collide.
    final day = DateTime.now().toUtc().add(const Duration(days: 10));
    final date =
        '${day.year}-${day.month.toString().padLeft(2, '0')}-'
        '${day.day.toString().padLeft(2, '0')}';
    final availability = unwrap(
      await sl<GetVenueAvailabilityUseCase>()(venue.venueId, date),
      'availability',
    );
    final (pitch, slot) = _firstFreeSlot(availability);

    // --- 4. Quote, then hold the slot -------------------------------------
    final quote = unwrap(
      await sl<GetBookingQuoteUseCase>()(
        BookingQuoteRequestBody(
          pitchId: pitch.pitchId,
          startUtc: slot.startUtc,
          endUtc: slot.endUtc,
        ),
      ),
      'quote',
    );
    expect(quote.total, greaterThan(0));
    expect(quote.deposit, lessThanOrEqualTo(quote.total));

    // A fresh key per run, as the app does: the API keeps keys for 24 hours.
    final runId = DateTime.now().microsecondsSinceEpoch;
    final idempotencyKey = 'cycle-create-$runId';
    final body = CreateBookingRequestBody(
      pitchId: pitch.pitchId,
      startUtc: slot.startUtc,
      endUtc: slot.endUtc,
      quoteToken: quote.quoteToken,
      expectedPrice: quote.total,
    );
    final created = unwrap(
      await sl<CreateBookingUseCase>()(
        body: body,
        idempotencyKey: idempotencyKey,
      ),
      'create booking',
    );

    // Retrying the same tap returns the same booking, not a second one.
    final retried = unwrap(
      await sl<CreateBookingUseCase>()(
        body: body,
        idempotencyKey: idempotencyKey,
      ),
      'create booking (retry)',
    );
    expect(retried.bookingId, created.bookingId);

    // The same slot is no longer free for anyone else.
    final taken = unwrap(
      await sl<GetVenueAvailabilityUseCase>()(venue.venueId, date),
      'availability after hold',
    );
    expect(
      taken.pitches
          .firstWhere((p) => p.pitchId == pitch.pitchId)
          .slots
          .firstWhere((s) => s.startUtc == slot.startUtc)
          .isAvailable,
      isFalse,
    );

    // --- 5. The hold shows up in my bookings ------------------------------
    final mine = unwrap(
      await sl<GetMyBookingsUseCase>()(page: 1, pageSize: 20),
      'my bookings',
    );
    expect(mine.items.map((b) => b.id), contains(created.bookingId));

    var detail = unwrap(
      await sl<GetBookingDetailUseCase>()(created.bookingId),
      'booking detail',
    );
    expect(detail.status, BookingStatus.pendingDeposit);
    expect(detail.holdExpiresAtUtc, isNotNull);

    // --- 6. Upload the payment proof and submit it ------------------------
    final bookingRepo = sl<BookingRepo>();
    final methods = unwrap(
      await bookingRepo.getPaymentMethods(created.bookingId),
      'payment methods',
    );
    expect(methods, isNotNull);

    final ticket = unwrap(
      await bookingRepo.getProofUploadUrl(created.bookingId),
      'proof upload url',
    );
    unwrap(
      await bookingRepo.uploadMediaFile(
        uploadUrl: ticket.uploadUrl,
        bytes: _tinyPng(),
        contentType: 'image/png',
      ),
      'upload proof',
    );
    unwrap(
      await bookingRepo.submitProof(
        id: created.bookingId,
        mediaId: ticket.mediaId,
        notes: 'تحويل إنستاباي',
      ),
      'submit proof',
    );
    detail = unwrap(
      await sl<GetBookingDetailUseCase>()(created.bookingId),
      'booking detail after proof',
    );
    expect(detail.status, BookingStatus.proofSubmitted);
    expect(detail.proofs, hasLength(1));

    // --- 7. Cancel, which frees the slot again ----------------------------
    final preview = unwrap(
      await bookingRepo.getCancelPreview(created.bookingId),
      'cancel preview',
    );
    expect(preview, isNotNull);
    unwrap(
      await bookingRepo.cancelBooking(
        created.bookingId,
        idempotencyKey: 'cycle-cancel-$runId',
        reason: 'تغيير في الخطة',
      ),
      'cancel booking',
    );
    detail = unwrap(
      await sl<GetBookingDetailUseCase>()(created.bookingId),
      'booking detail after cancel',
    );
    expect(detail.status, BookingStatus.cancelled);

    // --- 8. Create a team -------------------------------------------------
    final team = unwrap(
      await sl<CreateTeamUseCase>()(
        CreateTeamRequestBody(
          name: 'فريق ${Random().nextInt(9999)}',
          city: 'Cairo',
          governorate: 'Cairo',
        ),
        isPublic: true,
      ),
      'create team',
    );
    final myTeams = unwrap(await sl<TeamsRepo>().getMyTeams(), 'my teams');
    expect(myTeams.map((t) => t.id), contains(team.id));
  }, timeout: const Timeout(Duration(minutes: 3)));
}

(PitchSlotsModel, SlotModel) _firstFreeSlot(VenueAvailabilityModel a) {
  for (final pitch in a.pitches) {
    for (final slot in pitch.slots) {
      if (slot.isAvailable) return (pitch, slot);
    }
  }
  throw TestFailure('no free slot on ${a.businessDate}');
}

/// A different image every run: the API rejects a receipt it has seen before.
List<int> _tinyPng() {
  final random = Random();
  final image = img.Image(width: 64, height: 64);
  for (final pixel in image) {
    pixel
      ..r = random.nextInt(256)
      ..g = random.nextInt(256)
      ..b = random.nextInt(256);
  }
  return img.encodePng(image);
}

class _FakeDeviceIdentityProvider extends Fake
    implements DeviceIdentityProvider {
  @override
  Future<DeviceIdentity> read() async =>
      const DeviceIdentity(name: 'Test device', userAgent: 'Malabak/test');
}

/// [DevEnvConfig] picks the Android emulator address under `flutter test`
/// (the test binding reports Android); the suite runs on the host.
class _LoopbackDevEnv extends DevEnvConfig {
  const _LoopbackDevEnv();

  @override
  String get baseUrl => 'http://127.0.0.1:5000';
}
