import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/app_animations.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

/// A compact tappable row for a teams action (new team, join by code): icon,
/// title and a one-line hint. It sinks a little under the finger and springs
/// back when released.
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
          padding: EdgeInsetsDirectional.fromSTEB(10.w, 10.h, 12.w, 10.h),
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
            borderRadius: BorderRadius.circular(14.r),
            border: filled ? null : Border.all(color: AppColors.border),
            boxShadow: filled
                ? [
                    BoxShadow(
                      color: AppColors.brandRed.withValues(alpha: 0.18),
                      blurRadius: 12.r,
                      offset: Offset(0, 4.h),
                      spreadRadius: -6.r,
                    ),
                  ]
                : const [],
          ),
          child: Row(
            children: [
              Container(
                width: 32.r,
                height: 32.r,
                decoration: BoxDecoration(
                  color: filled
                      ? AppColors.white.withValues(alpha: 0.2)
                      : AppColors.lightSurface,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: fg, size: 18.r),
              ),
              vSpace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font14Bold.copyWith(color: fg),
                    ),
                    Text(
                      hint,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font11Regular.copyWith(
                        color: filled
                            ? AppColors.white.withValues(alpha: 0.85)
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
