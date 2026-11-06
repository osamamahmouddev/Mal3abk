import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/app_assets.dart';
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
  });

  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderInput),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: AppTextStyles.font15Regular,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: AppTextStyles.font15Regular.copyWith(
            color: AppColors.hintText,
          ),
          prefixIcon: Padding(
            padding: EdgeInsetsDirectional.only(start: 14.w, end: 9.w),
            child: SvgPicture.asset(
              AppAssets.icSearch17,
              width: 17.r,
              height: 18.r,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(),
          border: InputBorder.none,
          contentPadding: EdgeInsetsDirectional.only(end: 14.w),
        ),
      ),
    );
  }
}
