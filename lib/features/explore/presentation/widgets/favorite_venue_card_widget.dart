import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import 'favorite_remove_button_widget.dart';
import 'favorite_today_slots_widget.dart';

class FavoriteVenueCardWidget extends StatelessWidget {
  const FavoriteVenueCardWidget({
    required this.name,
    required this.rating,
    required this.meta,
    required this.priceFrom,
    required this.todaySlots,
    required this.onView,
    required this.onRemove,
    super.key,
  });

  final String name;
  final String rating;
  final String meta;
  final String priceFrom;
  final List<String> todaySlots;
  final VoidCallback onView;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
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
              SvgPicture.asset(
                AppAssets.pitchBanner,
                height: 120.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              PositionedDirectional(
                end: 10.w,
                top: 10.h,
                child: FavoriteRemoveButtonWidget(onTap: onRemove),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 7.h, 14.w, 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(name, style: AppTextStyles.font16Bold)),
                    Text(
                      '★ $rating',
                      style: AppTextStyles.font13Bold.copyWith(
                        color: AppColors.goldDark,
                      ),
                    ),
                  ],
                ),
                hSpace(8),
                Text(meta, style: AppTextStyles.font12Regular),
                hSpace(8),
                FavoriteTodaySlotsWidget(slots: todaySlots),
                hSpace(8),
                CustomButton(
                  text: 'explore.view_venue_from'
                      .tr(context: context, args: [priceFrom]),
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
