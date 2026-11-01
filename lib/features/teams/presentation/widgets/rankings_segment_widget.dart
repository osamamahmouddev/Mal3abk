import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

/// Two-option segmented control on a navy background.
class RankingsSegmentWidget extends StatelessWidget {
  const RankingsSegmentWidget({
    required this.labels,
    required this.selectedIndex,
    required this.onSelect,
    super.key,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        color: AppColors.white10,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          for (var i = 0; i < labels.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => onSelect(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedIndex == i
                        ? AppColors.white
                        : AppColors.transparent,
                    borderRadius: BorderRadius.circular(9.r),
                  ),
                  child: Text(
                    labels[i],
                    style: AppTextStyles.font14SemiBold.copyWith(
                      color: selectedIndex == i
                          ? AppColors.brandNavy
                          : AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
