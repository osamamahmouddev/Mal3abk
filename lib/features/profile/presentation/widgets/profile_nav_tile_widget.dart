import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class ProfileNavTileWidget extends StatelessWidget {
  const ProfileNavTileWidget({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
    this.trailing = '',
  });

  final IconData icon;
  final String title;
  final String trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.brandNavy, size: 22.sp),
      title: Text(title, style: AppTextStyles.font14Medium),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing.isNotEmpty) ...[
            Text(trailing, style: AppTextStyles.font12Regular),
            vSpace(6),
          ],
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14.sp,
            color: AppColors.textSecondary,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
