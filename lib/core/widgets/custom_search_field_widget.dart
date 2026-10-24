import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class CustomSearchFieldWidget extends StatelessWidget {
  const CustomSearchFieldWidget({
    required this.hintText,
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.onFilterTap,
    this.hasActiveFilters = false,
  });

  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool readOnly;
  final VoidCallback? onFilterTap;
  final bool hasActiveFilters;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.borderInput, width: 1),
            ),
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              onTap: onTap,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              style: AppTextStyles.font14Medium,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.textMuted,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 22.sp,
                  color: AppColors.textSecondary,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),
        ),
        if (onFilterTap != null) ...[
          SizedBox(width: 10.w),
          Material(
            color: hasActiveFilters ? AppColors.brandNavy : AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            child: InkWell(
              onTap: onFilterTap,
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                width: 50.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: hasActiveFilters
                        ? AppColors.brandNavy
                        : AppColors.borderInput,
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.tune_rounded,
                  size: 22.sp,
                  color: hasActiveFilters ? AppColors.white : AppColors.brandNavy,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

