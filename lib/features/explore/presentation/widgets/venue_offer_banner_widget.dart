import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../data/models/venue_offer_model.dart';
import 'venue_offer_text.dart';

/// The venue's running offer on its profile: how much it takes off, until
/// when, and the starting price before and after.
class VenueOfferBannerWidget extends StatelessWidget {
  const VenueOfferBannerWidget({
    required this.offer,
    this.fromHourlyPrice,
    super.key,
  });

  final VenueOfferModel offer;
  final double? fromHourlyPrice;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    String egp(double v) => 'common.price_egp'.tr(
      context: context,
      args: [v.round().toLocalizedDigits(lang)],
    );
    final before = fromHourlyPrice;
    final after = offer.fromHourlyPriceAfter;
    final terms = offer.terms(context);

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.goldLight,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.goldBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: AppColors.accentGold,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.local_offer_rounded,
              color: AppColors.white,
              size: 20.r,
            ),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer.headline(context),
                  style: AppTextStyles.font15Bold.copyWith(
                    color: AppColors.goldText,
                  ),
                ),
                if (offer.name.isNotEmpty || terms.isNotEmpty) ...[
                  hSpace(2),
                  Text(
                    [offer.name, terms].where((s) => s.isNotEmpty).join(' · '),
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.goldDark,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (before != null && after != null && after < before) ...[
            vSpace(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  egp(after),
                  style: AppTextStyles.font16Bold.copyWith(
                    color: AppColors.goldText,
                  ),
                ),
                Text(
                  egp(before),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
