import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import 'booking_detail_row_widget.dart';

class ProofRejectedSummaryCardWidget extends StatelessWidget {
  const ProofRejectedSummaryCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      padding: EdgeInsets.fromLTRB(16.w, 11.h, 16.w, 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'booking.rejected.sample_pitch'.tr(context: context),
                style: AppTextStyles.font16Bold,
              ),
              const Spacer(),
              Text(
                'booking.rejected.sample_no'.tr(context: context),
                textDirection: TextDirection.ltr,
                style: AppTextStyles.font12Regular,
              ),
            ],
          ),
          hSpace(10),
          Text(
            'booking.rejected.sample_slot'.tr(context: context),
            style: AppTextStyles.font13Regular,
          ),
          hSpace(14),
          Container(height: 1, color: AppColors.border),
          BookingDetailRowWidget(
            label: 'booking.total_price'.tr(context: context),
            value: 'booking.amount_180'.tr(context: context),
          ),
          BookingDetailRowWidget(
            label: 'booking.deposit_required'.tr(context: context),
            value: 'booking.amount_60'.tr(context: context),
            valueStyle: AppTextStyles.font14Bold,
          ),
          BookingDetailRowWidget(
            label: 'booking.deposit_verified'.tr(context: context),
            value: 'booking.amount_0'.tr(context: context),
          ),
        ],
      ),
    );
  }
}
