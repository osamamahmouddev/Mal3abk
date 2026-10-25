import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class TeamPlayerRowWidget extends StatelessWidget {
  const TeamPlayerRowWidget({
    required this.initials,
    required this.name,
    required this.position,
    super.key,
    this.showDivider = true,
  });

  final String initials;
  final String name;
  final String position;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: AppColors.lightSurface))
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 34.r,
            height: 34.r,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.lightSurface,
              shape: BoxShape.circle,
            ),
            child: Text(
              initials,
              style: AppTextStyles.font12Bold.copyWith(color: AppColors.brandNavy),
            ),
          ),
          vSpace(10),
          Expanded(child: Text(name, style: AppTextStyles.font14SemiBold)),
          Text(position, style: AppTextStyles.font12Regular),
        ],
      ),
    );
  }
}
