import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class OnboardingFeatureItemWidget extends StatelessWidget {
  const OnboardingFeatureItemWidget({
    required this.number,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44.w,
          height: 44.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            number,
            style: AppTextStyles.font16Bold.copyWith(
              color: AppColors.brandNavy,
            ),
          ),
        ),
        vSpace(14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.font15Bold,
              ),
              hSpace(2),
              Text(
                subtitle,
                style: AppTextStyles.font13Regular,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
