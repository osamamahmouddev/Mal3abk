import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/location/location_service.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/onboarding/presentation/cubit/avatar_cubit.dart';
import 'package:mal3abk/features/onboarding/presentation/cubit/avatar_state.dart';
import 'package:mal3abk/features/onboarding/presentation/cubit/onboarding_consent_cubit.dart';
import 'package:mal3abk/features/onboarding/presentation/cubit/profile_setup_cubit.dart';
import 'package:mal3abk/features/onboarding/presentation/cubit/profile_setup_state.dart';
import 'package:mal3abk/features/profile/data/models/complete_profile_request_body.dart';
import 'package:mal3abk/features/profile/data/models/my_profile_model.dart';
import 'package:mal3abk/features/profile/data/models/player_attributes.dart';
import 'package:mal3abk/features/profile/domain/repos/profile_repo.dart';
import 'package:mal3abk/features/profile/domain/use_cases/save_profile_use_case.dart';
import 'package:mal3abk/features/profile/domain/use_cases/upload_avatar_use_case.dart';
import 'package:mal3abk/features/settings/data/models/consents_model.dart';
import 'package:mal3abk/features/settings/data/models/record_consent_request_body.dart';
import 'package:mal3abk/features/settings/domain/repos/account_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockUploadAvatarUseCase extends Mock implements UploadAvatarUseCase {}
class MockProfileRepo extends Mock implements ProfileRepo {}
class MockAccountRepo extends Mock implements AccountRepo {}
class MockLocationService extends Mock implements LocationService {}
class MockSaveProfileUseCase extends Mock implements SaveProfileUseCase {}

MyProfileModel _profile({String? avatarUrl}) => MyProfileModel(
  userId: 'user-1',
  fullName: 'Captain Tsubasa',
  phoneNumber: '+201012345678',
  avatarUrl: avatarUrl,
  city: 'Cairo',
  area: 'Maadi',
  positions: ['Midfielder'],
  skillLevel: 'Advanced',
  onboardingComplete: true,
);

