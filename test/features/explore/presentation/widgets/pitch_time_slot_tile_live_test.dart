import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/animations/live_cross_out_painters.dart';
import 'package:mal3abk/features/explore/presentation/widgets/pitch_time_slot_tile_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The live cross-out on a slot tile: it plays only when the slot changes
/// on screen, settles in [PitchTimeSlotTileWidget.liveDuration], leaves
/// nothing running, and stays still with reduced motion.
void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  // One widget test: easy_localization keeps global state between them.
  testWidgets('the live cross-out plays on change only, settles, and '
      'respects reduced motion', (tester) async {
    final booked = ValueNotifier(false);
    final reduced = ValueNotifier(false);
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
            home: ValueListenableBuilder<bool>(
              valueListenable: reduced,
              builder: (context, isReduced, _) => MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(disableAnimations: isReduced),
                child: Scaffold(
                  body: Center(
                    child: SizedBox(
                      width: 110,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: booked,
                        builder: (context, isBooked, _) =>
                            PitchTimeSlotTileWidget(
                              time: '٩:٠٠ ص',
                              isBooked: isBooked,
                              isSelected: true,
                              onTap: () {},
                            ),
                      ),
                    ),
                  ),
                ),
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

    CrossOutStrokePainter stroke() =>
        tester
                .widget<CustomPaint>(
                  find.byWidgetPredicate(
                    (w) =>
                        w is CustomPaint &&
                        w.foregroundPainter is CrossOutStrokePainter,
                  ),
                )
                .foregroundPainter!
            as CrossOutStrokePainter;
    LivePulsePainter pulse() =>
        tester
                .widget<CustomPaint>(
                  find.byWidgetPredicate(
                    (w) =>
                        w is CustomPaint &&
                        w.foregroundPainter is LivePulsePainter,
                  ),
                )
                .foregroundPainter!
            as LivePulsePainter;
    final bookedLabel = find.text('explore.slots.booked'.tr());

    // Open and picked: no stroke, nothing running.
    expect(stroke().progress, 0);
    expect(tester.hasRunningAnimations, isFalse);

    // Someone takes it: the pulse leads, the pen is mid-stroke.
    booked.value = true;
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(pulse().progress, greaterThan(0));
    expect(stroke().progress, inExclusiveRange(0, 1));
    expect(tester.hasRunningAnimations, isTrue);

    // Settled within the live duration: crossed out, labelled, idle.
    await tester.pump(PitchTimeSlotTileWidget.liveDuration);
    await tester.pumpAndSettle();
    expect(stroke().progress, 1);
    expect(pulse().progress, 0);
    expect(bookedLabel, findsOneWidget);
    expect(tester.hasRunningAnimations, isFalse);

    // Freed again: the stroke lifts off.
    booked.value = false;
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(stroke().progress, inExclusiveRange(0, 1));
    await tester.pumpAndSettle();
    expect(stroke().progress, 0);
    expect(bookedLabel, findsNothing);

    // Reduced motion: the change is shown at once, nothing animates.
    reduced.value = true;
    await tester.pump();
    booked.value = true;
    await tester.pump();
    expect(stroke().progress, 1);
    expect(tester.hasRunningAnimations, isFalse);
  });
}
