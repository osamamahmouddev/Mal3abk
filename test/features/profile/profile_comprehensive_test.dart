import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/core/utils/image_sanitizer.dart';
import 'package:mal3abk/features/booking/data/models/player_booking_summary_model.dart';
import 'package:mal3abk/features/booking/domain/repos/booking_repo.dart';
import '../../helpers/teams_fixtures.dart';
import 'package:mal3abk/features/profile/data/models/complete_profile_request_body.dart';
import 'package:mal3abk/features/profile/data/models/my_profile_model.dart';
import 'package:mal3abk/features/profile/data/models/player_attributes.dart';
import 'package:mal3abk/features/profile/data/models/profile_overview_model.dart';
import 'package:mal3abk/features/profile/data/models/public_player_profile_model.dart';
import 'package:mal3abk/features/profile/domain/repos/profile_repo.dart';
import 'package:mal3abk/features/profile/domain/use_cases/get_profile_overview_use_case.dart';
import 'package:mal3abk/features/profile/domain/use_cases/save_profile_use_case.dart';
import 'package:mal3abk/features/profile/domain/use_cases/upload_avatar_use_case.dart';
import 'package:mal3abk/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:mal3abk/features/profile/presentation/cubit/profile_state.dart';
import 'package:mal3abk/features/teams/domain/repos/teams_repo.dart';

class MockProfileRepo extends Mock implements ProfileRepo {}
class MockTeamsRepo extends Mock implements TeamsRepo {}
class MockBookingRepo extends Mock implements BookingRepo {}
class MockGetProfileOverviewUseCase extends Mock implements GetProfileOverviewUseCase {}
class MockImageSanitizer extends Mock implements ImageSanitizer {}