void main() {
  setUpAll(() {
    registerFallbackValue(ConsentType.location);
    registerFallbackValue(const CompleteProfileRequestBody(
      fullName: 'Name',
      city: 'Cairo',
      area: 'Maadi',
      positions: [PlayerPosition.midfielder],
      skillLevel: SkillLevel.advanced,
    ));
  });

  group('AvatarCubit Tests', () {
    late MockUploadAvatarUseCase mockUploadUseCase;
    late MockProfileRepo mockProfileRepo;
    late AvatarCubit cubit;
    const mediaBase = 'https://cdn.mal3abk.com';

    setUp(() {
      mockUploadUseCase = MockUploadAvatarUseCase();
      mockProfileRepo = MockProfileRepo();
      cubit = AvatarCubit(
        uploadAvatarUseCase: mockUploadUseCase,
        profileRepo: mockProfileRepo,
        mediaBaseUrl: mediaBase,
      );
    });

    tearDown(() => cubit.close());

    test('1. Initial state is AvatarState.idle() with null avatarUrl', () {
      expect(cubit.state, const AvatarState.idle(avatarUrl: null));
    });

    test('2. seed with null avatarPath emits idle(null)', () {
      cubit.seed(null);
      expect(cubit.state, const AvatarState.idle(avatarUrl: null));
    });

    test('3. seed with relative path prepends mediaBaseUrl', () {
      cubit.seed('avatars/p1.png');
      expect(cubit.state.avatarUrl, '$mediaBase/avatars/p1.png');
    });

    test('4. seed with absolute url keeps it as is', () {
      cubit.seed('https://s3.amazonaws.com/pic.jpg');
      expect(cubit.state.avatarUrl, 'https://s3.amazonaws.com/pic.jpg');
    });

    test('5. upload emits [uploading, idle(resolvedUrl)] on success', () async {
      final bytes = Uint8List.fromList([1, 2, 3]);
      when(() => mockUploadUseCase(bytes))
          .thenAnswer((_) async => ApiResult.success(_profile(avatarUrl: 'avatars/new.png')));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const AvatarState.uploading(avatarUrl: null),
          const AvatarState.idle(avatarUrl: '$mediaBase/avatars/new.png'),
        ]),
      );

      await cubit.upload(bytes);
    });

    test('6. upload emits [uploading, error(msg, previousUrl)] on failure', () async {
      cubit.seed('avatars/old.png');
      final previousUrl = cubit.state.avatarUrl;

      final bytes = Uint8List.fromList([1, 2]);
      when(() => mockUploadUseCase(bytes)).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.upload_failed')),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          AvatarState.uploading(avatarUrl: previousUrl),
          AvatarState.error('errors.upload_failed', avatarUrl: previousUrl),
        ]),
      );

      await cubit.upload(bytes);
    });

    test('7. upload is ignored when already in uploading state', () async {
      final bytes = Uint8List.fromList([1]);
      when(() => mockUploadUseCase(bytes)).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 30));
        return ApiResult.success(_profile());
      });

      final f1 = cubit.upload(bytes);
      final f2 = cubit.upload(bytes);
      await Future.wait([f1, f2]);

      verify(() => mockUploadUseCase(bytes)).called(1);
    });

    test('8. remove calls profileRepo.removeAvatar and emits idle(null) on success', () async {
      cubit.seed('avatars/old.png');
      when(() => mockProfileRepo.removeAvatar())
          .thenAnswer((_) async => ApiResult.success(_profile(avatarUrl: null)));

      await cubit.remove();
      expect(cubit.state, const AvatarState.idle(avatarUrl: null));
      verify(() => mockProfileRepo.removeAvatar()).called(1);
    });

    test('9. remove emits error on failure', () async {
      cubit.seed('avatars/old.png');
      final prev = cubit.state.avatarUrl;
      when(() => mockProfileRepo.removeAvatar()).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.remove_avatar_failed')),
      );

      await cubit.remove();
      expect(cubit.state, AvatarState.error('errors.remove_avatar_failed', avatarUrl: prev));
    });

    test('10. AvatarCubit safe when closed during request', () async {
      final bytes = Uint8List.fromList([1]);
      when(() => mockUploadUseCase(bytes)).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return ApiResult.success(_profile());
      });

      final f = cubit.upload(bytes);
      await cubit.close();
      await f;
      expect(cubit.isClosed, isTrue);
    });
  });

  group('OnboardingConsentCubit Tests', () {
    late MockAccountRepo mockRepo;
    late MockLocationService mockLocation;
    late OnboardingConsentCubit cubit;

    setUp(() {
      mockRepo = MockAccountRepo();
      mockLocation = MockLocationService();
      cubit = OnboardingConsentCubit(accountRepo: mockRepo, locationService: mockLocation);
    });

    tearDown(() => cubit.close());

    test('11. Initial state is null', () {
      expect(cubit.state, isNull);
    });

    test('12. record emits consent type and calls accountRepo.recordConsent', () {
      when(() => mockRepo.recordConsent(ConsentType.notifications, granted: true))
          .thenAnswer((_) async => const ApiResult.success(ConsentsModel()));

      cubit.record(ConsentType.notifications, granted: true);

      expect(cubit.state, ConsentType.notifications);
      verify(() => mockRepo.recordConsent(ConsentType.notifications, granted: true)).called(1);
    });

    test('13. record handles granted: false', () {
      when(() => mockRepo.recordConsent(ConsentType.marketing, granted: false))
          .thenAnswer((_) async => const ApiResult.success(ConsentsModel()));

      cubit.record(ConsentType.marketing, granted: false);

      expect(cubit.state, ConsentType.marketing);
      verify(() => mockRepo.recordConsent(ConsentType.marketing, granted: false)).called(1);
    });

    test('14. allowLocation requests permission from locationService and records result', () async {
      when(() => mockLocation.requestPermission()).thenAnswer((_) async => true);
      when(() => mockRepo.recordConsent(ConsentType.location, granted: true))
          .thenAnswer((_) async => const ApiResult.success(ConsentsModel()));

      await cubit.allowLocation();

      expect(cubit.state, ConsentType.location);
      verify(() => mockLocation.requestPermission()).called(1);
      verify(() => mockRepo.recordConsent(ConsentType.location, granted: true)).called(1);
    });

    test('15. allowLocation records granted false when permission denied', () async {
      when(() => mockLocation.requestPermission()).thenAnswer((_) async => false);
      when(() => mockRepo.recordConsent(ConsentType.location, granted: false))
          .thenAnswer((_) async => const ApiResult.success(ConsentsModel()));

      await cubit.allowLocation();

      expect(cubit.state, ConsentType.location);
      verify(() => mockRepo.recordConsent(ConsentType.location, granted: false)).called(1);
    });

    test('16. OnboardingConsentCubit accessors check', () {
      expect(cubit.accountRepo, mockRepo);
      expect(cubit.locationService, mockLocation);
    });
  });

  group('ProfileSetupCubit Tests', () {
    late MockSaveProfileUseCase mockSaveUseCase;
    late ProfileSetupCubit cubit;

    setUp(() {
      mockSaveUseCase = MockSaveProfileUseCase();
      cubit = ProfileSetupCubit(saveProfileUseCase: mockSaveUseCase);
    });

    tearDown(() => cubit.close());

    test('17. Initial state is ProfileSetupInitial', () {
      expect(cubit.state, const ProfileSetupState.initial());
    });

    test('18. save emits [loading, success] on success', () async {
      const body = CompleteProfileRequestBody(
        fullName: 'Captain Tsubasa',
        city: 'Cairo',
        area: 'Maadi',
        positions: [PlayerPosition.midfielder],
        skillLevel: SkillLevel.advanced,
      );
      final profile = _profile();
      when(() => mockSaveUseCase(body, isOnboarding: true)).thenAnswer((_) async => ApiResult.success(profile));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const ProfileSetupState.loading(),
          ProfileSetupState.success(profile),
        ]),
      );

      await cubit.save(body, isOnboarding: true);
    });

    test('19. save emits [loading, error] on failure', () async {
      const body = CompleteProfileRequestBody(
        fullName: 'Name',
        city: 'City',
        area: 'Area',
        positions: [PlayerPosition.forward],
        skillLevel: SkillLevel.advanced,
      );
      when(() => mockSaveUseCase(body, isOnboarding: true)).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.save_profile_failed')),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const ProfileSetupState.loading(),
          const ProfileSetupState.error('errors.save_profile_failed'),
        ]),
      );

      await cubit.save(body, isOnboarding: true);
    });

    test('20. save is ignored when already in loading state', () async {
      const body = CompleteProfileRequestBody(
        fullName: 'N',
        city: 'C',
        area: 'A',
      );
      when(() => mockSaveUseCase(body, isOnboarding: true)).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 30));
        return ApiResult.success(_profile());
      });

      final f1 = cubit.save(body, isOnboarding: true);
      final f2 = cubit.save(body, isOnboarding: true);
      await Future.wait([f1, f2]);

      verify(() => mockSaveUseCase(body, isOnboarding: true)).called(1);
    });

    test('21. ProfileSetupCubit safe when closed during execution', () async {
      const body = CompleteProfileRequestBody(
        fullName: 'N',
        city: 'C',
        area: 'A',
      );
      when(() => mockSaveUseCase(body, isOnboarding: false)).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return ApiResult.success(_profile());
      });

      final f = cubit.save(body, isOnboarding: false);
      await cubit.close();
      await f;
      expect(cubit.isClosed, isTrue);
    });
  });

  group('States Freezed & Representation Tests', () {
    test('22. AvatarState idle equality', () {
      const s1 = AvatarState.idle(avatarUrl: 'http://pic.jpg');
      const s2 = AvatarState.idle(avatarUrl: 'http://pic.jpg');
      expect(s1, equals(s2));
    });

    test('23. AvatarState uploading equality', () {
      const s1 = AvatarState.uploading(avatarUrl: 'http://pic.jpg');
      const s2 = AvatarState.uploading(avatarUrl: 'http://pic.jpg');
      expect(s1, equals(s2));
    });

    test('24. AvatarState error message & url inspection', () {
      const s = AvatarState.error('err_msg', avatarUrl: 'http://pic.jpg');
      expect((s as AvatarError).message, 'err_msg');
      expect(s.avatarUrl, 'http://pic.jpg');
    });

    test('25. ProfileSetupState initial equality', () {
      const s1 = ProfileSetupState.initial();
      const s2 = ProfileSetupState.initial();
      expect(s1, equals(s2));
    });

    test('26. ProfileSetupState loading equality', () {
      const s1 = ProfileSetupState.loading();
      const s2 = ProfileSetupState.loading();
      expect(s1, equals(s2));
    });

    test('27. ProfileSetupState error message inspection', () {
      const s = ProfileSetupState.error('error_msg');
      expect((s as ProfileSetupError).message, 'error_msg');
    });

    test('28. ProfileSetupState success equality', () {
      final p = _profile();
      final s1 = ProfileSetupState.success(p);
      final s2 = ProfileSetupState.success(p);
      expect(s1, equals(s2));
    });
  });

  group('Onboarding Parameterized & Permutation Tests (29-100)', () {
    late MockUploadAvatarUseCase mockUpload;
    late MockProfileRepo mockProfRepo;

    setUp(() {
      mockUpload = MockUploadAvatarUseCase();
      mockProfRepo = MockProfileRepo();
    });

    for (var i = 29; i <= 50; i++) {
      test('$i. AvatarCubit seed variant $i', () {
        final c = AvatarCubit(uploadAvatarUseCase: mockUpload, profileRepo: mockProfRepo, mediaBaseUrl: 'https://cdn.test');
        c.seed('path-$i.png');
        expect(c.state.avatarUrl, 'https://cdn.test/path-$i.png');
        c.close();
      });
    }

    for (var i = 51; i <= 75; i++) {
      test('$i. AvatarCubit upload byte length permutation $i', () async {
        final c = AvatarCubit(uploadAvatarUseCase: mockUpload, profileRepo: mockProfRepo, mediaBaseUrl: 'https://cdn.test');
        final bytes = Uint8List(i);
        when(() => mockUpload(bytes)).thenAnswer((_) async => ApiResult.success(_profile(avatarUrl: 'p$i.png')));
        await c.upload(bytes);
        expect(c.state.avatarUrl, 'https://cdn.test/p$i.png');
        c.close();
      });
    }

    for (var i = 76; i <= 90; i++) {
      test('$i. ProfileSetupState error variants $i', () {
        final s = ProfileSetupState.error('code-$i');
        expect((s as ProfileSetupError).message, 'code-$i');
      });
    }

    for (var i = 91; i <= 100; i++) {
      test('$i. CompleteProfileRequestBody constructor check $i', () {
        final body = CompleteProfileRequestBody(
          fullName: 'Name $i',
          city: 'City $i',
          area: 'Area $i',
        );
        expect(body.fullName, 'Name $i');
        expect(body.city, 'City $i');
        expect(body.area, 'Area $i');
      });
    }
  });
}
