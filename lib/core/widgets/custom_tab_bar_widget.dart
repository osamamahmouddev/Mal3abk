import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../extensions/app_display_extensions.dart';
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
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedIndex == index;
          final count = badgeCounts?[index];

          return Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onTabSelected(index),
                child: Container(
                  height: 48.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isSelected ? indicatorColor : Colors.transparent,
                        width: 3.h,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tabs[index],
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
                      ),
                      if (count != null && count > 0) ...[
                        vSpace(6),
                        Container(
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
    );
  }
}
