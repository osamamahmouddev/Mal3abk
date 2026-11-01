import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';

class ExploreMapLocateButtonWidget extends StatelessWidget {
  const ExploreMapLocateButtonWidget({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.navyShadow15,
            offset: Offset(0, 2.h),
            blurRadius: 8.r,
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
            padding: EdgeInsets.all(13.r),
            child: SvgPicture.asset(
              AppAssets.icLocate,
              width: 22.r,
              height: 22.r,
            ),
          ),
        ),
      ),
    );
  }
}
