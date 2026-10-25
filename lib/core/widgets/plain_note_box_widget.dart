import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

/// Light gray rounded box with a body-colored note.
class PlainNoteBoxWidget extends StatelessWidget {
  const PlainNoteBoxWidget({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: AppTextStyles.font13Regular.copyWith(color: AppColors.textBody),
      ),
    );
  }
}
