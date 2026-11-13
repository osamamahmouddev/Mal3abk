import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../animations/app_animations.dart';
import '../styles/app_colors.dart';
import '../styles/app_shadows.dart';
import 'custom_bottom_nav_bar_item_widget.dart';

class CustomBottomNavBarItem {
  const CustomBottomNavBarItem({required this.title, required this.iconAsset});

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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / items.length;
            return Stack(
              children: [
                // One pill that glides to the selected tab instead of each tab
                // fading its own background.
                AnimatedPositionedDirectional(
                  duration: AppAnimations.duration(context, AppAnimations.slow),
                  curve: AppAnimations.emphasized,
                  start: currentIndex * itemWidth,
                  top: 0,
                  bottom: 0,
                  width: itemWidth,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.brandNavy,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
                Row(
                  children: [
                    for (var index = 0; index < items.length; index++)
                      Expanded(
                        child: CustomBottomNavBarItemWidget(
                          item: items[index],
                          isSelected: currentIndex == index,
                          onTap: () => onTap(index),
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
