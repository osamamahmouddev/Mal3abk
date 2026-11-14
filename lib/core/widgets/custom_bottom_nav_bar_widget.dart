import 'dart:ui';

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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26.r),
          boxShadow: AppShadows.navBar,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26.r),
          child: BackdropFilter(
            // Frosted: content scrolling under the bar stays faintly visible.
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(26.r),
                border: Border.all(color: AppColors.borderCard),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = constraints.maxWidth / items.length;
                  return Stack(
                    children: [
                      // One pill that glides to the selected tab instead of each tab
                      // fading its own background.
                      AnimatedPositionedDirectional(
                        duration: AppAnimations.duration(
                          context,
                          AppAnimations.slow,
                        ),
                        curve: AppAnimations.emphasized,
                        start: currentIndex * itemWidth,
                        top: 0,
                        bottom: 0,
                        width: itemWidth,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.lerp(
                                  AppColors.brandNavy,
                                  AppColors.white,
                                  0.12,
                                )!,
                                AppColors.brandNavy,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.brandNavy.withValues(
                                  alpha: 0.35,
                                ),
                                blurRadius: 12.r,
                                offset: Offset(0, 4.h),
                              ),
                            ],
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
          ),
        ),
      ),
    );
  }
}
