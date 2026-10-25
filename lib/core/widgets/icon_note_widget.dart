import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

/// Light gray note box with a leading 18px icon.
class IconNoteWidget extends StatelessWidget {
  const IconNoteWidget({
    required this.iconAsset,
    required this.text,
    super.key,
  });

  final String iconAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(14.w, 12.h, 14.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: SvgPicture.asset(iconAsset, width: 18.r, height: 18.r),
          ),
          vSpace(9),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.textBody,
                height: 20 / 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
