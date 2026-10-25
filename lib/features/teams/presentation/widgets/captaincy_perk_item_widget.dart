import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class CaptaincyPerkItemWidget extends StatelessWidget {
  const CaptaincyPerkItemWidget({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12.r,
            backgroundColor: AppColors.successLight,
            child: Icon(
              Icons.check_rounded,
              color: AppColors.successGreen,
              size: 14.sp,
            ),
          ),
          vSpace(10),
          Expanded(
            child: Text(text, style: AppTextStyles.font14Regular),
          ),
        ],
      ),
    );
  }
}
