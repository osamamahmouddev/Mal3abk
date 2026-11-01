import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/profile/data/models/complete_profile_request_body.dart';
import 'package:mal3abk/features/profile/data/models/my_profile_model.dart';
import 'package:mal3abk/features/profile/domain/repos/profile_repo.dart';
import 'package:mal3abk/features/profile/domain/use_cases/complete_profile_use_case.dart';
import 'package:mal3abk/features/profile/domain/use_cases/get_my_profile_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileRepo extends Mock implements ProfileRepo {}

void main() {
  late MockProfileRepo mockRepo;
  late GetMyProfileUseCase getProfileUseCase;
  late CompleteProfileUseCase completeProfileUseCase;

  setUp(() {
    mockRepo = MockProfileRepo();
    getProfileUseCase = GetMyProfileUseCase(profileRepo: mockRepo);
    completeProfileUseCase = CompleteProfileUseCase(profileRepo: mockRepo);
  });

  const sampleProfile = MyProfileModel(
    userId: '11111111-1111-1111-1111-111111111111',
    fullName: 'أحمد علي',
    phoneNumber: '+201012345678',
    city: 'القاهرة',
    area: 'مدينة نصر',
    positions: ['midfielder'],
    skillLevel: 'intermediate',
    language: 'ar',
    onboardingComplete: true,
  );

  group('GetMyProfileUseCase', () {
    test('returns profile successfully', () async {
      when(
        () => mockRepo.getMyProfile(),
      ).thenAnswer((_) async => const ApiResult.success(sampleProfile));

      final result = await getProfileUseCase();

      expect(result, isA<Success<MyProfileModel>>());
      result.when(
        success: (profile) => expect(profile.fullName, 'أحمد علي'),
        failure: (_) => fail('Expected success'),
      );
    });

    test('returns failure when repo fails', () async {
      when(() => mockRepo.getMyProfile()).thenAnswer(
        (_) async => const ApiResult.failure(
          AppApiFailure(message: 'error.unauthorized'),
        ),
      );

      final result = await getProfileUseCase();

      expect(result, isA<ApiFailure<MyProfileModel>>());
    });
  });

  group('CompleteProfileUseCase', () {
    const request = CompleteProfileRequestBody(
      fullName: 'أحمد علي',
      city: 'القاهرة',
      area: 'مدينة نصر',
    );

    test('completes profile successfully', () async {
      when(
        () => mockRepo.completeProfile(request),
      ).thenAnswer((_) async => const ApiResult.success(sampleProfile));

      final result = await completeProfileUseCase(request);

      expect(result, isA<Success<MyProfileModel>>());
    });
  });
}
