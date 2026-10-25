import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class CancelRefundBoxWidget extends StatelessWidget {
  const CancelRefundBoxWidget({required this.isAfterDeadline, super.key});

  final bool isAfterDeadline;

  @override
  Widget build(BuildContext context) {
    final fg = isAfterDeadline ? AppColors.redDark : AppColors.successText;

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 14.h),
      decoration: BoxDecoration(
        color: isAfterDeadline ? AppColors.redLight : AppColors.successLight,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            (isAfterDeadline ? 'booking.cancel.late_header' : 'booking.cancel.free_header')
                .tr(context: context),
            style: AppTextStyles.font13SemiBold.copyWith(color: fg),
          ),
          hSpace(6),
          Row(
            children: [
              Text(
                'booking.cancel.paid_deposit'.tr(context: context),
                style: AppTextStyles.font14Regular.copyWith(color: fg),
              ),
              const Spacer(),
              Text(
                'booking.amount_70'.tr(context: context),
                style: AppTextStyles.font14Regular.copyWith(color: fg),
              ),
            ],
          ),
          hSpace(8),
          Row(
            children: [
              Text(
                'booking.cancel.refund'.tr(context: context),
                style: AppTextStyles.font16Bold.copyWith(color: fg),
              ),
              const Spacer(),
              Text(
                (isAfterDeadline ? 'booking.amount_0' : 'booking.amount_70')
                    .tr(context: context),
                style: AppTextStyles.font24Bold.copyWith(color: fg),
              ),
            ],
          ),
          hSpace(6),
          Text(
            (isAfterDeadline ? 'booking.cancel.late_note' : 'booking.cancel.free_note')
                .tr(context: context),
            style: AppTextStyles.font12Regular.copyWith(color: fg, height: 19 / 12),
          ),
        ],
      ),
    );
  }
}
