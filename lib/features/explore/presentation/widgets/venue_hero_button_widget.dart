import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/styles/app_colors.dart';

class VenueHeroButtonWidget extends StatelessWidget {
  const VenueHeroButtonWidget({
    required this.iconAsset,
    required this.onTap,
    super.key,
    this.mirrorInLtr = false,
  });

  final String iconAsset;
  final VoidCallback onTap;
  final bool mirrorInLtr;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.navyShadow15,
            offset: Offset(0, 1.h),
            blurRadius: 4.r,
          ),
        ],
      ),
      child: Material(
        color: AppColors.white,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Transform.flip(
              flipX:
                  mirrorInLtr &&
                  Directionality.of(context) == TextDirection.ltr,
              child: SvgPicture.asset(iconAsset, width: 20.r, height: 20.r),
            ),
          ),
        ),
      ),
    );
  }
}
