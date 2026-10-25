import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

/// Outlined white box with a centered muted message (empty sections).
class EmptyNoteBoxWidget extends StatelessWidget {
  const EmptyNoteBoxWidget({
    required this.text,
    super.key,
    this.minHeight = 49,
  });

  final String text;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: minHeight.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderInput),
      ),
      child: Text(
        text,
        style: AppTextStyles.font13Regular,
        textAlign: TextAlign.center,
      ),
    );
  }
}
