import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

/// Colored circle with white initials (teams, players).
class InitialsAvatarWidget extends StatelessWidget {
  const InitialsAvatarWidget({
    required this.initials,
    required this.color,
    required this.size,
    super.key,
    this.textStyle,
  });

  final String initials;
  final Color color;
  final double size;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.r,
      height: size.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Text(
        initials,
        style: (textStyle ?? AppTextStyles.font16Bold).copyWith(
          color: AppColors.white,
        ),
      ),
    );
  }
}
