import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/widgets/app_on_dark_back_button_widget.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class TeamProfileHeroWidget extends StatelessWidget {
  const TeamProfileHeroWidget({
    required this.initials,
    required this.avatarColor,
    required this.name,
    required this.meta,
    required this.badgeText,
    super.key,
    this.avatarTextColor = AppColors.white,
    this.rankedBadge = true,
  });

  final String initials;
  final Color avatarColor;
  final Color avatarTextColor;
  final String name;
  final String meta;
  final String badgeText;

  /// Gold rank pill; otherwise a translucent "not ranked yet" pill.
  final bool rankedBadge;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.brandNavy,
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(AppAssets.teamHeroPattern, fit: BoxFit.fill),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 18.h),
              child: Column(
                children: [
                  const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AppOnDarkBackButtonWidget(),
                  ),
                  hSpace(12),
                  Container(
                    width: 86.r,
                    height: 86.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: avatarColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white25, width: 3),
                    ),
                    child: Text(
                      initials,
                      style: AppTextStyles.font28Bold.copyWith(color: avatarTextColor),
                    ),
                  ),
                  hSpace(4),
                  Text(name, style: AppTextStyles.font22Bold.copyWith(color: AppColors.white)),
                  hSpace(10),
                  Text(
                    meta,
                    style: AppTextStyles.font13Regular.copyWith(color: AppColors.onNavyMuted),
                    textAlign: TextAlign.center,
                  ),
                  hSpace(12),
                  Container(
                    height: 27.h,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: rankedBadge ? AppColors.accentGold : AppColors.white14,
                      borderRadius: BorderRadius.circular(13.5.r),
                    ),
                    child: Center(
                      widthFactor: 1,
                      child: Text(
                        badgeText,
                        style: AppTextStyles.font12Bold.copyWith(
                          color: rankedBadge ? AppColors.brandNavy : AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