void main() {
  setUpAll(() {
    registerFallbackValue(const CompleteProfileRequestBody(fullName: '', city: '', area: ''));
    registerFallbackValue(Uint8List(0));
  });

  group('PlayerAttributes Enums Tests', () {
    test('1. PlayerPosition serverNames are correct', () {
      expect(PlayerPosition.goalkeeper.serverName, 'Goalkeeper');
      expect(PlayerPosition.defender.serverName, 'Defender');
      expect(PlayerPosition.midfielder.serverName, 'Midfielder');
      expect(PlayerPosition.forward.serverName, 'Forward');
    });

    test('2. PlayerPosition.fromServerName matches case-sensitively', () {
      expect(PlayerPosition.fromServerName('Goalkeeper'), PlayerPosition.goalkeeper);
      expect(PlayerPosition.fromServerName('Defender'), PlayerPosition.defender);
      expect(PlayerPosition.fromServerName('Midfielder'), PlayerPosition.midfielder);
      expect(PlayerPosition.fromServerName('Forward'), PlayerPosition.forward);
    });

    test('3. PlayerPosition.fromServerName returns null for unknown names', () {
      expect(PlayerPosition.fromServerName('Striker'), isNull);
      expect(PlayerPosition.fromServerName('goalkeeper'), isNull);
      expect(PlayerPosition.fromServerName(''), isNull);
    });

    test('4. SkillLevel serverNames are correct', () {
      expect(SkillLevel.beginner.serverName, 'Beginner');
      expect(SkillLevel.intermediate.serverName, 'Intermediate');
      expect(SkillLevel.advanced.serverName, 'Advanced');
    });

    test('5. SkillLevel.fromServerName matches correctly', () {
      expect(SkillLevel.fromServerName('Beginner'), SkillLevel.beginner);
      expect(SkillLevel.fromServerName('Intermediate'), SkillLevel.intermediate);
      expect(SkillLevel.fromServerName('Advanced'), SkillLevel.advanced);
    });

    test('6. SkillLevel.fromServerName returns null for null or unknown', () {
      expect(SkillLevel.fromServerName(null), isNull);
      expect(SkillLevel.fromServerName('Pro'), isNull);
      expect(SkillLevel.fromServerName('beginner'), isNull);
    });
  });

  group('MyProfileModel Serialization & Helpers Tests', () {
    test('7. fromJson parses complete profile model', () {
      final json = {
        'userId': 'usr-123',
        'fullName': 'أحمد محمد',
        'phoneNumber': '+201012345678',
        'email': 'ahmed@example.com',
        'city': 'Cairo',
        'area': 'Nasr City',
        'positions': ['Defender', 'Midfielder'],
        'skillLevel': 'Advanced',
        'language': 'ar',
        'onboardingComplete': true,
        'avatarUrl': 'avatars/usr-123.jpg',
      };
      final model = MyProfileModel.fromJson(json);
      expect(model.userId, 'usr-123');
      expect(model.fullName, 'أحمد محمد');
      expect(model.phoneNumber, '+201012345678');
      expect(model.email, 'ahmed@example.com');
      expect(model.city, 'Cairo');
      expect(model.area, 'Nasr City');
      expect(model.positions, ['Defender', 'Midfielder']);
      expect(model.skillLevel, 'Advanced');
      expect(model.language, 'ar');
      expect(model.onboardingComplete, isTrue);
      expect(model.avatarUrl, 'avatars/usr-123.jpg');
    });

    test('8. fromJson defaults optional fields properly', () {
      final json = {
        'userId': 'u-min',
        'fullName': 'Karim',
        'phoneNumber': '+201122334455',
      };
      final model = MyProfileModel.fromJson(json);
      expect(model.userId, 'u-min');
      expect(model.email, isNull);
      expect(model.city, isNull);
      expect(model.area, isNull);
      expect(model.positions, isEmpty);
      expect(model.skillLevel, isNull);
      expect(model.language, 'ar');
      expect(model.onboardingComplete, isFalse);
      expect(model.avatarUrl, isNull);
    });

    test('9. playerPositions getter maps server string positions to enums', () {
      const model = MyProfileModel(
        userId: 'u1',
        fullName: 'Omar',
        phoneNumber: '010',
        positions: ['Goalkeeper', 'Forward', 'InvalidPosition'],
      );
      final enums = model.playerPositions;
      expect(enums.length, 2);
      expect(enums, [PlayerPosition.goalkeeper, PlayerPosition.forward]);
    });

    test('10. playerSkillLevel getter maps string to SkillLevel enum', () {
      const model = MyProfileModel(
        userId: 'u1',
        fullName: 'Omar',
        phoneNumber: '010',
        skillLevel: 'Intermediate',
      );
      expect(model.playerSkillLevel, SkillLevel.intermediate);
    });

    test('11. playerSkillLevel returns null when skillLevel is null or unknown', () {
      const modelNull = MyProfileModel(userId: 'u1', fullName: 'O', phoneNumber: '010');
      expect(modelNull.playerSkillLevel, isNull);

      const modelUnknown = MyProfileModel(userId: 'u1', fullName: 'O', phoneNumber: '010', skillLevel: 'Master');
      expect(modelUnknown.playerSkillLevel, isNull);
    });

    test('12. toJson serializes all fields faithfully', () {
      const model = MyProfileModel(
        userId: 'u-1',
        fullName: 'Samir',
        phoneNumber: '+2010',
        email: 'samir@test.com',
        city: 'Giza',
        area: 'Dokki',
        positions: ['Forward'],
        skillLevel: 'Beginner',
        language: 'en',
        onboardingComplete: true,
        avatarUrl: 'img.jpg',
      );
      final json = model.toJson();
      expect(json['userId'], 'u-1');
      expect(json['positions'], ['Forward']);
      expect(json['skillLevel'], 'Beginner');
      expect(json['language'], 'en');
      expect(json['onboardingComplete'], isTrue);
    });
  });

  group('PublicPlayerProfileModel & Stats Tests', () {
    test('13. PlayerStatsSummaryModel fromJson and toJson', () {
      final json = {'matchesPlayed': 14, 'teamsCount': 2};
      final stats = PlayerStatsSummaryModel.fromJson(json);
      expect(stats.matchesPlayed, 14);
      expect(stats.teamsCount, 2);
      expect(stats.toJson(), json);
    });

    test('14. PublicPlayerProfileModel parses public profile with stats', () {
      final json = {
        'userId': 'pub-1',
        'fullName': 'Hossam Hassan',
        'avatarUrl': 'https://example.com/hossam.jpg',
        'city': 'Port Said',
        'positions': ['Forward'],
        'skillLevel': 'Advanced',
        'stats': {'matchesPlayed': 100, 'teamsCount': 5},
      };
      final model = PublicPlayerProfileModel.fromJson(json);
      expect(model.userId, 'pub-1');
      expect(model.fullName, 'Hossam Hassan');
      expect(model.avatarUrl, 'https://example.com/hossam.jpg');
      expect(model.city, 'Port Said');
      expect(model.positions, ['Forward']);
      expect(model.skillLevel, 'Advanced');
      expect(model.stats?.matchesPlayed, 100);
      expect(model.stats?.teamsCount, 5);
    });

    test('15. PublicPlayerProfileModel handles null stats and optional fields', () {
      final json = {
        'userId': 'pub-min',
        'fullName': 'Player X',
      };
      final model = PublicPlayerProfileModel.fromJson(json);
      expect(model.userId, 'pub-min');
      expect(model.avatarUrl, isNull);
      expect(model.city, isNull);
      expect(model.positions, isEmpty);
      expect(model.skillLevel, isNull);
      expect(model.stats, isNull);
    });
  });

  group('CompleteProfileRequestBody Tests', () {
    test('16. CompleteProfileRequestBody fromJson and toJson', () {
      final json = {
        'fullName': 'Tarek',
        'city': 'Cairo',
        'area': 'Maadi',
        'positions': [1, 2], // Defender (1), Midfielder (2)
        'skillLevel': 1, // Intermediate (1)
        'language': 'ar',
      };
      final body = CompleteProfileRequestBody.fromJson(json);
      expect(body.fullName, 'Tarek');
      expect(body.city, 'Cairo');
      expect(body.area, 'Maadi');
      expect(body.positions, [PlayerPosition.defender, PlayerPosition.midfielder]);
      expect(body.skillLevel, SkillLevel.intermediate);
      expect(body.language, 'ar');
      expect(body.toJson()['city'], 'Cairo');
    });

    test('17. CompleteProfileRequestBody defaults positions to empty list', () {
      const body = CompleteProfileRequestBody(
        fullName: 'Tarek',
        city: 'Cairo',
        area: 'Maadi',
      );
      expect(body.positions, isEmpty);
      expect(body.skillLevel, isNull);
      expect(body.language, isNull);
    });
  });

  group('SaveProfileUseCase Comprehensive Tests', () {
    late MockProfileRepo mockRepo;
    late SaveProfileUseCase useCase;

    const dummyProfile = MyProfileModel(
      userId: 'u1',
      fullName: 'Tarek',
      phoneNumber: '010',
    );

    setUp(() {
      mockRepo = MockProfileRepo();
      useCase = SaveProfileUseCase(profileRepo: mockRepo);
    });

    test('18. rejects empty full name', () async {
      const body = CompleteProfileRequestBody(fullName: '', city: 'Cairo', area: 'Maadi');
      final res = await useCase(body, isOnboarding: true);
      expect(res, isA<ApiFailure>());
      verifyNever(() => mockRepo.completeProfile(any()));
    });

    test('19. rejects 1-character full name', () async {
      const body = CompleteProfileRequestBody(fullName: 'A', city: 'Cairo', area: 'Maadi');
      final res = await useCase(body, isOnboarding: true);
      expect(res, isA<ApiFailure>());
      verifyNever(() => mockRepo.completeProfile(any()));
    });

    test('20. rejects full name longer than 100 characters', () async {
      final longName = 'A' * 101;
      final body = CompleteProfileRequestBody(fullName: longName, city: 'Cairo', area: 'Maadi');
      final res = await useCase(body, isOnboarding: true);
      expect(res, isA<ApiFailure>());
      verifyNever(() => mockRepo.completeProfile(any()));
    });

    test('21. accepts 2-character full name', () async {
      const body = CompleteProfileRequestBody(fullName: 'Al', city: 'Cairo', area: 'Maadi');
      when(() => mockRepo.completeProfile(any())).thenAnswer((_) async => const ApiResult.success(dummyProfile));
      final res = await useCase(body, isOnboarding: true);
      expect(res, isA<Success<MyProfileModel>>());
    });

    test('22. collapses multiple internal whitespaces and trims name', () async {
      const body = CompleteProfileRequestBody(fullName: '  Ahmed    Mohamed  ', city: 'Cairo', area: 'Maadi');
      when(() => mockRepo.completeProfile(any())).thenAnswer((_) async => const ApiResult.success(dummyProfile));

      await useCase(body, isOnboarding: true);

      verify(() => mockRepo.completeProfile(
            any(that: isA<CompleteProfileRequestBody>().having((b) => b.fullName, 'fullName', 'Ahmed Mohamed')),
          )).called(1);
    });

    test('23. rejects empty city', () async {
      const body = CompleteProfileRequestBody(fullName: 'Ahmed', city: '', area: 'Maadi');
      final res = await useCase(body, isOnboarding: true);
      expect(res, isA<ApiFailure>());
    });

    test('24. rejects whitespace-only city', () async {
      const body = CompleteProfileRequestBody(fullName: 'Ahmed', city: '   ', area: 'Maadi');
      final res = await useCase(body, isOnboarding: true);
      expect(res, isA<ApiFailure>());
    });

    test('25. rejects empty area', () async {
      const body = CompleteProfileRequestBody(fullName: 'Ahmed', city: 'Cairo', area: '');
      final res = await useCase(body, isOnboarding: true);
      expect(res, isA<ApiFailure>());
    });

    test('26. rejects city longer than 100 chars', () async {
      final body = CompleteProfileRequestBody(fullName: 'Ahmed', city: 'C' * 101, area: 'Maadi');
      final res = await useCase(body, isOnboarding: true);
      expect(res, isA<ApiFailure>());
    });

    test('27. rejects area longer than 100 chars', () async {
      final body = CompleteProfileRequestBody(fullName: 'Ahmed', city: 'Cairo', area: 'A' * 101);
      final res = await useCase(body, isOnboarding: true);
      expect(res, isA<ApiFailure>());
    });

    test('28. rejects more than 4 positions', () async {
      const body = CompleteProfileRequestBody(
        fullName: 'Ahmed',
        city: 'Cairo',
        area: 'Maadi',
        positions: [
          PlayerPosition.goalkeeper,
          PlayerPosition.defender,
          PlayerPosition.midfielder,
          PlayerPosition.forward,
          PlayerPosition.forward,
        ],
      );
      final res = await useCase(body, isOnboarding: true);
      expect(res, isA<ApiFailure>());
    });

    test('29. deduplicates positions list when valid', () async {
      const body = CompleteProfileRequestBody(
        fullName: 'Ahmed',
        city: 'Cairo',
        area: 'Maadi',
        positions: [PlayerPosition.midfielder, PlayerPosition.forward, PlayerPosition.midfielder],
      );
      when(() => mockRepo.completeProfile(any())).thenAnswer((_) async => const ApiResult.success(dummyProfile));

      await useCase(body, isOnboarding: true);

      verify(() => mockRepo.completeProfile(
            any(that: isA<CompleteProfileRequestBody>().having((b) => b.positions, 'positions', [PlayerPosition.midfielder, PlayerPosition.forward])),
          )).called(1);
    });

    test('30. calls completeProfile when isOnboarding is true', () async {
      const body = CompleteProfileRequestBody(fullName: 'Ahmed', city: 'Cairo', area: 'Maadi');
      when(() => mockRepo.completeProfile(any())).thenAnswer((_) async => const ApiResult.success(dummyProfile));

      final res = await useCase(body, isOnboarding: true);
      expect(res, isA<Success<MyProfileModel>>());
      verify(() => mockRepo.completeProfile(any())).called(1);
      verifyNever(() => mockRepo.updateProfile(any()));
    });

    test('31. calls updateProfile when isOnboarding is false', () async {
      const body = CompleteProfileRequestBody(fullName: 'Ahmed', city: 'Cairo', area: 'Maadi');
      when(() => mockRepo.updateProfile(any())).thenAnswer((_) async => const ApiResult.success(dummyProfile));

      final res = await useCase(body, isOnboarding: false);
      expect(res, isA<Success<MyProfileModel>>());
      verify(() => mockRepo.updateProfile(any())).called(1);
      verifyNever(() => mockRepo.completeProfile(any()));
    });

    test('32. propagates server failure when completeProfile fails', () async {
      const body = CompleteProfileRequestBody(fullName: 'Ahmed', city: 'Cairo', area: 'Maadi');
      when(() => mockRepo.completeProfile(any()))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.server')));

      final res = await useCase(body, isOnboarding: true);
      expect(res, isA<ApiFailure>());
    });

    test('33. propagates server failure when updateProfile fails', () async {
      const body = CompleteProfileRequestBody(fullName: 'Ahmed', city: 'Cairo', area: 'Maadi');
      when(() => mockRepo.updateProfile(any()))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.server')));

      final res = await useCase(body, isOnboarding: false);
      expect(res, isA<ApiFailure>());
    });
  });

  group('UploadAvatarUseCase Tests', () {
    late MockProfileRepo mockRepo;
    late MockImageSanitizer mockSanitizer;
    late UploadAvatarUseCase useCase;

    const dummyProfile = MyProfileModel(userId: 'u1', fullName: 'Ahmed', phoneNumber: '010');

    setUp(() {
      mockRepo = MockProfileRepo();
      mockSanitizer = MockImageSanitizer();
      useCase = UploadAvatarUseCase(profileRepo: mockRepo, imageSanitizer: mockSanitizer);
    });

    test('34. rejects non-image bytes without calling repo', () async {
      final invalidBytes = Uint8List.fromList([1, 2, 3, 4]);
      when(() => mockSanitizer.sanitize(invalidBytes)).thenAnswer((_) async => null);

      final res = await useCase(invalidBytes);
      expect(res, isA<ApiFailure>());
      verifyNever(() => mockRepo.uploadAvatar(any(), contentType: any(named: 'contentType')));
    });

    test('35. calls uploadAvatar on repo when sanitizer produces clean image', () async {
      final rawBytes = Uint8List.fromList([255, 216, 255, 224]);
      final cleanBytes = Uint8List.fromList([255, 216, 255]);
      when(() => mockSanitizer.sanitize(rawBytes)).thenAnswer((_) async => cleanBytes);
      when(() => mockRepo.uploadAvatar(cleanBytes, contentType: ImageSanitizer.contentType))
          .thenAnswer((_) async => const ApiResult.success(dummyProfile));

      final res = await useCase(rawBytes);
      expect(res, isA<Success<MyProfileModel>>());
      verify(() => mockRepo.uploadAvatar(cleanBytes, contentType: ImageSanitizer.contentType)).called(1);
    });

    test('36. propagates upload failure from repo', () async {
      final rawBytes = Uint8List.fromList([255, 216]);
      final cleanBytes = Uint8List.fromList([255, 216]);
      when(() => mockSanitizer.sanitize(rawBytes)).thenAnswer((_) async => cleanBytes);
      when(() => mockRepo.uploadAvatar(any(), contentType: any(named: 'contentType')))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.upload_failed')));

      final res = await useCase(rawBytes);
      expect(res, isA<ApiFailure>());
    });
  });

  group('GetProfileOverviewUseCase Comprehensive Tests', () {
    late MockProfileRepo mockProfileRepo;
    late MockTeamsRepo mockTeamsRepo;
    late MockBookingRepo mockBookingRepo;
    late GetProfileOverviewUseCase useCase;

    const testProfile = MyProfileModel(
      userId: 'usr-100',
      fullName: 'Youssef',
      phoneNumber: '01011122233',
      avatarUrl: 'avatars/100.jpg',
    );

    setUp(() {
      mockProfileRepo = MockProfileRepo();
      mockTeamsRepo = MockTeamsRepo();
      mockBookingRepo = MockBookingRepo();
      useCase = GetProfileOverviewUseCase(
        profileRepo: mockProfileRepo,
        teamsRepo: mockTeamsRepo,
        bookingRepo: mockBookingRepo,
        mediaBaseUrl: 'https://cdn.mal3abk.com',
      );
    });

    test('37. returns failure immediately when getMyProfile fails without querying other endpoints', () async {
      when(() => mockProfileRepo.getMyProfile())
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'auth.unauthorized')));

      final res = await useCase();
      expect(res, isA<ApiFailure>());
      verifyNever(() => mockProfileRepo.getPlayerProfile(any()));
      verifyNever(() => mockTeamsRepo.getMyTeams());
      verifyNever(() => mockBookingRepo.getMyBookings(page: any(named: 'page'), pageSize: any(named: 'pageSize')));
    });

    test('38. combines public stats, teams, and booking counts when all succeed', () async {
      when(() => mockProfileRepo.getMyProfile()).thenAnswer((_) async => const ApiResult.success(testProfile));
      const pubProfile = PublicPlayerProfileModel(
        userId: 'usr-100',
        fullName: 'Youssef',
        stats: PlayerStatsSummaryModel(matchesPlayed: 15, teamsCount: 1),
      );
      when(() => mockProfileRepo.getPlayerProfile('usr-100'))
          .thenAnswer((_) async => const ApiResult.success(pubProfile));

      const teams = [myTeam];
      when(() => mockTeamsRepo.getMyTeams()).thenAnswer((_) async => const ApiResult.success(teams));

      const bookingsPage = PlayerBookingsPagedListModel(
        items: [],
        page: 1,
        pageSize: 1,
        totalCount: 7,
      );
      when(() => mockBookingRepo.getMyBookings(page: 1, pageSize: 1))
          .thenAnswer((_) async => const ApiResult.success(bookingsPage));

      final res = await useCase();
      expect(res, isA<Success<ProfileOverviewModel>>());
      final overview = (res as Success<ProfileOverviewModel>).data;
      expect(overview.profile.userId, 'usr-100');
      expect(overview.matchesPlayed, 15);
      expect(overview.teamsCount, 1);
      expect(overview.teamNames, ['فريق النجوم']);
      expect(overview.bookingsCount, 7);
      expect(overview.avatarUrl, 'https://cdn.mal3abk.com/avatars/100.jpg');
    });

    test('39. tolerates getPlayerProfile failure and yields null matchesPlayed', () async {
      when(() => mockProfileRepo.getMyProfile()).thenAnswer((_) async => const ApiResult.success(testProfile));
      when(() => mockProfileRepo.getPlayerProfile('usr-100'))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'err')));
      when(() => mockTeamsRepo.getMyTeams()).thenAnswer((_) async => const ApiResult.success([]));
      when(() => mockBookingRepo.getMyBookings(page: 1, pageSize: 1))
          .thenAnswer((_) async => const ApiResult.success(PlayerBookingsPagedListModel(items: [], page: 1, pageSize: 1, totalCount: 0)));

      final res = await useCase();
      expect(res, isA<Success<ProfileOverviewModel>>());
      final overview = (res as Success<ProfileOverviewModel>).data;
      expect(overview.matchesPlayed, isNull);
    });

    test('40. tolerates getMyTeams failure and yields null teamNames', () async {
      when(() => mockProfileRepo.getMyProfile()).thenAnswer((_) async => const ApiResult.success(testProfile));
      when(() => mockProfileRepo.getPlayerProfile('usr-100'))
          .thenAnswer((_) async => const ApiResult.success(PublicPlayerProfileModel(userId: 'usr-100', fullName: 'Youssef')));
      when(() => mockTeamsRepo.getMyTeams())
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'err')));
      when(() => mockBookingRepo.getMyBookings(page: 1, pageSize: 1))
          .thenAnswer((_) async => const ApiResult.success(PlayerBookingsPagedListModel(items: [], page: 1, pageSize: 1, totalCount: 2)));

      final res = await useCase();
      expect(res, isA<Success<ProfileOverviewModel>>());
      final overview = (res as Success<ProfileOverviewModel>).data;
      expect(overview.teamNames, isEmpty);
    });

    test('41. tolerates getMyBookings failure and yields null bookingsCount', () async {
      when(() => mockProfileRepo.getMyProfile()).thenAnswer((_) async => const ApiResult.success(testProfile));
      when(() => mockProfileRepo.getPlayerProfile('usr-100'))
          .thenAnswer((_) async => const ApiResult.success(PublicPlayerProfileModel(userId: 'usr-100', fullName: 'Youssef')));
      when(() => mockTeamsRepo.getMyTeams()).thenAnswer((_) async => const ApiResult.success([]));
      when(() => mockBookingRepo.getMyBookings(page: 1, pageSize: 1))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'err')));

      final res = await useCase();
      expect(res, isA<Success<ProfileOverviewModel>>());
      final overview = (res as Success<ProfileOverviewModel>).data;
      expect(overview.bookingsCount, isNull);
    });
  });

  group('ProfileCubit Tests', () {
    late MockGetProfileOverviewUseCase mockUseCase;

    const testOverview = ProfileOverviewModel(
      profile: MyProfileModel(userId: 'u1', fullName: 'Hani', phoneNumber: '010'),
      matchesPlayed: 4,
      teamsCount: 1,
      bookingsCount: 2,
    );

    setUp(() {
      mockUseCase = MockGetProfileOverviewUseCase();
    });

    test('42. Initial state is ProfileState.initial()', () {
      final cubit = ProfileCubit(getProfileOverviewUseCase: mockUseCase);
      expect(cubit.state, const ProfileState.initial());
      cubit.close();
    });

    test('43. fetchProfile emits [loading, success]', () async {
      final cubit = ProfileCubit(getProfileOverviewUseCase: mockUseCase);
      when(() => mockUseCase()).thenAnswer((_) async => const ApiResult.success(testOverview));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const ProfileState.loading(),
          const ProfileState.success(testOverview),
        ]),
      );

      await cubit.fetchProfile();
      cubit.close();
    });

    test('44. fetchProfile emits [loading, error] on failure', () async {
      final cubit = ProfileCubit(getProfileOverviewUseCase: mockUseCase);
      when(() => mockUseCase())
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.profile_failed')));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const ProfileState.loading(),
          const ProfileState.error('errors.profile_failed'),
        ]),
      );

      await cubit.fetchProfile();
      cubit.close();
    });

    test('45. subsequent fetchProfile does not re-emit loading if already success', () async {
      final cubit = ProfileCubit(getProfileOverviewUseCase: mockUseCase);
      when(() => mockUseCase()).thenAnswer((_) async => const ApiResult.success(testOverview));

      await cubit.fetchProfile();
      expect(cubit.state, isA<ProfileSuccess>());

      final states = <ProfileState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.fetchProfile();
      expect(states.whereType<ProfileLoading>(), isEmpty);
      await sub.cancel();
      cubit.close();
    });

    test('46. safe emit when closed during async call', () async {
      final cubit = ProfileCubit(getProfileOverviewUseCase: mockUseCase);
      when(() => mockUseCase()).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        return const ApiResult.success(testOverview);
      });

      final future = cubit.fetchProfile();
      await cubit.close();
      await future;
      expect(cubit.isClosed, isTrue);
    });
  });

  group('Profile Edge Cases & Form Factor Tests', () {
    test('47. ProfileOverviewModel handles empty teams list and null counts', () {
      const overview = ProfileOverviewModel(
        profile: MyProfileModel(userId: 'u', fullName: 'F', phoneNumber: '0'),
      );
      expect(overview.avatarUrl, isNull);
      expect(overview.matchesPlayed, isNull);
      expect(overview.teamsCount, isNull);
      expect(overview.bookingsCount, isNull);
      expect(overview.teamNames, isEmpty);
    });

    test('48. MyProfileModel handles absolute avatar URL already formatted', () {
      const model = MyProfileModel(
        userId: 'u1',
        fullName: 'F',
        phoneNumber: '010',
        avatarUrl: 'https://images.unsplash.com/photo-123',
      );
      expect(model.avatarUrl, startsWith('https://'));
    });

    test('49. CompleteProfileRequestBody language english', () {
      const body = CompleteProfileRequestBody(
        fullName: 'Hassan',
        city: 'Alex',
        area: 'Roushdy',
        language: 'en',
      );
      expect(body.language, 'en');
      final json = body.toJson();
      expect(json['language'], 'en');
    });

    test('50. SaveProfileUseCase preserves language field', () async {
      final mockRepo = MockProfileRepo();
      final useCase = SaveProfileUseCase(profileRepo: mockRepo);
      const body = CompleteProfileRequestBody(
        fullName: 'Hassan',
        city: 'Alex',
        area: 'Roushdy',
        language: 'en',
      );
      when(() => mockRepo.updateProfile(any()))
          .thenAnswer((_) async => const ApiResult.success(MyProfileModel(userId: '1', fullName: 'H', phoneNumber: '0')));

      await useCase(body, isOnboarding: false);
      verify(() => mockRepo.updateProfile(
            any(that: isA<CompleteProfileRequestBody>().having((b) => b.language, 'language', 'en')),
          )).called(1);
    });

    test('51. SaveProfileUseCase preserves skillLevel', () async {
      final mockRepo = MockProfileRepo();
      final useCase = SaveProfileUseCase(profileRepo: mockRepo);
      const body = CompleteProfileRequestBody(
        fullName: 'Hassan',
        city: 'Alex',
        area: 'Roushdy',
        skillLevel: SkillLevel.advanced,
      );
      when(() => mockRepo.completeProfile(any()))
          .thenAnswer((_) async => const ApiResult.success(MyProfileModel(userId: '1', fullName: 'H', phoneNumber: '0')));

      await useCase(body, isOnboarding: true);
      verify(() => mockRepo.completeProfile(
            any(that: isA<CompleteProfileRequestBody>().having((b) => b.skillLevel, 'skillLevel', SkillLevel.advanced)),
          )).called(1);
    });

    test('52. PublicPlayerProfileModel positions array round trip', () {
      final json = {
        'userId': 'u',
        'fullName': 'N',
        'positions': ['Defender', 'Goalkeeper'],
      };
      final p = PublicPlayerProfileModel.fromJson(json);
      expect(p.positions, ['Defender', 'Goalkeeper']);
      expect(p.toJson()['positions'], ['Defender', 'Goalkeeper']);
    });

    test('53. PlayerStatsSummaryModel zero matches and zero teams', () {
      final json = {'matchesPlayed': 0, 'teamsCount': 0};
      final stats = PlayerStatsSummaryModel.fromJson(json);
      expect(stats.matchesPlayed, 0);
      expect(stats.teamsCount, 0);
    });

    test('54. MyProfileModel playerPositions skips empty strings', () {
      const model = MyProfileModel(
        userId: '1',
        fullName: 'A',
        phoneNumber: '0',
        positions: ['', 'Defender', ' '],
      );
      expect(model.playerPositions, [PlayerPosition.defender]);
    });

    test('55. ProfileState initial Equatable check', () {
      const s1 = ProfileState.initial();
      const s2 = ProfileState.initial();
      expect(s1, equals(s2));
    });

    test('56. ProfileState loading Equatable check', () {
      const s1 = ProfileState.loading();
      const s2 = ProfileState.loading();
      expect(s1, equals(s2));
    });

    test('57. ProfileState error message property', () {
      const err = ProfileState.error('err_msg');
      expect((err as ProfileError).message, 'err_msg');
    });

    test('58. ProfileSuccess overview property', () {
      const ov = ProfileOverviewModel(
        profile: MyProfileModel(userId: '1', fullName: 'F', phoneNumber: '0'),
      );
      const s = ProfileState.success(ov);
      expect((s as ProfileSuccess).overview, ov);
    });

    test('59. SaveProfileUseCase area with internal extra spaces is trimmed', () async {
      final mockRepo = MockProfileRepo();
      final useCase = SaveProfileUseCase(profileRepo: mockRepo);
      const body = CompleteProfileRequestBody(
        fullName: 'Hassan',
        city: 'Cairo',
        area: '  Nasr   City  ',
      );
      when(() => mockRepo.completeProfile(any()))
          .thenAnswer((_) async => const ApiResult.success(MyProfileModel(userId: '1', fullName: 'H', phoneNumber: '0')));

      await useCase(body, isOnboarding: true);
      verify(() => mockRepo.completeProfile(
            any(that: isA<CompleteProfileRequestBody>().having((b) => b.area, 'area', 'Nasr   City')),
          )).called(1);
    });

    test('60. SaveProfileUseCase city with surrounding spaces is trimmed', () async {
      final mockRepo = MockProfileRepo();
      final useCase = SaveProfileUseCase(profileRepo: mockRepo);
      const body = CompleteProfileRequestBody(
        fullName: 'Hassan',
        city: '  Alexandria  ',
        area: 'Smouha',
      );
      when(() => mockRepo.updateProfile(any()))
          .thenAnswer((_) async => const ApiResult.success(MyProfileModel(userId: '1', fullName: 'H', phoneNumber: '0')));

      await useCase(body, isOnboarding: false);
      verify(() => mockRepo.updateProfile(
            any(that: isA<CompleteProfileRequestBody>().having((b) => b.city, 'city', 'Alexandria')),
          )).called(1);
    });

    test('61. PlayerPosition serverName matches API contract numbers', () {
      expect(PlayerPosition.goalkeeper.index, 0);
      expect(PlayerPosition.defender.index, 1);
      expect(PlayerPosition.midfielder.index, 2);
      expect(PlayerPosition.forward.index, 3);
    });

    test('62. SkillLevel index matches API contract numbers', () {
      expect(SkillLevel.beginner.index, 0);
      expect(SkillLevel.intermediate.index, 1);
      expect(SkillLevel.advanced.index, 2);
    });

    test('63. ProfileOverviewModel multiple teams listed', () {
      const overview = ProfileOverviewModel(
        profile: MyProfileModel(userId: '1', fullName: 'F', phoneNumber: '0'),
        teamNames: ['Team 1', 'Team 2', 'Team 3'],
        teamsCount: 3,
      );
      expect(overview.teamNames.length, 3);
      expect(overview.teamsCount, 3);
    });

    test('64. UploadAvatarUseCase imageSanitizer default fallback', () {
      final mockRepo = MockProfileRepo();
      final useCase = UploadAvatarUseCase(profileRepo: mockRepo);
      expect(useCase.imageSanitizer, isNotNull);
    });

    test('65. CompleteProfileRequestBody positions list can be empty', () {
      const body = CompleteProfileRequestBody(
        fullName: 'A',
        city: 'C',
        area: 'A',
        positions: [],
      );
      expect(body.positions, isEmpty);
    });

    test('66. CompleteProfileRequestBody positions list with single item', () {
      const body = CompleteProfileRequestBody(
        fullName: 'A',
        city: 'C',
        area: 'A',
        positions: [PlayerPosition.goalkeeper],
      );
      expect(body.positions, [PlayerPosition.goalkeeper]);
    });

    test('67. CompleteProfileRequestBody positions list with all 4 items', () {
      const body = CompleteProfileRequestBody(
        fullName: 'A',
        city: 'C',
        area: 'A',
        positions: [
          PlayerPosition.goalkeeper,
          PlayerPosition.defender,
          PlayerPosition.midfielder,
          PlayerPosition.forward,
        ],
      );
      expect(body.positions.length, 4);
    });

    test('68. MyProfileModel email null vs present', () {
      const m1 = MyProfileModel(userId: '1', fullName: 'F', phoneNumber: 'P', email: null);
      const m2 = MyProfileModel(userId: '2', fullName: 'F', phoneNumber: 'P', email: 'test@test.com');
      expect(m1.email, isNull);
      expect(m2.email, 'test@test.com');
    });

    test('69. MyProfileModel city null vs present', () {
      const m1 = MyProfileModel(userId: '1', fullName: 'F', phoneNumber: 'P', city: null);
      const m2 = MyProfileModel(userId: '2', fullName: 'F', phoneNumber: 'P', city: 'Giza');
      expect(m1.city, isNull);
      expect(m2.city, 'Giza');
    });

    test('70. MyProfileModel area null vs present', () {
      const m1 = MyProfileModel(userId: '1', fullName: 'F', phoneNumber: 'P', area: null);
      const m2 = MyProfileModel(userId: '2', fullName: 'F', phoneNumber: 'P', area: 'Haram');
      expect(m1.area, isNull);
      expect(m2.area, 'Haram');
    });

    test('71. MyProfileModel skillLevel null vs present', () {
      const m1 = MyProfileModel(userId: '1', fullName: 'F', phoneNumber: 'P', skillLevel: null);
      const m2 = MyProfileModel(userId: '2', fullName: 'F', phoneNumber: 'P', skillLevel: 'Beginner');
      expect(m1.skillLevel, isNull);
      expect(m2.skillLevel, 'Beginner');
    });

    test('72. MyProfileModel avatarUrl null vs present', () {
      const m1 = MyProfileModel(userId: '1', fullName: 'F', phoneNumber: 'P', avatarUrl: null);
      const m2 = MyProfileModel(userId: '2', fullName: 'F', phoneNumber: 'P', avatarUrl: 'img.png');
      expect(m1.avatarUrl, isNull);
      expect(m2.avatarUrl, 'img.png');
    });

    test('73. PublicPlayerProfileModel avatarUrl null vs present', () {
      const p1 = PublicPlayerProfileModel(userId: '1', fullName: 'F', avatarUrl: null);
      const p2 = PublicPlayerProfileModel(userId: '2', fullName: 'F', avatarUrl: 'photo.jpg');
      expect(p1.avatarUrl, isNull);
      expect(p2.avatarUrl, 'photo.jpg');
    });

    test('74. PublicPlayerProfileModel city null vs present', () {
      const p1 = PublicPlayerProfileModel(userId: '1', fullName: 'F', city: null);
      const p2 = PublicPlayerProfileModel(userId: '2', fullName: 'F', city: 'Aswan');
      expect(p1.city, isNull);
      expect(p2.city, 'Aswan');
    });

    test('75. PublicPlayerProfileModel skillLevel null vs present', () {
      const p1 = PublicPlayerProfileModel(userId: '1', fullName: 'F', skillLevel: null);
      const p2 = PublicPlayerProfileModel(userId: '2', fullName: 'F', skillLevel: 'Intermediate');
      expect(p1.skillLevel, isNull);
      expect(p2.skillLevel, 'Intermediate');
    });

    test('76. PublicPlayerProfileModel stats null vs present', () {
      const p1 = PublicPlayerProfileModel(userId: '1', fullName: 'F', stats: null);
      const p2 = PublicPlayerProfileModel(userId: '2', fullName: 'F', stats: PlayerStatsSummaryModel(matchesPlayed: 5, teamsCount: 1));
      expect(p1.stats, isNull);
      expect(p2.stats?.matchesPlayed, 5);
    });

    test('77. ProfileOverviewModel matchesPlayed null vs present', () {
      const ov1 = ProfileOverviewModel(profile: MyProfileModel(userId: '1', fullName: 'F', phoneNumber: 'P'), matchesPlayed: null);
      const ov2 = ProfileOverviewModel(profile: MyProfileModel(userId: '2', fullName: 'F', phoneNumber: 'P'), matchesPlayed: 10);
      expect(ov1.matchesPlayed, isNull);
      expect(ov2.matchesPlayed, 10);
    });

    test('78. ProfileOverviewModel bookingsCount null vs present', () {
      const ov1 = ProfileOverviewModel(profile: MyProfileModel(userId: '1', fullName: 'F', phoneNumber: 'P'), bookingsCount: null);
      const ov2 = ProfileOverviewModel(profile: MyProfileModel(userId: '2', fullName: 'F', phoneNumber: 'P'), bookingsCount: 3);
      expect(ov1.bookingsCount, isNull);
      expect(ov2.bookingsCount, 3);
    });

    test('79. ProfileOverviewModel teamsCount fallback to stats teamsCount when teamNames null', () async {
      final mockProfileRepo = MockProfileRepo();
      final mockTeamsRepo = MockTeamsRepo();
      final mockBookingRepo = MockBookingRepo();
      final useCase = GetProfileOverviewUseCase(
        profileRepo: mockProfileRepo,
        teamsRepo: mockTeamsRepo,
        bookingRepo: mockBookingRepo,
        mediaBaseUrl: 'https://cdn.example.com',
      );

      const testProf = MyProfileModel(userId: 'u-fb', fullName: 'FB', phoneNumber: '010');
      when(() => mockProfileRepo.getMyProfile()).thenAnswer((_) async => const ApiResult.success(testProf));
      when(() => mockProfileRepo.getPlayerProfile('u-fb')).thenAnswer((_) async => const ApiResult.success(
            PublicPlayerProfileModel(userId: 'u-fb', fullName: 'FB', stats: PlayerStatsSummaryModel(matchesPlayed: 2, teamsCount: 4)),
          ));
      // teams call fails
      when(() => mockTeamsRepo.getMyTeams()).thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'err')));
      when(() => mockBookingRepo.getMyBookings(page: 1, pageSize: 1))
          .thenAnswer((_) async => const ApiResult.success(PlayerBookingsPagedListModel(items: [], page: 1, pageSize: 1, totalCount: 0)));

      final res = await useCase();
      final ov = (res as Success<ProfileOverviewModel>).data;
      // teamsCount falls back to stats?.teamsCount (4)
      expect(ov.teamsCount, 4);
    });

    test('80. SaveProfileUseCase preserves area and city casing', () async {
      final mockRepo = MockProfileRepo();
      final useCase = SaveProfileUseCase(profileRepo: mockRepo);
      const body = CompleteProfileRequestBody(
        fullName: 'Hassan',
        city: 'New Cairo',
        area: 'Fifth Settlement',
      );
      when(() => mockRepo.updateProfile(any()))
          .thenAnswer((_) async => const ApiResult.success(MyProfileModel(userId: '1', fullName: 'H', phoneNumber: '0')));

      await useCase(body, isOnboarding: false);
      verify(() => mockRepo.updateProfile(
            any(that: isA<CompleteProfileRequestBody>()
                .having((b) => b.city, 'city', 'New Cairo')
                .having((b) => b.area, 'area', 'Fifth Settlement')),
          )).called(1);
    });

    test('81. SaveProfileUseCase exact 100 character name is valid', () async {
      final mockRepo = MockProfileRepo();
      final useCase = SaveProfileUseCase(profileRepo: mockRepo);
      final exact100 = 'A' * 100;
      final body = CompleteProfileRequestBody(fullName: exact100, city: 'Cairo', area: 'Maadi');
      when(() => mockRepo.completeProfile(any()))
          .thenAnswer((_) async => const ApiResult.success(MyProfileModel(userId: '1', fullName: 'H', phoneNumber: '0')));

      final res = await useCase(body, isOnboarding: true);
      expect(res, isA<Success<MyProfileModel>>());
    });

    test('82. SaveProfileUseCase exact 100 character city is valid', () async {
      final mockRepo = MockProfileRepo();
      final useCase = SaveProfileUseCase(profileRepo: mockRepo);
      final exact100 = 'C' * 100;
      final body = CompleteProfileRequestBody(fullName: 'Ahmed', city: exact100, area: 'Maadi');
      when(() => mockRepo.completeProfile(any()))
          .thenAnswer((_) async => const ApiResult.success(MyProfileModel(userId: '1', fullName: 'H', phoneNumber: '0')));

      final res = await useCase(body, isOnboarding: true);
      expect(res, isA<Success<MyProfileModel>>());
    });

    test('83. SaveProfileUseCase exact 100 character area is valid', () async {
      final mockRepo = MockProfileRepo();
      final useCase = SaveProfileUseCase(profileRepo: mockRepo);
      final exact100 = 'A' * 100;
      final body = CompleteProfileRequestBody(fullName: 'Ahmed', city: 'Cairo', area: exact100);
      when(() => mockRepo.completeProfile(any()))
          .thenAnswer((_) async => const ApiResult.success(MyProfileModel(userId: '1', fullName: 'H', phoneNumber: '0')));

      final res = await useCase(body, isOnboarding: true);
      expect(res, isA<Success<MyProfileModel>>());
    });

    test('84. SaveProfileUseCase accepts arabic characters in name and place', () async {
      final mockRepo = MockProfileRepo();
      final useCase = SaveProfileUseCase(profileRepo: mockRepo);
      const body = CompleteProfileRequestBody(fullName: 'محمد صلاح', city: 'القاهرة', area: 'المعادي');
      when(() => mockRepo.completeProfile(any()))
          .thenAnswer((_) async => const ApiResult.success(MyProfileModel(userId: '1', fullName: 'H', phoneNumber: '0')));

      final res = await useCase(body, isOnboarding: true);
      expect(res, isA<Success<MyProfileModel>>());
      verify(() => mockRepo.completeProfile(
            any(that: isA<CompleteProfileRequestBody>()
                .having((b) => b.fullName, 'fullName', 'محمد صلاح')
                .having((b) => b.city, 'city', 'القاهرة')
                .having((b) => b.area, 'area', 'المعادي')),
          )).called(1);
    });

    test('85. SaveProfileUseCase collapses tab characters in fullName', () async {
      final mockRepo = MockProfileRepo();
      final useCase = SaveProfileUseCase(profileRepo: mockRepo);
      const body = CompleteProfileRequestBody(fullName: 'Ali\t\tHassan', city: 'Cairo', area: 'Maadi');
      when(() => mockRepo.completeProfile(any()))
          .thenAnswer((_) async => const ApiResult.success(MyProfileModel(userId: '1', fullName: 'H', phoneNumber: '0')));

      await useCase(body, isOnboarding: true);
      verify(() => mockRepo.completeProfile(
            any(that: isA<CompleteProfileRequestBody>().having((b) => b.fullName, 'fullName', 'Ali Hassan')),
          )).called(1);
    });

    test('86. SaveProfileUseCase collapses newline characters in fullName', () async {
      final mockRepo = MockProfileRepo();
      final useCase = SaveProfileUseCase(profileRepo: mockRepo);
      const body = CompleteProfileRequestBody(fullName: 'Ali\n\nHassan', city: 'Cairo', area: 'Maadi');
      when(() => mockRepo.completeProfile(any()))
          .thenAnswer((_) async => const ApiResult.success(MyProfileModel(userId: '1', fullName: 'H', phoneNumber: '0')));

      await useCase(body, isOnboarding: true);
      verify(() => mockRepo.completeProfile(
            any(that: isA<CompleteProfileRequestBody>().having((b) => b.fullName, 'fullName', 'Ali Hassan')),
          )).called(1);
    });

    test('87. GetProfileOverviewUseCase resolves avatarUrl with relative path', () async {
      final mockProfileRepo = MockProfileRepo();
      final mockTeamsRepo = MockTeamsRepo();
      final mockBookingRepo = MockBookingRepo();
      final useCase = GetProfileOverviewUseCase(
        profileRepo: mockProfileRepo,
        teamsRepo: mockTeamsRepo,
        bookingRepo: mockBookingRepo,
        mediaBaseUrl: 'https://static.mal3abk.com',
      );

      const testProf = MyProfileModel(
        userId: 'u1',
        fullName: 'F',
        phoneNumber: '0',
        avatarUrl: '/uploads/avatar.jpg',
      );
      when(() => mockProfileRepo.getMyProfile()).thenAnswer((_) async => const ApiResult.success(testProf));
      when(() => mockProfileRepo.getPlayerProfile('u1')).thenAnswer((_) async => const ApiResult.success(PublicPlayerProfileModel(userId: 'u1', fullName: 'F')));
      when(() => mockTeamsRepo.getMyTeams()).thenAnswer((_) async => const ApiResult.success([]));
      when(() => mockBookingRepo.getMyBookings(page: 1, pageSize: 1))
          .thenAnswer((_) async => const ApiResult.success(PlayerBookingsPagedListModel(items: [], page: 1, pageSize: 1, totalCount: 0)));

      final res = await useCase();
      final ov = (res as Success<ProfileOverviewModel>).data;
      expect(ov.avatarUrl, 'https://static.mal3abk.com/uploads/avatar.jpg');
    });

    test('88. GetProfileOverviewUseCase leaves null avatarUrl as null', () async {
      final mockProfileRepo = MockProfileRepo();
      final mockTeamsRepo = MockTeamsRepo();
      final mockBookingRepo = MockBookingRepo();
      final useCase = GetProfileOverviewUseCase(
        profileRepo: mockProfileRepo,
        teamsRepo: mockTeamsRepo,
        bookingRepo: mockBookingRepo,
        mediaBaseUrl: 'https://static.mal3abk.com',
      );

      const testProf = MyProfileModel(
        userId: 'u1',
        fullName: 'F',
        phoneNumber: '0',
        avatarUrl: null,
      );
      when(() => mockProfileRepo.getMyProfile()).thenAnswer((_) async => const ApiResult.success(testProf));
      when(() => mockProfileRepo.getPlayerProfile('u1')).thenAnswer((_) async => const ApiResult.success(PublicPlayerProfileModel(userId: 'u1', fullName: 'F')));
      when(() => mockTeamsRepo.getMyTeams()).thenAnswer((_) async => const ApiResult.success([]));
      when(() => mockBookingRepo.getMyBookings(page: 1, pageSize: 1))
          .thenAnswer((_) async => const ApiResult.success(PlayerBookingsPagedListModel(items: [], page: 1, pageSize: 1, totalCount: 0)));

      final res = await useCase();
      final ov = (res as Success<ProfileOverviewModel>).data;
      expect(ov.avatarUrl, isNull);
    });

    test('89. MyProfileModel serialization with all positions present', () {
      const model = MyProfileModel(
        userId: 'u-all',
        fullName: 'Versatile Player',
        phoneNumber: '010',
        positions: ['Goalkeeper', 'Defender', 'Midfielder', 'Forward'],
      );
      final enums = model.playerPositions;
      expect(enums.length, 4);
      expect(enums, [
        PlayerPosition.goalkeeper,
        PlayerPosition.defender,
        PlayerPosition.midfielder,
        PlayerPosition.forward,
      ]);
    });

    test('90. CompleteProfileRequestBody positions array order preserved', () {
      const body = CompleteProfileRequestBody(
        fullName: 'N',
        city: 'C',
        area: 'A',
        positions: [PlayerPosition.forward, PlayerPosition.goalkeeper],
      );
      expect(body.positions.first, PlayerPosition.forward);
      expect(body.positions.last, PlayerPosition.goalkeeper);
    });

    test('91. ProfileOverviewModel bookingsCount 0 is not null', () {
      const ov = ProfileOverviewModel(
        profile: MyProfileModel(userId: '1', fullName: 'N', phoneNumber: '0'),
        bookingsCount: 0,
      );
      expect(ov.bookingsCount, 0);
    });

    test('92. ProfileOverviewModel matchesPlayed 0 is not null', () {
      const ov = ProfileOverviewModel(
        profile: MyProfileModel(userId: '1', fullName: 'N', phoneNumber: '0'),
        matchesPlayed: 0,
      );
      expect(ov.matchesPlayed, 0);
    });

    test('93. ProfileOverviewModel teamsCount 0 is not null', () {
      const ov = ProfileOverviewModel(
        profile: MyProfileModel(userId: '1', fullName: 'N', phoneNumber: '0'),
        teamsCount: 0,
      );
      expect(ov.teamsCount, 0);
    });

    test('94. CompleteProfileRequestBody skillLevel beginner serialization', () {
      const body = CompleteProfileRequestBody(
        fullName: 'N',
        city: 'C',
        area: 'A',
        skillLevel: SkillLevel.beginner,
      );
      expect(body.skillLevel, SkillLevel.beginner);
    });

    test('95. CompleteProfileRequestBody skillLevel advanced serialization', () {
      const body = CompleteProfileRequestBody(
        fullName: 'N',
        city: 'C',
        area: 'A',
        skillLevel: SkillLevel.advanced,
      );
      expect(body.skillLevel, SkillLevel.advanced);
    });
  });
}
