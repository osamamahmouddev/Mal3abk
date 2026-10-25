import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class VenuePitchOptionCardWidget extends StatelessWidget {
  const VenuePitchOptionCardWidget({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final String price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      margin: EdgeInsets.only(bottom: 10.h),
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.font15Bold),
                hSpace(2),
                Text(subtitle, style: AppTextStyles.font12Regular),
                hSpace(4),
                Text(price, style: AppTextStyles.font14Bold.copyWith(color: AppColors.brandNavy)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 16.sp, color: AppColors.brandNavy),
        ],
      ),
    );
  }
}
