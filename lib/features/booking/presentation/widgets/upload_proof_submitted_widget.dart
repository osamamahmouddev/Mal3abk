import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/animated_check_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class UploadProofSubmittedWidget extends StatelessWidget {
  const UploadProofSubmittedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 88.r,
              height: 88.r,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.successLight,
                shape: BoxShape.circle,
              ),
              child: AnimatedCheckWidget(
                color: AppColors.successGreen,
                size: 44.r,
              ),
            ),
          ),
          hSpace(24),
          Text(
            'booking.upload.success_title'.tr(context: context),
            style: AppTextStyles.font22Bold,
            textAlign: TextAlign.center,
          ),
          hSpace(8),
          Text(
            'booking.upload.success_body'.tr(context: context),
            style: AppTextStyles.font14Regular,
            textAlign: TextAlign.center,
          ),
          hSpace(36),
          CustomButton(
            text: 'booking.my_bookings_title'.tr(context: context),
            height: 52.h,
            borderRadius: 16,
            onTap: () => Navigator.of(
              context,
            ).pushReplacementNamed(AppRoutes.myBookings),
          ),
          hSpace(12),
          CustomButton(
            text: 'booking.back_to_home'.tr(context: context),
            type: CustomButtonType.ghost,
            height: 44.h,
            onTap: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
          ),
        ],
      ),
    );
  }
}
