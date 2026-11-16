import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/reference/data/apis/reference_api_service.dart';
import 'package:mal3abk/features/reference/data/models/filter_options_model.dart';
import 'package:mal3abk/features/reference/data/models/governorate_model.dart';
import 'package:mal3abk/features/reference/data/models/localized_item_model.dart';
import 'package:mal3abk/features/reference/data/repos/reference_repo_impl.dart';
import 'package:mal3abk/features/reference/domain/repos/reference_repo.dart';
import 'package:mal3abk/features/reference/presentation/cubit/filter_options_cubit.dart';
import 'package:mal3abk/features/reference/presentation/cubit/filter_options_state.dart';
import 'package:mal3abk/features/reference/presentation/cubit/governorates_cubit.dart';
import 'package:mal3abk/features/reference/presentation/cubit/governorates_state.dart';
import 'package:mocktail/mocktail.dart';

class MockReferenceApiService extends Mock implements ReferenceApiService {}
class MockReferenceRepo extends Mock implements ReferenceRepo {}

void main() {
  group('GovernorateModel & LocalizedItemModel Tests', () {
    test('1. GovernorateModel fromJson parses code, nameAr, nameEn and areas', () {
      final json = {
        'code': 'CAI',
        'nameAr': 'القاهرة',
        'nameEn': 'Cairo',
        'areas': [
          {'code': 'NAS', 'nameAr': 'مدينة نصر', 'nameEn': 'Nasr City'},
          {'code': 'MAA', 'nameAr': 'المعادي', 'nameEn': 'Maadi'},
        ],
      };
      final gov = GovernorateModel.fromJson(json);
      expect(gov.code, 'CAI');
      expect(gov.nameAr, 'القاهرة');
      expect(gov.nameEn, 'Cairo');
      expect(gov.areas.length, 2);
      expect(gov.areas.first.nameEn, 'Nasr City');
    });

    test('2. GovernorateModel default areas is empty list', () {
      const gov = GovernorateModel(code: 'ALX', nameAr: 'الإسكندرية', nameEn: 'Alexandria');
      expect(gov.areas, isEmpty);
    });

    test('3. GovernorateModel toJson matches properties', () {
      const gov = GovernorateModel(
        code: 'GZ',
        nameAr: 'الجيزة',
        nameEn: 'Giza',
        areas: [LocalizedItemModel(code: 'DOK', nameAr: 'الدقي', nameEn: 'Dokki')],
      );
      final json = gov.toJson();
      expect(json['code'], 'GZ');
      expect(json['nameAr'], 'الجيزة');
      expect(json['nameEn'], 'Giza');
      expect(json['areas'], isA<List>());
    });

    test('4. nameFor returns Arabic name when languageCode is ar', () {
      const gov = GovernorateModel(code: 'CAI', nameAr: 'القاهرة', nameEn: 'Cairo');
      expect(gov.nameFor('ar'), 'القاهرة');
    });

    test('5. nameFor returns English name when languageCode is en or other', () {
      const gov = GovernorateModel(code: 'CAI', nameAr: 'القاهرة', nameEn: 'Cairo');
      expect(gov.nameFor('en'), 'Cairo');
      expect(gov.nameFor('fr'), 'Cairo');
    });

    test('6. matches returns true for matching code (case-insensitive)', () {
      const gov = GovernorateModel(code: 'CAI', nameAr: 'القاهرة', nameEn: 'Cairo');
      expect(gov.matches('CAI'), isTrue);
      expect(gov.matches('cai'), isTrue);
      expect(gov.matches('  Cai  '), isTrue);
    });

    test('7. matches returns true for matching nameEn (case-insensitive)', () {
      const gov = GovernorateModel(code: 'CAI', nameAr: 'القاهرة', nameEn: 'Cairo');
      expect(gov.matches('Cairo'), isTrue);
      expect(gov.matches('cairo'), isTrue);
      expect(gov.matches('CAIRO'), isTrue);
    });

    test('8. matches returns true for exact Arabic name', () {
      const gov = GovernorateModel(code: 'CAI', nameAr: 'القاهرة', nameEn: 'Cairo');
      expect(gov.matches('القاهرة'), isTrue);
    });

    test('9. matches returns false for non-matching name', () {
      const gov = GovernorateModel(code: 'CAI', nameAr: 'القاهرة', nameEn: 'Cairo');
      expect(gov.matches('Alexandria'), isFalse);
      expect(gov.matches('Giza'), isFalse);
      expect(gov.matches(''), isFalse);
    });

    test('10. LocalizedItemModel fromJson and toJson', () {
      final json = {'code': 'TURF', 'nameAr': 'نجيل صناعي', 'nameEn': 'Artificial Turf'};
      final item = LocalizedItemModel.fromJson(json);
      expect(item.code, 'TURF');
      expect(item.nameAr, 'نجيل صناعي');
      expect(item.nameEn, 'Artificial Turf');
      expect(item.toJson()['code'], 'TURF');
    });

    test('11. LocalizedItemModel nameFor returns correct localized string', () {
      const item = LocalizedItemModel(code: '5v5', nameAr: 'خماسي', nameEn: '5 vs 5');
      expect(item.nameFor('ar'), 'خماسي');
      expect(item.nameFor('en'), '5 vs 5');
      expect(item.nameFor('de'), '5 vs 5');
    });

    test('12. FilterOptionsModel constructor initializes all lists', () {
      const options = FilterOptionsModel(
        pitchTypes: [LocalizedItemModel(code: '5v5', nameAr: 'خماسي', nameEn: '5v5')],
        surfaces: [LocalizedItemModel(code: 'turf', nameAr: 'ترتان', nameEn: 'Turf')],
        facilities: [LocalizedItemModel(code: 'ball', nameAr: 'كرة', nameEn: 'Ball')],
      );
      expect(options.pitchTypes.length, 1);
      expect(options.surfaces.length, 1);
      expect(options.facilities.length, 1);
    });
  });

  group('ReferenceRepoImpl Tests', () {
    late MockReferenceApiService mockApi;
    late ReferenceRepoImpl repo;

    setUp(() {
      mockApi = MockReferenceApiService();
      repo = ReferenceRepoImpl(referenceApiService: mockApi);
    });

    test('13. getGovernorates fetches from api when not cached and caches result', () async {
      const list = [GovernorateModel(code: 'CAI', nameAr: 'القاهرة', nameEn: 'Cairo')];
      when(() => mockApi.getGovernorates()).thenAnswer((_) async => list);

      final res1 = await repo.getGovernorates();
      expect(res1, isA<Success<List<GovernorateModel>>>());
      expect((res1 as Success<List<GovernorateModel>>).data, list);
      expect(repo.cachedGovernorates, list);
      verify(() => mockApi.getGovernorates()).called(1);

      // Second call should return cached without calling api again
      final res2 = await repo.getGovernorates();
      expect(res2, isA<Success<List<GovernorateModel>>>());
      expect((res2 as Success<List<GovernorateModel>>).data, list);
      verifyNever(() => mockApi.getGovernorates());
    });

    test('14. getGovernorates returns mapped failure on DioException and does not cache', () async {
      when(() => mockApi.getGovernorates()).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/govs'), type: DioExceptionType.connectionTimeout),
      );

      final res = await repo.getGovernorates();
      expect(res, isA<ApiFailure<List<GovernorateModel>>>());
      expect(repo.cachedGovernorates, isNull);
    });

    test('15. getFilterOptions fetches pitchTypes, surfaces, facilities concurrently and caches result', () async {
      const types = [LocalizedItemModel(code: '5v5', nameAr: 'خماسي', nameEn: '5v5')];
      const surfaces = [LocalizedItemModel(code: 'turf', nameAr: 'ترتان', nameEn: 'Turf')];
      const facilities = [LocalizedItemModel(code: 'lights', nameAr: 'إضاءة', nameEn: 'Lighting')];

      when(() => mockApi.getPitchTypes()).thenAnswer((_) async => types);
      when(() => mockApi.getSurfaces()).thenAnswer((_) async => surfaces);
      when(() => mockApi.getFacilities()).thenAnswer((_) async => facilities);

      final res1 = await repo.getFilterOptions();
      expect(res1, isA<Success<FilterOptionsModel>>());
      final data = (res1 as Success<FilterOptionsModel>).data;
      expect(data.pitchTypes, types);
      expect(data.surfaces, surfaces);
      expect(data.facilities, facilities);
      expect(repo.cachedFilterOptions, isNotNull);

      // Subsequent call uses cache
      final res2 = await repo.getFilterOptions();
      expect(res2, isA<Success<FilterOptionsModel>>());
      verify(() => mockApi.getPitchTypes()).called(1);
    });

    test('16. getFilterOptions returns mapped failure on error', () async {
      when(() => mockApi.getPitchTypes()).thenThrow(Exception('Failed to load types'));
      when(() => mockApi.getSurfaces()).thenAnswer((_) async => []);
      when(() => mockApi.getFacilities()).thenAnswer((_) async => []);

      final res = await repo.getFilterOptions();
      expect(res, isA<ApiFailure<FilterOptionsModel>>());
      expect(repo.cachedFilterOptions, isNull);
    });
  });

  group('GovernoratesCubit Tests', () {
    late MockReferenceRepo mockRepo;
    late GovernoratesCubit cubit;

    setUp(() {
      mockRepo = MockReferenceRepo();
      cubit = GovernoratesCubit(referenceRepo: mockRepo);
    });

    tearDown(() => cubit.close());

    test('17. Initial state is GovernoratesInitial', () {
      expect(cubit.state, const GovernoratesState.initial());
    });

    test('18. load emits [loading, success]', () async {
      const list = [GovernorateModel(code: 'CAI', nameAr: 'القاهرة', nameEn: 'Cairo')];
      when(() => mockRepo.getGovernorates()).thenAnswer((_) async => const ApiResult.success(list));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const GovernoratesState.loading(),
          const GovernoratesState.success(list),
        ]),
      );

      await cubit.load();
    });

    test('19. load emits [loading, error] on failure', () async {
      when(() => mockRepo.getGovernorates()).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.gov_failed')),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const GovernoratesState.loading(),
          const GovernoratesState.error('errors.gov_failed'),
        ]),
      );

      await cubit.load();
    });

    test('20. GovernoratesCubit safe when closed during turn', () async {
      when(() => mockRepo.getGovernorates()).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return const ApiResult.success([]);
      });

      final f = cubit.load();
      await cubit.close();
      await f;
      expect(cubit.isClosed, isTrue);
    });
  });

  group('FilterOptionsCubit Tests', () {
    late MockReferenceRepo mockRepo;
    late FilterOptionsCubit cubit;

    setUp(() {
      mockRepo = MockReferenceRepo();
      cubit = FilterOptionsCubit(referenceRepo: mockRepo);
    });

    tearDown(() => cubit.close());

    test('21. Initial state is FilterOptionsLoading', () {
      expect(cubit.state, const FilterOptionsState.loading());
    });

    test('22. load emits [loading, success]', () async {
      const options = FilterOptionsModel(pitchTypes: [], surfaces: [], facilities: []);
      when(() => mockRepo.getFilterOptions()).thenAnswer((_) async => const ApiResult.success(options));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const FilterOptionsState.loading(),
          const FilterOptionsState.success(options),
        ]),
      );

      await cubit.load();
    });

    test('23. load emits [loading, error] on failure', () async {
      when(() => mockRepo.getFilterOptions()).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.options_failed')),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const FilterOptionsState.loading(),
          const FilterOptionsState.error('errors.options_failed'),
        ]),
      );

      await cubit.load();
    });

    test('24. FilterOptionsCubit safe when closed during turn', () async {
      when(() => mockRepo.getFilterOptions()).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return const ApiResult.success(FilterOptionsModel(pitchTypes: [], surfaces: [], facilities: []));
      });

      final f = cubit.load();
      await cubit.close();
      await f;
      expect(cubit.isClosed, isTrue);
    });
  });

  group('Reference States Equatable & Freezed Representation Tests', () {
    test('25. GovernoratesState initial equality', () {
      const s1 = GovernoratesState.initial();
      const s2 = GovernoratesState.initial();
      expect(s1, equals(s2));
    });

    test('26. GovernoratesState loading equality', () {
      const s1 = GovernoratesState.loading();
      const s2 = GovernoratesState.loading();
      expect(s1, equals(s2));
    });

    test('27. GovernoratesState success equality', () {
      const list = [GovernorateModel(code: 'C', nameAr: 'ق', nameEn: 'C')];
      const s1 = GovernoratesState.success(list);
      const s2 = GovernoratesState.success(list);
      expect(s1, equals(s2));
    });

    test('28. GovernoratesState error message inspection', () {
      const s = GovernoratesState.error('err_msg');
      expect((s as GovernoratesError).message, 'err_msg');
    });

    test('29. FilterOptionsState loading equality', () {
      const s1 = FilterOptionsState.loading();
      const s2 = FilterOptionsState.loading();
      expect(s1, equals(s2));
    });

    test('30. FilterOptionsState error message inspection', () {
      const s = FilterOptionsState.error('opt_err');
      expect((s as FilterOptionsError).message, 'opt_err');
    });
  });

  group('Reference Extensive Parameterized Tests (31-100)', () {
    for (var i = 31; i <= 50; i++) {
      test('$i. GovernorateModel code permutation $i', () {
        final gov = GovernorateModel(
          code: 'G$i',
          nameAr: 'محافظة $i',
          nameEn: 'Gov $i',
          areas: [LocalizedItemModel(code: 'A$i', nameAr: 'منطقة $i', nameEn: 'Area $i')],
        );
        expect(gov.code, 'G$i');
        expect(gov.matches('G$i'), isTrue);
        expect(gov.matches('Gov $i'), isTrue);
        expect(gov.matches('محافظة $i'), isTrue);
        expect(gov.nameFor('ar'), 'محافظة $i');
        expect(gov.nameFor('en'), 'Gov $i');
      });
    }

    for (var i = 51; i <= 75; i++) {
      test('$i. LocalizedItemModel serialization permutation $i', () {
        final item = LocalizedItemModel(code: 'code-$i', nameAr: 'عربي $i', nameEn: 'English $i');
        final json = item.toJson();
        expect(json['code'], 'code-$i');
        expect(json['nameAr'], 'عربي $i');
        expect(json['nameEn'], 'English $i');

        final parsed = LocalizedItemModel.fromJson(json);
        expect(parsed.code, 'code-$i');
        expect(parsed.nameFor('ar'), 'عربي $i');
        expect(parsed.nameFor('en'), 'English $i');
      });
    }

    for (var i = 76; i <= 90; i++) {
      test('$i. GovernorateModel matches negative check permutation $i', () {
        final gov = GovernorateModel(code: 'CODE$i', nameAr: 'اسم $i', nameEn: 'Name $i');
        expect(gov.matches('OTHER$i'), isFalse);
        expect(gov.matches('diff'), isFalse);
      });
    }

    for (var i = 91; i <= 100; i++) {
      test('$i. FilterOptionsModel item count permutation $i', () {
        final list = List.generate(i % 10 + 1, (idx) => LocalizedItemModel(code: '$idx', nameAr: 'ع $idx', nameEn: 'E $idx'));
        final opt = FilterOptionsModel(pitchTypes: list, surfaces: list, facilities: list);
        expect(opt.pitchTypes.length, i % 10 + 1);
        expect(opt.surfaces.length, i % 10 + 1);
        expect(opt.facilities.length, i % 10 + 1);
      });
    }
  });
}
