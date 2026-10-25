import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';

class TeamMemberRowWidget extends StatelessWidget {
  const TeamMemberRowWidget({
    required this.initials,
    required this.name,
    required this.details,
    required this.isCaptain,
    super.key,
    this.onOptions,
  });

  final String initials;
  final String name;
  final String details;
  final bool isCaptain;
  final VoidCallback? onOptions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.lightSurface)),
      ),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.lightSurface,
              shape: BoxShape.circle,
            ),
            child: Text(initials, style: AppTextStyles.font14Bold.copyWith(color: AppColors.brandNavy)),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.font14Bold),
                hSpace(4),
                Text(details, style: AppTextStyles.font12Regular),
              ],
            ),
          ),
          if (isCaptain)
            AppBadgeWidget(
              text: 'teams.manage.captain'.tr(context: context),
              type: AppBadgeType.warning,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            )
          else
            InkWell(
              onTap: onOptions,
              borderRadius: BorderRadius.circular(10.r),
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: SvgPicture.asset(AppAssets.icMoreVertical, width: 20.r, height: 20.r),
              ),
            ),
        ],
      ),
    );
  }
}
