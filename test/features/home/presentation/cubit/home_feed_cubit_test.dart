import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/home/domain/use_cases/get_home_feed_use_case.dart';
import 'package:mal3abk/features/home/presentation/cubit/home_feed_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/auth_fixtures.dart';

class MockGetHomeFeedUseCase extends Mock implements GetHomeFeedUseCase {}

void main() {
  late MockGetHomeFeedUseCase useCase;
  late HomeFeedCubit cubit;

  setUp(() {
    useCase = MockGetHomeFeedUseCase();
    when(
      () => useCase(
        city: any(named: 'city'),
        area: any(named: 'area'),
      ),
    ).thenAnswer((_) async => const ApiResult.failure(serverFailure));
    cubit = HomeFeedCubit(getHomeFeedUseCase: useCase);
  });

  tearDown(() => cubit.close());

  test('refreshing keeps the area the player picked', () async {
    await cubit.fetchFeed(city: 'giza', area: 'dokki');

    await cubit.fetchFeed();

    verify(() => useCase(city: 'giza', area: 'dokki')).called(2);
  });

  test('uses the profile area until the player picks one', () async {
    await cubit.fetchFeed();

    verify(() => useCase(city: null, area: null)).called(1);
  });
}
