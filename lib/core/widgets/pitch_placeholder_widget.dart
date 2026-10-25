import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';

class PitchPlaceholderWidget extends StatelessWidget {
  const PitchPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.pitchGreen,
      child: Center(
        child: Icon(
          Icons.sports_soccer_rounded,
          size: 32.sp,
          color: AppColors.white.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}
