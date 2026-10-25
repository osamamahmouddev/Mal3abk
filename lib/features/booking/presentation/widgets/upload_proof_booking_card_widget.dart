import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class UploadProofBookingCardWidget extends StatelessWidget {
  const UploadProofBookingCardWidget({required this.remaining, super.key});

  final String remaining;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      borderRadius: 18,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: SvgPicture.asset(AppAssets.pitchThumb48, width: 48.r, height: 48.r),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('booking.sample_pitch'.tr(context: context), style: AppTextStyles.font14Bold),
                hSpace(4),
                Text(
                  'booking.upload.sample_meta'.tr(context: context),
                  style: AppTextStyles.font12Regular,
                ),
              ],
            ),
          ),
          AppBadgeWidget(
            text: remaining,
            type: AppBadgeType.warning,
            borderRadius: 13,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
          ),
        ],
      ),
    );
  }
}
