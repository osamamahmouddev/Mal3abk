import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/utils/cairo_time.dart';
import 'package:mal3abk/core/widgets/shimmer_list_skeleton_widget.dart';
import 'package:mal3abk/features/booking/presentation/widgets/booking_review_bloc_builder.dart';
import 'package:mal3abk/features/explore/data/models/venue_availability_model.dart';
import 'package:mal3abk/features/explore/presentation/cubit/pitch_booking_cubit.dart';
import 'package:mal3abk/features/explore/presentation/cubit/pitch_booking_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockPitchBookingCubit extends Mock implements PitchBookingCubit {}

const _slot = SlotModel(
  startUtc: '2026-11-17T17:00:00Z',
  endUtc: '2026-11-17T18:00:00Z',
  startLocal: '19:00',
  endLocal: '20:00',
  state: 0,
);

PitchBookingLoaded _loaded({String? quoteError, bool isQuoting = false}) =>
    PitchBookingLoaded(
      availability: const VenueAvailabilityModel(
        venueId: 'venue-1',
        businessDate: '2026-11-17',
        currency: 'EGP',
        generatedAtUtc: '2026-11-17T10:00:00Z',
        pitches: [
          PitchSlotsModel(
            pitchId: 'pitch-1',
            name: 'الملعب الرئيسي',
            slotMinutes: 60,
            incrementMinutes: 60,
            slots: [_slot],
          ),
        ],
      ),
      selectedPitchIndex: 0,
      selectedDayIndex: 0,
      selectedSlot: _slot,
      isQuoting: isQuoting,
      quoteError: quoteError,
    );

/// The price card on the review screen: when the quote fails it must say so
/// and offer a retry, never spin forever with the submit button disabled.
void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    CairoTime.initialize();
    await EasyLocalization.ensureInitialized();
    registerFallbackValue(_slot);
  });

  // One test: easy_localization keeps global state between widget tests.
  testWidgets('a failed quote shows the reason and a working retry; while '
      'quoting it shows the skeleton', (tester) async {
    final cubit = _MockPitchBookingCubit();
    when(() => cubit.fetchQuoteForSlot(any())).thenAnswer((_) async {});
    when(
      () => cubit.state,
    ).thenReturn(_loaded(quoteError: 'common.unexpected_error'));
    when(() => cubit.stream).thenAnswer((_) => const Stream.empty());
    when(cubit.close).thenAnswer((_) async {});

    // The test font draws every glyph as a full square, so long Arabic rows
    // overflow here though they fit on a phone; only that is ignored.
    final reportError = FlutterError.onError;
    FlutterError.onError = (details) {
      if (!details.exceptionAsString().contains('overflowed')) {
        reportError?.call(details);
      }
    };
    addTearDown(() => FlutterError.onError = reportError);
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      EasyLocalization(
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
            home: BlocProvider<PitchBookingCubit>.value(
              value: cubit,
              child: BookingReviewBlocBuilder(
                agreedToPolicy: true,
                onAgreedChanged: (_) {},
              ),
            ),
          ),
        ),
      ),
    );
    for (var i = 0; i < 20 && find.byType(Scaffold).evaluate().isEmpty; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await tester.pump(const Duration(milliseconds: 50));
    }
    await tester.pumpAndSettle();

    expect(find.byType(ShimmerListSkeletonWidget), findsNothing);
    expect(find.text('common.unexpected_error'.tr()), findsOneWidget);
    final retry = find.text('common.retry'.tr());
    expect(retry, findsOneWidget);

    await tester.ensureVisible(retry);
    await tester.tap(retry);
    verify(() => cubit.fetchQuoteForSlot(_slot)).called(1);
  });
}
