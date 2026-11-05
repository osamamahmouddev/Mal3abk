import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class TeamSettingSwitchRowWidget extends StatelessWidget {
  const TeamSettingSwitchRowWidget({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.font14Bold),
                hSpace(2),
                Text(subtitle, style: AppTextStyles.font12Regular),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            activeTrackColor: AppColors.brandNavy,
            onChanged: (next) {
              HapticFeedback.lightImpact();
              onChanged(next);
            },
          ),
        ],
      ),
    );
  }
}
