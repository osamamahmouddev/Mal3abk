import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class LocationDistanceBadgeWidget extends StatelessWidget {
  const LocationDistanceBadgeWidget({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.r,
      padding: EdgeInsets.symmetric(horizontal: 7.r),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(label, style: AppTextStyles.font11Bold),
    );
  }
}
