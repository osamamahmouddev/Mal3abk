import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import '../../../core/extensions/app_display_extensions.dart';
import '../../../core/utils/cairo_time.dart';
import '../../../core/widgets/app_badge_widget.dart';
import '../data/models/venue_booking_status.dart';

export '../data/models/venue_booking_status.dart';

/// Labels and formats shared by the venue screens, the same wording as the
/// venue web dashboard.
abstract final class VenueFormat {
  static bool _ar(BuildContext context) => context.locale.languageCode == 'ar';

  /// A manual booking taken without a deposit is "tentative", not "waiting
  /// for the deposit".
  static String statusKey(
    int status, {
    bool isManual = false,
    num deposit = 1,
  }) {
    if (status == VenueBookingStatus.pendingDeposit &&
        isManual &&
        deposit == 0) {
      return 'tentative';
    }
    return VenueBookingStatus.keys[status] ?? 'draft';
  }

  static String statusLabel(
    BuildContext context,
    int status, {
    bool isManual = false,
    num deposit = 1,
  }) =>
      'venue.status.${statusKey(status, isManual: isManual, deposit: deposit)}'
          .tr(context: context);

  static AppBadgeType statusTone(
    int status, {
    bool isManual = false,
    num deposit = 1,
  }) => switch (statusKey(status, isManual: isManual, deposit: deposit)) {
    'confirmed' || 'completed' => AppBadgeType.success,
    'proof_submitted' || 'under_review' => AppBadgeType.warning,
    'rejected' || 'no_show' => AppBadgeType.error,
    'pending_deposit' || 'tentative' || 'draft' => AppBadgeType.accent,
    _ => AppBadgeType.neutral,
  };

  static String depositState(BuildContext context, String state) {
    const known = {
      'Approved',
      'Received',
      'UnderReview',
      'AwaitingUpload',
      'ManualAwaitingDeposit',
      'PayAtVenue',
      'Cancelled',
    };
    return known.contains(state)
        ? 'venue.deposit_state.$state'.tr(context: context)
        : '—';
  }

  /// "١٬٦٥٠ ج.م"
  static String money(
    BuildContext context,
    num amount, [
    String currency = 'EGP',
  ]) {
    final value = intl.NumberFormat.decimalPattern('en').format(amount.round());
    final text = _ar(context)
        ? value.toArabicDigits().replaceAll(',', '٬')
        : value;
    return currency == 'EGP'
        ? 'common.price_egp'.tr(context: context, args: [text])
        : '$text $currency';
  }

  static String number(BuildContext context, num value) =>
      _ar(context) ? '$value'.toArabicDigits() : '$value';

  static String percent(BuildContext context, num value) =>
      '${number(context, value.round())}٪';

  static String time(BuildContext context, String utc) =>
      _digits(context, CairoTime.time(CairoTime.parseUtc(utc), _lang(context)));

  /// "٥ نوفمبر، ٧:٠٠ م"
  static String dateTime(BuildContext context, String utc) {
    final parsed = CairoTime.parseUtc(utc);
    final lang = _lang(context);
    return _digits(
      context,
      '${CairoTime.shortDate(parsed, lang)}، ${CairoTime.time(parsed, lang)}',
    );
  }

  /// "الخميس ٥ نوفمبر"
  static String day(BuildContext context, DateTime date) => _digits(
    context,
    intl.DateFormat('EEEE d MMMM', _lang(context)).format(date),
  );

  /// Minutes until [utc] in words ("١ س ٤٨ د"), or that it ran out.
  static String timeLeft(BuildContext context, String? utc) {
    if (utc == null) return '';
    final minutes = CairoTime.parseUtc(
      utc,
    ).difference(DateTime.now().toUtc()).inMinutes;
    if (minutes <= 0) return 'venue.time_left.expired'.tr(context: context);
    final h = minutes ~/ 60;
    final m = minutes % 60;
    final text = h > 0
        ? 'venue.time_left.hours_minutes'.tr(
            context: context,
            args: [number(context, h), number(context, m)],
          )
        : 'venue.time_left.minutes'.tr(
            context: context,
            args: [number(context, m)],
          );
    return text;
  }

  /// yyyy-MM-dd, the API's date format.
  static String apiDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  static String _lang(BuildContext context) => context.locale.languageCode;

  static String _digits(BuildContext context, String text) =>
      _ar(context) ? text.toArabicDigits() : text;
}
