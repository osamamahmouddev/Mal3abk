import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_shadows.dart';
import '../styles/app_text_styles.dart';

class CustomBottomNavBarItem {
  const CustomBottomNavBarItem({
    required this.title,
    required this.iconAsset,
  });

  final String title;
  final String iconAsset;
}

class CustomBottomNavBarWidget extends StatelessWidget {
  const CustomBottomNavBarWidget({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<CustomBottomNavBarItem> items;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: EdgeInsets.only(bottom: 12.h),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        padding: EdgeInsets.all(6.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(26.r),
          border: Border.all(color: AppColors.borderCard),
          boxShadow: AppShadows.navBar,
        ),
        child: Row(
          children: List.generate(items.length, (index) {
            final isSelected = currentIndex == index;
            final item = items[index];
            final color = isSelected ? AppColors.white : AppColors.textSecondary;

            return Expanded(
              child: Material(
                color: isSelected ? AppColors.brandNavy : AppColors.transparent,
                borderRadius: BorderRadius.circular(20.r),
                child: InkWell(
                  onTap: () => onTap(index),
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    height: 52.h,
                    padding: EdgeInsets.only(top: 5.h),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          item.iconAsset,
                          width: 22.r,
                          height: 22.r,
                          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                        ),
                        hSpace(1),
                        Text(
                          item.title,
                          style: (isSelected
                                  ? AppTextStyles.font11Bold
                                  : AppTextStyles.font11Regular)
                              .copyWith(color: color),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
