import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../extensions/app_display_extensions.dart';
import '../animations/app_animations.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
    this.badgeCounts,
    this.indicatorColor = AppColors.brandRed,
    this.showTopBorder = true,
    this.large = false,
  });

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final Map<int, int>? badgeCounts;
  final Color indicatorColor;
  final bool showTopBorder;

  /// 15px labels instead of 14px.
  final bool large;

  @override
  Widget build(BuildContext context) {
    final duration = AppAnimations.duration(context, AppAnimations.base);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: showTopBorder
              ? const BorderSide(color: AppColors.lightSurface)
              : BorderSide.none,
          bottom: BorderSide(
            color: showTopBorder ? AppColors.lightSurface : AppColors.border,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth / tabs.length;
          final indicatorWidth = tabWidth * 0.56;
          return SizedBox(
            height: 48.h,
            child: Stack(
              children: [
                Row(
                  children: List.generate(tabs.length, (index) {
                    final isSelected = selectedIndex == index;
                    final count = badgeCounts?[index];
                    return Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            if (isSelected) return;
                            HapticFeedback.selectionClick();
                            onTabSelected(index);
                          },
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedDefaultTextStyle(
                                  duration: duration,
                                  curve: AppAnimations.standard,
                                  style:
                                      (isSelected
                                              ? AppTextStyles.font14Bold
                                              : AppTextStyles.font14Medium)
                                          .copyWith(
                                            fontSize: (large ? 15 : 14).sp,
                                            color: isSelected
                                                ? AppColors.brandNavy
                                                : AppColors.textSecondary,
                                          ),
                                  child: AnimatedScale(
                                    duration: duration,
                                    curve: AppAnimations.standard,
                                    scale: isSelected ? 1 : 0.96,
                                    child: Text(tabs[index]),
                                  ),
                                ),
                                if (count != null && count > 0) ...[
                                  vSpace(6),
                                  AnimatedContainer(
                                    duration: duration,
                                    width: 18.r,
                                    height: 18.r,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.brandNavy
                                          : AppColors.border,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      count.toLocalizedDigits(
                                        context.locale.languageCode,
                                      ),
                                      style: AppTextStyles.font11Bold.copyWith(
                                        color: isSelected
                                            ? AppColors.white
                                            : AppColors.offlineBanner,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                // One indicator that slides to the selected tab.
                AnimatedPositionedDirectional(
                  duration: AppAnimations.duration(context, AppAnimations.slow),
                  curve: AppAnimations.emphasized,
                  start:
                      selectedIndex * tabWidth +
                      (tabWidth - indicatorWidth) / 2,
                  bottom: 0,
                  width: indicatorWidth,
                  height: 3.h,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: indicatorColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(3.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
