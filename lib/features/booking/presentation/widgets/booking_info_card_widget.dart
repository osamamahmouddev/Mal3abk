import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import 'booking_detail_row_widget.dart';

class BookingInfoCardWidget extends StatelessWidget {
  const BookingInfoCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      padding: EdgeInsets.fromLTRB(16.w, 11.h, 16.w, 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'booking.sample_pitch'.tr(context: context),
            style: AppTextStyles.font15Bold,
          ),
          hSpace(6),
          BookingDetailRowWidget(
            label: 'booking.time_label'.tr(context: context),
            value: 'booking.sample_time'.tr(context: context),
            valueStyle: AppTextStyles.font14SemiBold,
          ),
          BookingDetailRowWidget(
            label: 'booking.pitch_label'.tr(context: context),
            value: 'booking.sample_pitch_specs'.tr(context: context),
          ),
          BookingDetailRowWidget(
            label: 'booking.manager_label'.tr(context: context),
            value: 'booking.sample_manager'.tr(context: context),
          ),
        ],
      ),
    );
  }
}
