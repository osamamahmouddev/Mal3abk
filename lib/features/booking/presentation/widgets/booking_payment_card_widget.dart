import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import 'booking_detail_row_widget.dart';

class BookingPaymentCardWidget extends StatelessWidget {
  const BookingPaymentCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      padding: EdgeInsets.fromLTRB(16.w, 11.h, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('booking.details.payment'.tr(context: context), style: AppTextStyles.font15Bold),
          hSpace(6),
          BookingDetailRowWidget(
            label: 'booking.details.total_at_booking'.tr(context: context),
            value: 'booking.amount_200'.tr(context: context),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              children: [
                Text(
                  'booking.details.deposit'.tr(context: context),
                  style: AppTextStyles.font14Regular,
                ),
                const Spacer(),
                Text(
                  'booking.amount_70'.tr(context: context),
                  style: AppTextStyles.font14Regular.copyWith(color: AppColors.textPrimary),
                ),
                vSpace(6),
                AppBadgeWidget(
                  text: 'booking.details.deposit_approved'.tr(context: context),
                  type: AppBadgeType.success,
                  borderRadius: 10.5,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
                  textStyle: AppTextStyles.font11Bold.copyWith(color: AppColors.successGreen),
                ),
              ],
            ),
          ),
          hSpace(4),
          Container(height: 1, color: AppColors.border),
          BookingDetailRowWidget(
            label: 'booking.details.pay_at_venue'.tr(context: context),
            value: 'booking.amount_130'.tr(context: context),
            isBold: true,
          ),
          hSpace(14),
          GestureDetector(
            onTap: () {},
            child: Text(
              'booking.details.view_receipt'.tr(context: context),
              style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.brandNavy),
            ),
          ),
        ],
      ),
    );
  }
}
