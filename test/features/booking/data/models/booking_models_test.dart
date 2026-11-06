import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/booking/data/models/booking_status.dart';
import 'package:mal3abk/features/booking/data/models/player_booking_summary_model.dart';

import '../../../../helpers/booking_fixtures.dart';

void main() {
  test('reads the server status numbers', () {
    expect(
      PlayerBookingSummaryModel.fromJson(summaryJson(4)).status,
      BookingStatus.underReview,
    );
    expect(
      PlayerBookingSummaryModel.fromJson(summaryJson(5)).status,
      BookingStatus.confirmed,
    );
    expect(
      PlayerBookingSummaryModel.fromJson(summaryJson(8)).status,
      BookingStatus.cancelled,
    );
  });

  test('keeps the venue and pitch names', () {
    final booking = PlayerBookingSummaryModel.fromJson(summaryJson(5));

    expect((booking.venueName, booking.pitchName), ('ملعب النجوم', 'ملعب ١'));
    expect(booking.startAt, DateTime.utc(2026, 11, 6, 17));
  });

  test('only confirmed and played bookings get a pass', () {
    expect(BookingStatus.confirmed.hasPass, isTrue);
    expect(BookingStatus.completed.hasPass, isTrue);
    expect(BookingStatus.underReview.hasPass, isFalse);
    expect(BookingStatus.cancelled.hasPass, isFalse);
  });
}
