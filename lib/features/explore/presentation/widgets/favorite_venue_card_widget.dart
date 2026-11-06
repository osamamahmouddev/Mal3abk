import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/models/explore_venue_card_model.dart';
import 'favorite_remove_button_widget.dart';

class FavoriteVenueCardWidget extends StatelessWidget {
  const FavoriteVenueCardWidget({
    required this.venue,
    required this.onView,
    required this.onRemove,
    super.key,
  });

  final ExploreVenueCardModel venue;
  final VoidCallback onView;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final banner = SvgPicture.asset(
      AppAssets.pitchBanner,
      height: 120.h,
      width: double.infinity,
      fit: BoxFit.cover,
    );
    final next = venue.nextAvailableStartUtc;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderCard),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Hero(
                tag: 'venue-${venue.venueId}',
                child: venue.coverPhotoUrl == null
                    ? banner
                    : CachedNetworkImage(
                        imageUrl: venue.coverPhotoUrl!,
                        height: 120.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorWidget: (_, _, _) => banner,
                      ),
              ),
              PositionedDirectional(
                end: 10.w,
                top: 10.h,
                child: FavoriteRemoveButtonWidget(onTap: onRemove),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(venue.name, style: AppTextStyles.font16Bold),
                hSpace(6),
                Text(
                  [venue.area, venue.city].join(' · '),
                  style: AppTextStyles.font12Regular,
                ),
                if (next != null) ...[
                  hSpace(6),
                  Text(
                    'explore.next_available'.tr(
                      context: context,
                      args: [CairoTime.dayAndTime(DateTime.parse(next), lang)],
                    ),
                    style: AppTextStyles.font12Medium.copyWith(
                      color: AppColors.successGreen,
                    ),
                  ),
                ],
                hSpace(10),
                CustomButton(
                  text: 'explore.view_venue'.tr(context: context),
                  type: CustomButtonType.outline,
                  height: 46.h,
                  borderRadius: 10,
                  borderColor: AppColors.brandNavy,
                  textStyle: AppTextStyles.font14Bold.copyWith(
                    color: AppColors.brandNavy,
                  ),
                  onTap: onView,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
