import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';

class CustomSkeletonWidget extends HookWidget {
  const CustomSkeletonWidget({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    final animation = useAnimation(
      Tween<double>(begin: 0.3, end: 0.8).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      ),
    );

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.border.withValues(alpha: animation),
        borderRadius: BorderRadius.circular((borderRadius ?? 8).r),
      ),
    );
  }
}
