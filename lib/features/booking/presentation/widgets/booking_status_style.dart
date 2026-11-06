import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/booking_card_widget.dart';
import '../../data/models/booking_status.dart';

/// Label key, badge and card tone for each booking status.
class BookingStatusStyle {
  const BookingStatusStyle._();

  static String labelKey(BookingStatus status) =>
      'booking.status.${status.name}';

  static AppBadgeType badge(BookingStatus status) => switch (status) {
    BookingStatus.confirmed || BookingStatus.completed => AppBadgeType.success,
    BookingStatus.pendingDeposit ||
    BookingStatus.proofSubmitted ||
    BookingStatus.underReview ||
    BookingStatus.draft => AppBadgeType.warning,
    BookingStatus.rejected || BookingStatus.noShow => AppBadgeType.error,
    BookingStatus.cancelled || BookingStatus.expired => AppBadgeType.neutral,
  };

  static BookingCardTone tone(BookingStatus status) => switch (status) {
    BookingStatus.confirmed => BookingCardTone.confirmed,
    BookingStatus.completed => BookingCardTone.completed,
    BookingStatus.rejected || BookingStatus.noShow => BookingCardTone.rejected,
    BookingStatus.cancelled ||
    BookingStatus.expired => BookingCardTone.cancelled,
    _ => BookingCardTone.pendingReview,
  };
}
