import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/app_animations.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

/// A big tappable card for a teams action (new team, join by code). It sinks a
/// little under the finger and springs back when released.
class TeamsActionCardWidget extends HookWidget {
  const TeamsActionCardWidget({
    required this.icon,
    required this.title,
    required this.hint,
    required this.onTap,
    this.filled = false,
    super.key,
  });

  final IconData icon;
  final String title;
  final String hint;
  final VoidCallback onTap;

  /// Red and filled for the main action, white with a border otherwise.
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final pressed = useState(false);
    final fg = filled ? AppColors.white : AppColors.brandNavy;
    return GestureDetector(
      onTapDown: (_) => pressed.value = true,
      onTapCancel: () => pressed.value = false,
      onTapUp: (_) => pressed.value = false,
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: AnimatedScale(
        duration: AppAnimations.duration(context, AppAnimations.fast),
        curve: AppAnimations.standard,
        scale: pressed.value ? 0.96 : 1,
        child: Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            gradient: filled
                ? LinearGradient(
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                    colors: [
                      Color.lerp(AppColors.brandRed, AppColors.white, 0.1)!,
                      AppColors.brandRed,
                    ],
                  )
                : null,
            color: filled ? null : AppColors.white,
            borderRadius: BorderRadius.circular(18.r),
            border: filled ? null : Border.all(color: AppColors.border),
            boxShadow: filled
                ? [
                    BoxShadow(
                      color: AppColors.brandRed.withValues(alpha: 0.35),
                      blurRadius: 18.r,
                      offset: Offset(0, 8.h),
                    ),
                  ]
                : const [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: filled
                      ? AppColors.white.withValues(alpha: 0.2)
                      : AppColors.lightSurface,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: fg, size: 20.r),
              ),
              hSpace(10),
              Text(title, style: AppTextStyles.font15Bold.copyWith(color: fg)),
              hSpace(2),
              Text(
                hint,
                maxLines: 2,
                style: AppTextStyles.font12Regular.copyWith(
                  color: filled
                      ? AppColors.white.withValues(alpha: 0.85)
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
