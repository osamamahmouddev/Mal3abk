import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class ExploreViewToggleSegmentWidget extends StatelessWidget {
  const ExploreViewToggleSegmentWidget({
    required this.labelKey,
    required this.isActive,
    required this.route,
    required this.large,
    super.key,
  });

  final String labelKey;
  final bool isActive;
  final String route;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final height = large ? 34.0 : 30.0;
    final style = large
        ? (isActive ? AppTextStyles.font13Bold : AppTextStyles.font13SemiBold)
        : (isActive ? AppTextStyles.font12Bold : AppTextStyles.font12SemiBold);

    return GestureDetector(
      onTap: isActive
          ? null
          : () => Navigator.of(context).pushReplacementNamed(route),
      child: Container(
        height: height.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.brandNavy : AppColors.transparent,
          borderRadius: BorderRadius.circular((height / 2).r),
        ),
        child: Text(
          labelKey.tr(context: context),
          style: style.copyWith(
            color: isActive ? AppColors.white : AppColors.offlineBanner,
          ),
        ),
      ),
    );
  }
}
