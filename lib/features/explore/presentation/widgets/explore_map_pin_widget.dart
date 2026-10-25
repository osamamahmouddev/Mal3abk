import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class ExploreMapPinWidget extends StatelessWidget {
  const ExploreMapPinWidget({
    required this.name,
    required this.price,
    required this.isSelected,
    super.key,
  });

  final String name;
  final String price;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.brandNavy : AppColors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0x20000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                name,
                style: isSelected
                    ? AppTextStyles.font11Bold.copyWith(color: AppColors.white)
                    : AppTextStyles.font11Bold,
              ),
              hSpace(2),
              Text(
                price,
                style: isSelected
                    ? AppTextStyles.font11Regular.copyWith(
                        color: AppColors.white.withValues(alpha: 0.8),
                      )
                    : AppTextStyles.font11Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.arrow_drop_down_rounded,
          size: 20.sp,
          color: isSelected ? AppColors.brandNavy : AppColors.white,
        ),
      ],
    );
  }
}
