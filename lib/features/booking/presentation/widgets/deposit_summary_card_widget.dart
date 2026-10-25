import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import 'booking_detail_row_widget.dart';

class DepositSummaryCardWidget extends StatelessWidget {
  const DepositSummaryCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'booking.deposit.booking_no'.tr(context: context),
                style: AppTextStyles.font13Regular,
              ),
              const Spacer(),
              Text(
                'booking.deposit.sample_booking_no'.tr(context: context),
                style: AppTextStyles.font13SemiBold,
              ),
            ],
          ),
          hSpace(10),
          Text(
            'booking.sample_pitch'.tr(context: context),
            style: AppTextStyles.font16Bold,
          ),
          hSpace(12),
          Text(
            'booking.deposit.sample_slot'.tr(context: context),
            style: AppTextStyles.font13Regular,
          ),
          hSpace(14),
          Container(height: 1, color: AppColors.border),
          hSpace(2),
          BookingDetailRowWidget(
            label: 'booking.total_price'.tr(context: context),
            value: 'booking.amount_150'.tr(context: context),
          ),
          BookingDetailRowWidget(
            label: 'booking.remaining_price'.tr(context: context),
            value: 'booking.amount_100'.tr(context: context),
          ),
          hSpace(8),
          Container(
            height: 54.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: AppColors.goldLight,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Text(
                  'booking.deposit_required_now'.tr(context: context),
                  style: AppTextStyles.font15Bold.copyWith(color: AppColors.goldDark),
                ),
                const Spacer(),
                Text(
                  'booking.amount_50'.tr(context: context),
                  style: AppTextStyles.font20Bold.copyWith(color: AppColors.goldDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
