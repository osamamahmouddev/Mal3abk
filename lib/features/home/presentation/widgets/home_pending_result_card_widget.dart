import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class HomePendingResultCardWidget extends StatelessWidget {
  const HomePendingResultCardWidget({
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      borderRadius: 18,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.font14Bold),
                hSpace(2),
                Text(subtitle, style: AppTextStyles.font12Regular),
              ],
            ),
          ),
          Text(
            'home.review'.tr(context: context),
            style: AppTextStyles.font12Bold.copyWith(
              color: AppColors.brandNavy,
            ),
          ),
        ],
      ),
    );
  }
}
