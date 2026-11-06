import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

/// A jersey disc on the board. Drag it onto another disc, or tap two discs, to swap.
class TacticalPlayerDiscWidget extends StatelessWidget {
  const TacticalPlayerDiscWidget({
    required this.slot,
    required this.label,
    required this.name,
    required this.isSelected,
    required this.isGoalkeeper,
    required this.onTap,
    required this.onSwap,
    super.key,
  });

  final int slot;
  final String label;
  final String name;
  final bool isSelected;
  final bool isGoalkeeper;
  final VoidCallback onTap;
  final void Function(int from, int to) onSwap;

  @override
  Widget build(BuildContext context) {
    final disc = AnimatedScale(
      scale: isSelected ? 1.18 : 1,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isGoalkeeper ? AppColors.accentGold : AppColors.brandRed,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? AppColors.white
                    : AppColors.white.withValues(alpha: 0.6),
                width: isSelected ? 3 : 2,
              ),
            ),
            child: Text(
              label,
              style: AppTextStyles.font13SemiBold.copyWith(
                color: isGoalkeeper ? AppColors.brandNavy : AppColors.white,
              ),
            ),
          ),
          hSpace(2),
          SizedBox(
            width: 72.w,
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTextStyles.font11Bold.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );

    return DragTarget<int>(
      onWillAcceptWithDetails: (details) => details.data != slot,
      onAcceptWithDetails: (details) {
        HapticFeedback.mediumImpact();
        onSwap(details.data, slot);
      },
      builder: (context, candidates, _) => LongPressDraggable<int>(
        data: slot,
        hapticFeedbackOnStart: true,
        feedback: Material(color: AppColors.transparent, child: disc),
        childWhenDragging: Opacity(opacity: 0.3, child: disc),
        child: GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
          },
          child: AnimatedOpacity(
            opacity: candidates.isEmpty ? 1 : 0.6,
            duration: const Duration(milliseconds: 120),
            child: disc,
          ),
        ),
      ),
    );
  }
}
