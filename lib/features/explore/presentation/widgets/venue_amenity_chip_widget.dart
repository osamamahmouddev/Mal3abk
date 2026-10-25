import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class VenueAmenityChipWidget extends StatelessWidget {
  const VenueAmenityChipWidget({
    required this.icon,
    required this.label,
    super.key,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 22.sp, color: AppColors.brandNavy),
        hSpace(4),
        Text(label, style: AppTextStyles.font11Regular),
      ],
    );
  }
}
