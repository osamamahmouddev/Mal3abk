import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class SettingsActionTileWidget extends StatelessWidget {
  const SettingsActionTileWidget({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
    this.isDestructive = false,
    this.isLoading = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.brandNavy;

    return ListTile(
      leading: Icon(icon, color: color, size: 22.sp),
      title: Text(
        title,
        style: AppTextStyles.font14SemiBold.copyWith(color: color),
      ),
      trailing: isLoading
          ? CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.brandNavy,
              constraints: BoxConstraints.tightFor(width: 18.w, height: 18.w),
            )
          : Icon(
              Directionality.of(context) == TextDirection.rtl
                  ? Icons.arrow_back_ios_new_rounded
                  : Icons.arrow_forward_ios_rounded,
              size: 14.sp,
              color: AppColors.textSecondary,
            ),
      onTap: onTap,
    );
  }
}
