import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/initials_avatar_widget.dart';

class ScoreStepperWidget extends StatelessWidget {
  const ScoreStepperWidget({
    required this.teamName,
    required this.score,
    required this.color,
    required this.onChanged,
    super.key,
  });

  static const int maxScore = 99;

  final String teamName;
  final int score;
  final Color color;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;

    void change(int value) {
      if (value < 0 || value > maxScore) return;
      HapticFeedback.selectionClick();
      onChanged(value);
    }

    return Expanded(
      child: Column(
        children: [
          InitialsAvatarWidget(
            initials: teamName.initials,
            color: color,
            size: 52,
          ),
          hSpace(6),
          Text(
            teamName,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font15Bold.copyWith(color: AppColors.white),
          ),
          hSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: score > 0 ? () => change(score - 1) : null,
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: AppColors.white,
                  size: 26.sp,
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 160),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Text(
                  score.toLocalizedDigits(lang),
                  key: ValueKey(score),
                  style: AppTextStyles.font24Bold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: score < maxScore ? () => change(score + 1) : null,
                icon: Icon(
                  Icons.add_circle_outline,
                  color: AppColors.white,
                  size: 26.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
