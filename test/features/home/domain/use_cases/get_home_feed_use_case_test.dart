import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/home/data/models/home_feed_model.dart';
import 'package:mal3abk/features/home/domain/repos/home_repo.dart';
import 'package:mal3abk/features/home/domain/use_cases/get_home_feed_use_case.dart';
import 'package:mal3abk/features/profile/data/models/my_profile_model.dart';
import 'package:mal3abk/features/profile/domain/repos/profile_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepo extends Mock implements HomeRepo {}

class MockProfileRepo extends Mock implements ProfileRepo {}

void main() {
  late MockHomeRepo homeRepo;
  late MockProfileRepo profileRepo;
  late GetHomeFeedUseCase useCase;

  const feed = HomeFeedModel(
    nearby: HomeSectionModel(status: 'ok'),
    popularNearYou: HomeSectionModel(status: 'empty'),
    recentlyViewed: HomeSectionModel(status: 'ok'),
    generatedAtUtc: '2026-10-31T20:00:00Z',
  );

  setUp(() {
    homeRepo = MockHomeRepo();
    profileRepo = MockProfileRepo();
    useCase = GetHomeFeedUseCase(homeRepo: homeRepo, profileRepo: profileRepo);
  });

  test('uses the player\'s own city and area', () async {
    when(() => profileRepo.getMyProfile()).thenAnswer(
      (_) async => const ApiResult.success(
        MyProfileModel(
          userId: 'u',
          fullName: 'أحمد',
          phoneNumber: '+201012345678',
          city: 'الجيزة',
          area: 'الدقي',
        ),
      ),
    );
    when(
      () => homeRepo.getHomeFeed(city: 'الجيزة', area: 'الدقي'),
    ).thenAnswer((_) async => const ApiResult.success(feed));

    final located = (await useCase() as Success).data;

    expect((located.city, located.area), ('الجيزة', 'الدقي'));
  });

  test('falls back to the whole country without a profile place', () async {
    when(() => profileRepo.getMyProfile()).thenAnswer(
      (_) async => const ApiResult.success(
        MyProfileModel(userId: 'u', fullName: 'أحمد', phoneNumber: '+20101'),
      ),
    );
    when(
      () => homeRepo.getHomeFeed(),
    ).thenAnswer((_) async => const ApiResult.success(feed));

    final located = (await useCase() as Success).data;

    expect(located.city, isNull);
  });

  test('an explicit place skips the profile lookup', () async {
    when(
      () => homeRepo.getHomeFeed(city: 'القاهرة', area: 'المعادي'),
    ).thenAnswer((_) async => const ApiResult.success(feed));

    await useCase(city: 'القاهرة', area: 'المعادي');

    verifyZeroInteractions(profileRepo);
  });
}
