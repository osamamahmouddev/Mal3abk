import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class BookingReceiptCardWidget extends StatelessWidget {
  const BookingReceiptCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      padding: EdgeInsets.fromLTRB(16.w, 11.h, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('booking.receipt.title'.tr(context: context), style: AppTextStyles.font15Bold),
          hSpace(14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 64.w,
                height: 84.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              vSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    hSpace(4),
                    Text(
                      'booking.receipt.sample_file'.tr(context: context),
                      style: AppTextStyles.font13SemiBold,
                    ),
                    hSpace(4),
                    Text(
                      'booking.receipt.sample_meta'.tr(context: context),
                      style: AppTextStyles.font12Regular,
                    ),
                    hSpace(8),
                    AppBadgeWidget(
                      text: 'booking.receipt.rejected'.tr(context: context),
                      type: AppBadgeType.error,
                      borderRadius: 10.5,
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
                      textStyle: AppTextStyles.font11Bold.copyWith(color: AppColors.redText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
