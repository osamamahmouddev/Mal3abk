import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';

class BookingDetailsHeroWidget extends StatelessWidget {
  const BookingDetailsHeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.brandNavy,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AppAssets.bookingHeroPattern,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    AppBadgeWidget(
                      text: 'booking.details.confirmed'.tr(context: context),
                      type: AppBadgeType.success,
                      borderRadius: 13,
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.w,
                        vertical: 3.h,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'booking.details.in_days'.tr(context: context),
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.onNavyMuted,
                      ),
                    ),
                  ],
                ),
                hSpace(6),
                Text(
                  'booking.details.sample_pitch'.tr(context: context),
                  style: AppTextStyles.font20Bold.copyWith(
                    color: AppColors.white,
                  ),
                ),
                hSpace(4),
                Text(
                  'booking.details.sample_slot'.tr(context: context),
                  style: AppTextStyles.font14Regular.copyWith(
                    color: AppColors.onNavySoft,
                  ),
                ),
                hSpace(14),
                Container(
                  height: 51.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: AppColors.white8,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'booking.details.show_venue'.tr(context: context),
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.onNavyMuted,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'booking.details.sample_code'.tr(context: context),
                        textDirection: TextDirection.ltr,
                        style: AppTextStyles.font18Bold.copyWith(
                          color: AppColors.accentGold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
