import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/price_action_footer_widget.dart';

class VenuePriceFooterWidget extends StatelessWidget {
  const VenuePriceFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PriceActionFooterWidget(
      caption: 'explore.venue.starts_from'.tr(context: context),
      price: 'explore.sample1_price'.tr(context: context),
      priceSuffix: 'common.per_hour'.tr(context: context),
      ctaText: 'explore.venue.book'.tr(context: context),
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.pitchAndTime),
    );
  }
}
