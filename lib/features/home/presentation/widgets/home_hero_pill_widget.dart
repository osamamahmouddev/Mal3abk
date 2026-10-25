import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class HomeHeroPillWidget extends StatelessWidget {
  const HomeHeroPillWidget({
    required this.iconAsset,
    required this.label,
    super.key,
  });

  final String iconAsset;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.white8,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.white18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconAsset, width: 16.r, height: 16.r),
          vSpace(8),
          Text(
            label,
            style: AppTextStyles.font14SemiBold.copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
