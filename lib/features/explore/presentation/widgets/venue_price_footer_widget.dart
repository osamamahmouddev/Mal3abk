import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/price_action_footer_widget.dart';

class VenuePriceFooterWidget extends StatelessWidget {
  const VenuePriceFooterWidget({
    required this.price,
    required this.onTap,
    super.key,
  });

  /// Empty when the venue hasn't priced any pitch yet.
  final String price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PriceActionFooterWidget(
      caption: 'explore.venue.starts_from'.tr(context: context),
      price: price.isEmpty ? '—' : price,
      priceSuffix: price.isEmpty ? '' : 'common.per_hour'.tr(context: context),
      ctaText: 'explore.venue.book'.tr(context: context),
      onTap: onTap,
    );
  }
}
