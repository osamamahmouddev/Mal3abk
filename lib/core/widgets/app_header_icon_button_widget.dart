import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/app_colors.dart';

/// 44px white rounded header button (back, close, help...).
class AppHeaderIconButtonWidget extends StatelessWidget {
  const AppHeaderIconButtonWidget({
    required this.iconAsset,
    required this.onTap,
    super.key,
    this.iconSize = 22,
    this.mirrorInLtr = false,
  });

  final String iconAsset;
  final VoidCallback onTap;
  final double iconSize;
  final bool mirrorInLtr;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(14.r);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: AppColors.navyShadow,
            offset: Offset(0, 1.h),
            blurRadius: 3.r,
          ),
        ],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: EdgeInsets.all(((44 - iconSize) / 2).r),
            child: Transform.flip(
              flipX: mirrorInLtr &&
                  Directionality.of(context) == TextDirection.ltr,
              child: SvgPicture.asset(
                iconAsset,
                width: iconSize.r,
                height: iconSize.r,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
