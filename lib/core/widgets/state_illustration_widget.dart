import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';

/// The icon of an empty or error state, set in soft layered circles with two
/// brand accent dots so a blank screen still feels designed.
class StateIllustrationWidget extends StatelessWidget {
  const StateIllustrationWidget({required this.icon, super.key});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final size = 128.r;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: AppColors.lightSurface,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 88.r,
            height: 88.r,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.navyShadow12,
                  blurRadius: 24.r,
                  offset: Offset(0, 8.h),
                ),
              ],
            ),
            child: Center(
              child: SizedBox.square(
                dimension: 38.r,
                child: FittedBox(
                  child: IconTheme(
                    data: const IconThemeData(color: AppColors.brandNavy),
                    child: icon,
                  ),
                ),
              ),
            ),
          ),
          PositionedDirectional(
            top: 14.r,
            end: 12.r,
            child: Container(
              width: 12.r,
              height: 12.r,
              decoration: const BoxDecoration(
                color: AppColors.accentGold,
                shape: BoxShape.circle,
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 20.r,
            start: 8.r,
            child: Container(
              width: 8.r,
              height: 8.r,
              decoration: const BoxDecoration(
                color: AppColors.brandRed,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
