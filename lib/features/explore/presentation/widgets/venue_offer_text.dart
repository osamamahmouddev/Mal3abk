import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../data/models/venue_offer_model.dart';

/// How a venue's offer reads to a player.
extension VenueOfferText on VenueOfferModel {
  /// "20% off" or "50 EGP off a booking".
  String headline(BuildContext context) {
    final lang = context.locale.languageCode;
    final amount = value.round().toLocalizedDigits(lang);
    return isPercentage
        ? 'explore.offer.percent'.tr(context: context, args: [amount])
        : 'explore.offer.amount'.tr(
            context: context,
            args: [
              'common.price_egp'.tr(context: context, args: [amount]),
            ],
          );
  }

  /// "until 27 November", "on selected times", both, or empty.
  String terms(BuildContext context) {
    final lang = context.locale.languageCode;
    final end = endsOnDate;
    return [
      if (end != null)
        'explore.offer.until'.tr(
          context: context,
          args: [CairoTime.shortDate(CairoTime.toUtc(end, 12), lang)],
        ),
      if (hasConditions) 'explore.offer.selected_times'.tr(context: context),
    ].join(' · ');
  }

  /// Headline and terms on one line, for a card badge.
  String label(BuildContext context) => [
    headline(context),
    terms(context),
  ].where((s) => s.isNotEmpty).join(' · ');
}
