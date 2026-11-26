import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/utils/cairo_time.dart';
import 'package:mal3abk/features/venue_bookings/data/models/venue_booking_item_model.dart';
import 'package:mal3abk/features/venue_bookings/presentation/widgets/venue_booking_card_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/pump_localized.dart';

VenueBookingItemModel booking({required bool manual, required int status}) =>
    VenueBookingItemModel(
      id: manual ? 'm' : 'a',
      reference: manual ? 'MB-1' : 'MB-2',
      pitchId: 'p1',
      startUtc: '2026-12-01T18:00:00Z',
      endUtc: '2026-12-01T19:00:00Z',
      status: status,
      totalPrice: 400,
      depositAmount: manual ? 0 : 100,
      customerName: manual ? 'Ali' : 'Omar',
      isManual: manual,
    );

/// A held manual booking can be confirmed from the list; an app booking that
/// waits for its deposit says so and has no confirm button.
void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    CairoTime.initialize();
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('booking cards show status, deposit and the confirm action', (
    tester,
  ) async {
    var confirmed = 0;
    await pumpLocalized(
      tester,
      ListView(
        children: [
          VenueBookingCardWidget(
            booking: booking(manual: true, status: 2),
            pitchName: 'Pitch 1',
            canConfirm: true,
            isConfirming: false,
            onConfirm: () => confirmed++,
            onDetails: () {},
          ),
          VenueBookingCardWidget(
            booking: booking(manual: false, status: 2),
            pitchName: 'Pitch 1',
            canConfirm: true,
            isConfirming: false,
            onConfirm: () => confirmed++,
            onDetails: () {},
          ),
        ],
      ),
    );

    expect(find.text('Ali'), findsOneWidget);
    expect(find.text('venue.status.tentative'.tr()), findsOneWidget);
    // Status badge and hint line say the same words, as on the web.
    expect(
      'venue.status.pending_deposit'.tr(),
      'venue.bookings.card.waiting_deposit'.tr(),
    );
    expect(
      find.text('venue.bookings.card.waiting_deposit'.tr()),
      findsNWidgets(2),
    );
    expect(find.text('venue.bookings.card.confirm'.tr()), findsOneWidget);

    await tester.tap(find.text('venue.bookings.card.confirm'.tr()));
    await tester.pump();
    expect(confirmed, 1);
  });
}
