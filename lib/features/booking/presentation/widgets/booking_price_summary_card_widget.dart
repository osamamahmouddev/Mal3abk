import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import 'booking_detail_row_widget.dart';

class BookingPriceSummaryCardWidget extends StatelessWidget {
  const BookingPriceSummaryCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final depositStyle = AppTextStyles.font14Bold.copyWith(
      color: AppColors.goldDark,
    );

    return CustomCardWidget(
      padding: EdgeInsets.fromLTRB(16.w, 11.h, 16.w, 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'booking.price_summary'.tr(context: context),
            style: AppTextStyles.font15Bold,
          ),
          hSpace(6),
          BookingDetailRowWidget(
            label: 'booking.one_hour_rate'.tr(context: context),
            value: 'booking.amount_150'.tr(context: context),
          ),
          BookingDetailRowWidget(
            label: 'booking.service_fee'.tr(context: context),
            value: 'booking.amount_0'.tr(context: context),
          ),
          hSpace(4),
          Container(height: 1, color: AppColors.border),
          BookingDetailRowWidget(
            label: 'booking.total_price'.tr(context: context),
            value: 'booking.amount_150'.tr(context: context),
            isBold: true,
          ),
          Container(
            height: 41.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: AppColors.goldLight,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Text(
                  'booking.deposit_required_now'.tr(context: context),
                  style: depositStyle,
                ),
                const Spacer(),
                Text('booking.amount_50'.tr(context: context), style: depositStyle),
              ],
            ),
          ),
          BookingDetailRowWidget(
            label: 'booking.remaining_price'.tr(context: context),
            value: 'booking.amount_100'.tr(context: context),
          ),
        ],
      ),
    );
  }
}
