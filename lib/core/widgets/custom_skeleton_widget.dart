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
    );
    useEffect(() {
      controller.repeat(reverse: true);
      return null;
    }, [controller]);

    final opacity = useMemoized(
      () => Tween<double>(begin: 0.55, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      ),
      [controller],
    );

    return RepaintBoundary(
      child: FadeTransition(
        opacity: opacity,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.circular((borderRadius ?? 8).r),
          ),
        ),
      ),
    );
  }
}
