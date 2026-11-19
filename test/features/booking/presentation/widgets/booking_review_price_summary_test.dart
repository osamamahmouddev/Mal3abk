import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/utils/cairo_time.dart';
import 'package:mal3abk/features/booking/data/models/booking_quote_response_model.dart';
import 'package:mal3abk/features/booking/presentation/widgets/booking_review_bloc_builder.dart';
import 'package:mal3abk/features/explore/data/models/venue_availability_model.dart';
import 'package:mal3abk/features/explore/presentation/cubit/pitch_booking_cubit.dart';
import 'package:mal3abk/features/explore/presentation/cubit/pitch_booking_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockPitchBookingCubit extends Mock implements PitchBookingCubit {}

const _slot = SlotModel(
  startUtc: '2026-11-19T21:00:00Z',
  endUtc: '2026-11-19T22:00:00Z',
  startLocal: '23:00',
  endLocal: '00:00',
  state: 0,
);

/// 200 for the pitch; 66 paid now (the venue's deposit plus our 40
/// commission), 134 cash at the venue.
const _quote = BookingQuoteResponseModel(
  quoteToken: 'q',
  expiresAtUtc: '2026-11-19T20:15:00Z',
  currency: 'EGP',
  subtotal: 200,
  discount: 0,
  fees: 0,
  total: 200,
  deposit: 66,
  remainingBalance: 134,
  subjectToConfirmation: true,
  confirmationNote: '',
  netPitchPrice: 200,
  platformCommission: 40,
  onlineDepositAmount: 66,
  venuePayAmount: 134,
);

/// The review screen's price summary, as the team asked: pitch price,
/// deposit, cash at the venue, total, then what is due now. The platform
/// commission is never shown to players.
void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    CairoTime.initialize();
    await EasyLocalization.ensureInitialized();
  });

  // One test: easy_localization keeps global state between widget tests.
  testWidgets('shows price, deposit, cash, total and due now, in that order, '
      'and never the commission', (tester) async {
    final cubit = _MockPitchBookingCubit();
    when(() => cubit.state).thenReturn(
      const PitchBookingLoaded(
        availability: VenueAvailabilityModel(
          venueId: 'venue-1',
          businessDate: '2026-11-19',
          currency: 'EGP',
          generatedAtUtc: '2026-11-19T10:00:00Z',
          pitches: [
            PitchSlotsModel(
              pitchId: 'pitch-1',
              name: 'Main',
              slotMinutes: 60,
              incrementMinutes: 60,
              slots: [_slot],
            ),
          ],
        ),
        selectedPitchIndex: 0,
        selectedDayIndex: 0,
        selectedSlot: _slot,
        quote: _quote,
      ),
    );
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
    tester.view.physicalSize = const Size(390, 2400);
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

    String r(String key) => 'booking.review.$key'.tr();
    final order = [
      r('pitch_price'),
      r('deposit'),
      r('cash_at_venue'),
      r('total'),
      r('pay_online_now'),
    ];
    final tops = [
      for (final label in order) tester.getTopLeft(find.text(label)).dy,
    ];
    for (var i = 1; i < tops.length; i++) {
      expect(
        tops[i],
        greaterThan(tops[i - 1]),
        reason: '"${order[i]}" comes after "${order[i - 1]}"',
      );
    }

    expect(find.text(r('platform_commission')), findsNothing);
    expect(find.text(r('net_pitch_price')), findsNothing);
    expect(find.textContaining('٤٠'), findsNothing, reason: 'the commission');
  });
}
