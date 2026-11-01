import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class PendingInviteRowWidget extends StatelessWidget {
  const PendingInviteRowWidget({
    required this.initials,
    required this.title,
    required this.meta,
    required this.onCancel,
    super.key,
  });

  final String initials;
  final String title;
  final String meta;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 77.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.lightSurface)),
      ),
      child: Row(
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.checkboxBorder, width: 2),
            ),
            child: Text(
              initials,
              style: AppTextStyles.font12Bold.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.font14SemiBold),
                hSpace(4),
                Text(meta, style: AppTextStyles.font12Regular),
              ],
            ),
          ),
          CustomButton(
            text: 'teams.manage.cancel'.tr(context: context),
            type: CustomButtonType.outline,
            height: 36.h,
            borderRadius: 9,
            backgroundColor: AppColors.white,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            textStyle: AppTextStyles.font13SemiBold.copyWith(
              color: AppColors.brandNavy,
            ),
            onTap: onCancel,
          ),
        ],
      ),
    );
  }
}
