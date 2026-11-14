import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/reference/data/models/governorate_model.dart';
import 'package:mal3abk/features/reference/data/models/localized_item_model.dart';
import 'package:mal3abk/features/reference/domain/repos/reference_repo.dart';
import 'package:mal3abk/features/reference/presentation/cubit/governorates_cubit.dart';
import 'package:mal3abk/features/reference/presentation/cubit/governorates_state.dart';
import 'package:mal3abk/features/reference/presentation/widgets/governorate_area_picker_bloc_builder.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockReferenceRepo extends Mock implements ReferenceRepo {}

/// A governorates cubit the test drives by hand.
class _FakeGovernoratesCubit extends GovernoratesCubit {
  _FakeGovernoratesCubit(GovernoratesState initial)
    : super(referenceRepo: _MockReferenceRepo()) {
    emit(initial);
  }

  void set(GovernoratesState state) => emit(state);
}

const _cairo = GovernorateModel(
  code: 'cairo',
  nameAr: 'القاهرة',
  nameEn: 'Cairo',
  areas: [
    LocalizedItemModel(code: 'shubra', nameAr: 'شبرا', nameEn: 'Shubra'),
    LocalizedItemModel(code: 'maadi', nameAr: 'المعادي', nameEn: 'Maadi'),
  ],
);

const _giza = GovernorateModel(
  code: 'giza',
  nameAr: 'الجيزة',
  nameEn: 'Giza',
  areas: [],
);

const _loaded = GovernoratesState.success([_cairo, _giza]);

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  Widget app(
    GovernoratesCubit cubit, {
    required ValueNotifier<GovernorateModel?> governorate,
    required ValueNotifier<String?> area,
    String? initialCity,
    String? initialArea,
    Key? key,
  }) => EasyLocalization(
    supportedLocales: const [Locale('ar')],
    path: 'assets/translations',
    fallbackLocale: const Locale('ar'),
    startLocale: const Locale('ar'),
    useOnlyLangCode: true,
    child: ScreenUtilPlusInit(
      designSize: const Size(390, 844),
      builder: (context, _) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: Scaffold(
          body: BlocProvider<GovernoratesCubit>.value(
            value: cubit,
            child: SingleChildScrollView(
              child: GovernorateAreaPickerBlocBuilder(
                key: key,
                label: 'area',
                governorate: governorate,
                area: area,
                isRequired: false,
                initialCity: initialCity,
                initialArea: initialArea,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  /// easy_localization loads translations asynchronously; let real time pass.
  Future<void> pump(
    WidgetTester tester,
    Widget widget, {
    bool settle = true,
  }) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(widget);
    for (var i = 0; i < 20 && find.byType(Scaffold).evaluate().isEmpty; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await tester.pump(const Duration(milliseconds: 50));
    }
    // A loading skeleton shimmers forever, so it never settles.
    settle
        ? await tester.pumpAndSettle()
        : await tester.pump(const Duration(milliseconds: 100));
  }

  // One test: easy_localization keeps global state, so separate tests would
  // race it. Each case uses its own notifiers and key.
  testWidgets('shows the current governorate and area when changing them', (
    tester,
  ) async {
    // 1. Governorates already loaded (the usual case for the home sheet).
    var governorate = ValueNotifier<GovernorateModel?>(null);
    var area = ValueNotifier<String?>(null);
    await pump(
      tester,
      app(
        _FakeGovernoratesCubit(_loaded),
        governorate: governorate,
        area: area,
        initialCity: 'cairo',
        initialArea: 'شبرا',
        key: const ValueKey(1),
      ),
    );
    expect(governorate.value, _cairo, reason: 'loaded before the sheet');
    expect(area.value, 'شبرا');

    // 2. Governorates arrive after the picker opened.
    governorate = ValueNotifier<GovernorateModel?>(null);
    area = ValueNotifier<String?>(null);
    final late = _FakeGovernoratesCubit(const GovernoratesState.loading());
    await pump(
      tester,
      app(
        late,
        governorate: governorate,
        area: area,
        initialCity: 'Cairo',
        initialArea: 'المعادي',
        key: const ValueKey(2),
      ),
      settle: false,
    );
    expect(governorate.value, isNull);
    late.set(_loaded);
    await tester.pumpAndSettle();
    expect(governorate.value, _cairo, reason: 'loaded after the sheet');
    expect(area.value, 'المعادي');

    // 3. An area saved in English is mapped to the listed Arabic name.
    governorate = ValueNotifier<GovernorateModel?>(null);
    area = ValueNotifier<String?>(null);
    await pump(
      tester,
      app(
        _FakeGovernoratesCubit(_loaded),
        governorate: governorate,
        area: area,
        initialCity: 'القاهرة',
        initialArea: 'shubra',
        key: const ValueKey(3),
      ),
    );
    expect(area.value, 'شبرا');

    // 4. An area missing from the list stays as typed ("another area").
    governorate = ValueNotifier<GovernorateModel?>(null);
    area = ValueNotifier<String?>(null);
    await pump(
      tester,
      app(
        _FakeGovernoratesCubit(_loaded),
        governorate: governorate,
        area: area,
        initialCity: 'cairo',
        initialArea: 'روض الفرج',
        key: const ValueKey(4),
      ),
    );
    expect(area.value, 'روض الفرج');

    // 5. A choice already made is never replaced.
    governorate = ValueNotifier<GovernorateModel?>(_giza);
    area = ValueNotifier<String?>('الدقي');
    await pump(
      tester,
      app(
        _FakeGovernoratesCubit(_loaded),
        governorate: governorate,
        area: area,
        initialCity: 'cairo',
        initialArea: 'شبرا',
        key: const ValueKey(5),
      ),
    );
    expect(governorate.value, _giza);
    expect(area.value, 'الدقي');

    // 6. No current choice (all of Egypt): nothing is preselected.
    governorate = ValueNotifier<GovernorateModel?>(null);
    area = ValueNotifier<String?>(null);
    await pump(
      tester,
      app(
        _FakeGovernoratesCubit(_loaded),
        governorate: governorate,
        area: area,
        key: const ValueKey(6),
      ),
    );
    expect(governorate.value, isNull);
    expect(area.value, isNull);

    // 7. An unknown governorate selects nothing.
    governorate = ValueNotifier<GovernorateModel?>(null);
    area = ValueNotifier<String?>(null);
    await pump(
      tester,
      app(
        _FakeGovernoratesCubit(_loaded),
        governorate: governorate,
        area: area,
        initialCity: 'atlantis',
        initialArea: 'شبرا',
        key: const ValueKey(7),
      ),
    );
    expect(governorate.value, isNull);
    expect(area.value, isNull);
  });
}
