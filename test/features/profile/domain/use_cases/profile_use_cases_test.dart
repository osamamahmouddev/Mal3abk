import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/booking/domain/repos/booking_repo.dart';
import 'package:mal3abk/features/profile/data/models/complete_profile_request_body.dart';
import 'package:mal3abk/features/profile/data/models/my_profile_model.dart';
import 'package:mal3abk/features/profile/data/models/player_attributes.dart';
import 'package:mal3abk/features/profile/data/models/public_player_profile_model.dart';
import 'package:mal3abk/features/profile/domain/repos/profile_repo.dart';
import 'package:mal3abk/features/profile/domain/use_cases/get_profile_overview_use_case.dart';
import 'package:mal3abk/features/profile/domain/use_cases/save_profile_use_case.dart';
import 'package:mal3abk/features/profile/domain/use_cases/upload_avatar_use_case.dart';
import 'package:mal3abk/features/teams/domain/repos/teams_repo.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/teams_fixtures.dart';

class MockProfileRepo extends Mock implements ProfileRepo {}

class MockTeamsRepo extends Mock implements TeamsRepo {}

class MockBookingRepo extends Mock implements BookingRepo {}

const sampleProfile = MyProfileModel(
  userId: '11111111-1111-1111-1111-111111111111',
  fullName: 'أحمد علي',
  phoneNumber: '+201012345678',
  city: 'القاهرة',
  area: 'مدينة نصر',
  positions: ['Midfielder', 'Forward'],
  skillLevel: 'Intermediate',
  avatarUrl: '/api/v1/media/a/thumb?sig=x',
  onboardingComplete: true,
);

void main() {
  late MockProfileRepo repo;

  setUpAll(() {
    registerFallbackValue(
      const CompleteProfileRequestBody(fullName: '', city: '', area: ''),
    );
    registerFallbackValue(Uint8List(0));
  });

  setUp(() => repo = MockProfileRepo());

  test('reads positions and level from their server names', () {
    expect(sampleProfile.playerPositions, [
      PlayerPosition.midfielder,
      PlayerPosition.forward,
    ]);
    expect(sampleProfile.playerSkillLevel, SkillLevel.intermediate);
  });

  group('SaveProfileUseCase', () {
    test('sends positions and level as the numbers the API expects', () {
      const body = CompleteProfileRequestBody(
        fullName: 'أحمد',
        city: 'القاهرة',
        area: 'مدينة نصر',
        positions: [PlayerPosition.goalkeeper, PlayerPosition.forward],
        skillLevel: SkillLevel.advanced,
      );

      final json = body.toJson();

      expect(json['positions'], [0, 3]);
      expect(json['skillLevel'], 2);
    });

    test('rejects a one-letter name without calling the API', () async {
      final result = await SaveProfileUseCase(profileRepo: repo)(
        const CompleteProfileRequestBody(
          fullName: ' أ ',
          city: 'القاهرة',
          area: 'مدينة نصر',
        ),
        isOnboarding: true,
      );

      expect(result, isFailureWith('errors.profile.invalid_name'));
      verifyZeroInteractions(repo);
    });

    test('completes onboarding with a tidied name', () async {
      when(
        () => repo.completeProfile(any()),
      ).thenAnswer((_) async => const ApiResult.success(sampleProfile));

      await SaveProfileUseCase(profileRepo: repo)(
        const CompleteProfileRequestBody(
          fullName: '  أحمد    علي ',
          city: 'القاهرة',
          area: 'مدينة نصر',
        ),
        isOnboarding: true,
      );

      final sent =
          verify(() => repo.completeProfile(captureAny())).captured.single
              as CompleteProfileRequestBody;
      expect(sent.fullName, 'أحمد علي');
      verifyNever(() => repo.updateProfile(any()));
    });

    test('edits an existing profile with PATCH', () async {
      when(
        () => repo.updateProfile(any()),
      ).thenAnswer((_) async => const ApiResult.success(sampleProfile));

      final result = await SaveProfileUseCase(profileRepo: repo)(
        const CompleteProfileRequestBody(
          fullName: 'أحمد علي',
          city: 'القاهرة',
          area: 'مدينة نصر',
        ),
        isOnboarding: false,
      );

      expect(result, isSuccessWith(sampleProfile));
    });
  });

  test('UploadAvatarUseCase never uploads a non-image file', () async {
    final result = await UploadAvatarUseCase(profileRepo: repo)(
      Uint8List.fromList(List.filled(32, 0x41)),
    );

    expect(result, isFailureWith('errors.media.invalid_image'));
    verifyNever(
      () => repo.uploadAvatar(any(), contentType: any(named: 'contentType')),
    );
  });

  group('GetProfileOverviewUseCase', () {
    late MockTeamsRepo teamsRepo;
    late MockBookingRepo bookingRepo;
    late GetProfileOverviewUseCase useCase;

    setUp(() {
      teamsRepo = MockTeamsRepo();
      bookingRepo = MockBookingRepo();
      useCase = GetProfileOverviewUseCase(
        profileRepo: repo,
        teamsRepo: teamsRepo,
        bookingRepo: bookingRepo,
        mediaBaseUrl: 'https://api.example.test',
      );
      when(
        () => repo.getMyProfile(),
      ).thenAnswer((_) async => const ApiResult.success(sampleProfile));
    });

    test('combines stats, teams and the absolute avatar URL', () async {
      when(() => repo.getPlayerProfile(sampleProfile.userId)).thenAnswer(
        (_) async => const ApiResult.success(
          PublicPlayerProfileModel(
            userId: '1',
            fullName: 'أحمد علي',
            stats: PlayerStatsSummaryModel(matchesPlayed: 7, teamsCount: 1),
          ),
        ),
      );
      when(
        () => teamsRepo.getMyTeams(),
      ).thenAnswer((_) async => const ApiResult.success([myTeam]));
      when(() => bookingRepo.getMyBookings(page: 1, pageSize: 1)).thenAnswer(
        (_) async =>
            const ApiResult.failure(AppApiFailure(message: 'errors.network')),
      );

      final overview = (await useCase() as Success).data;

      expect(overview.matchesPlayed, 7);
      expect(overview.teamNames, [myTeam.name]);
      expect(overview.bookingsCount, isNull);
      expect(
        overview.avatarUrl,
        'https://api.example.test/api/v1/media/a/thumb?sig=x',
      );
    });
  });
}
