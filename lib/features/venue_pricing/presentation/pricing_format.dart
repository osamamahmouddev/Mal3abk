import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import '../../../core/utils/cairo_time.dart';
import '../../venue_setup/presentation/widgets/week_hours_editor_widget.dart';
import '../../venue_shell/presentation/venue_format.dart';
import '../data/models/price_rule_model.dart';

/// How the web pricing page words a rule.
abstract final class PricingFormat {
  static String kindLabel(BuildContext context, String kind) =>
      'venue.pricing.kind.$kind'.tr(context: context);

  static String dayName(BuildContext context, int dotNetDay) => intl.DateFormat(
    'EEEE',
    context.locale.languageCode,
  ).format(DateTime(2026, 1, 4 + dotNetDay));

  static String value(BuildContext context, PriceRuleModel r) {
    String n(num v) => VenueFormat.number(context, v);
    if (r.adjustment == 'Percentage') {
      final p = r.percent ?? 0;
      return r.kind == 'Discount'
          ? 'venue.pricing.value.discount_percent'.tr(
              context: context,
              args: [n(p)],
            )
          : 'venue.pricing.value.percent'.tr(
              context: context,
              args: ['${p > 0 ? '+' : ''}${n(p)}'],
            );
    }
    final money = VenueFormat.money(context, r.amount ?? 0, r.currency);
    return r.adjustment == 'FixedAmountOff'
        ? 'venue.pricing.value.amount_off'.tr(context: context, args: [money])
        : 'venue.pricing.value.hourly'.tr(context: context, args: [money]);
  }

  static String when(BuildContext context, PriceRuleModel r) {
    final parts = <String>[
      if (r.days?.isNotEmpty ?? false)
        r.days!
            .map((d) => PriceRuleDraft.dayNames.indexOf(d))
            .where((d) => d >= 0)
            .map((d) => dayName(context, d))
            .join('، '),
      if (r.startTime != null && r.endTime != null)
        '${HalfHourTimeDropdownWidget.label(context, r.startTime!.substring(0, 5))} – ${HalfHourTimeDropdownWidget.label(context, r.endTime!.substring(0, 5))}',
      if (r.startDate != null && r.endDate != null)
        'venue.pricing.when.dates'.tr(
          context: context,
          args: [r.startDate!, r.endDate!],
        ),
      if (r.minDurationMinutes != null)
        'venue.pricing.when.min_hours'.tr(
          context: context,
          args: [VenueFormat.number(context, r.minDurationMinutes! / 60)],
        ),
      if (r.kind == 'Holiday')
        'venue.pricing.when.holidays'.tr(context: context),
    ];
    return parts.isEmpty
        ? 'venue.pricing.when.always'.tr(context: context)
        : parts.join(' · ');
  }

  /// Active now, scheduled, expired or paused (discounts).
  static (String, bool) discountStatus(BuildContext context, PriceRuleModel r) {
    final today = VenueFormat.apiDate(CairoTime.today());
    if (!r.isActive) {
      return ('venue.pricing.status.paused'.tr(context: context), false);
    }
    if (r.endDate != null && r.endDate!.compareTo(today) < 0) {
      return ('venue.pricing.status.expired'.tr(context: context), false);
    }
    if (r.startDate != null && r.startDate!.compareTo(today) > 0) {
      return (
        'venue.pricing.status.starts'.tr(
          context: context,
          args: [r.startDate!],
        ),
        true,
      );
    }
    if (r.startDate != null && r.endDate != null) {
      return ('venue.pricing.status.active_now'.tr(context: context), true);
    }
    return ('venue.pricing.status.always'.tr(context: context), true);
  }
}
