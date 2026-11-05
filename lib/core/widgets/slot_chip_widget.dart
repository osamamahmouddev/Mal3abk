import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_text_styles.dart';

class SlotChipWidget extends StatelessWidget {
  const SlotChipWidget({required this.label, super.key, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(10.r);

    return Material(
      color: const Color(0xFFEAF5EE),
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
          child: Text(
            label,
            style: AppTextStyles.font12Bold.copyWith(
              color: const Color(0xFF1B6E3E),
            ),
          ),
        ),
      ),
    );
  }
}
