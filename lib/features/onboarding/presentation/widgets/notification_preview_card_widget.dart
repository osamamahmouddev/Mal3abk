import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class NotificationPreviewCardWidget extends StatelessWidget {
  const NotificationPreviewCardWidget({
    required this.glyph,
    required this.glyphColor,
    required this.glyphBackground,
    required this.title,
    required this.time,
    super.key,
    this.width = 282,
  });

  final String glyph;
  final Color glyphColor;
  final Color glyphBackground;
  final String title;
  final String time;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.borderCard),
        boxShadow: [
          BoxShadow(
            color: AppColors.navyShadow18,
            offset: Offset(0, 10.h),
            blurRadius: 24.r,
            spreadRadius: -12.r,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 37.r,
            height: 37.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: glyphBackground,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              glyph,
              style: AppTextStyles.font16Bold.copyWith(color: glyphColor),
            ),
          ),
          vSpace(9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.font13Bold),
                hSpace(4),
                Text(time, style: AppTextStyles.font11Regular),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
