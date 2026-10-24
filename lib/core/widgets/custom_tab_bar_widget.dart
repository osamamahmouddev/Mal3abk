import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
    this.badgeCounts,
  });

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final Map<int, int>? badgeCounts;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
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
                        color: isSelected ? AppColors.brandNavy : Colors.transparent,
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
                        style: isSelected
                            ? AppTextStyles.font14Bold.copyWith(
                                color: AppColors.brandNavy,
                              )
                            : AppTextStyles.font14Medium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                      ),
                      if (count != null && count > 0) ...[
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.brandNavy
                                : AppColors.border,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            count.toString(),
                            style: AppTextStyles.font11Bold.copyWith(
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.textSecondary,
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

