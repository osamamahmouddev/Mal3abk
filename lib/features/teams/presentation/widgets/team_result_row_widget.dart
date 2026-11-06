import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

enum TeamResultType { win, draw, loss, pending }

class TeamResultRowWidget extends StatelessWidget {
  const TeamResultRowWidget({
    required this.type,
    required this.letter,
    required this.title,
    required this.meta,
    required this.score,
    super.key,
    this.showDivider = true,
    this.onTap,
  });

  final TeamResultType type;
  final String letter;
  final String title;
  final String meta;
  final String score;
  final bool showDivider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (type) {
      TeamResultType.win => (AppColors.successLight, AppColors.successGreen),
      TeamResultType.loss => (AppColors.redLight, AppColors.redText),
      _ => (AppColors.lightSurface, AppColors.offlineBanner),
    };

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 69.h,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(bottom: BorderSide(color: AppColors.lightSurface))
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 28.r,
              height: 28.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                letter,
                style: AppTextStyles.font12Bold.copyWith(color: fg),
              ),
            ),
            vSpace(10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.font14SemiBold),
                  hSpace(2),
                  Text(meta, style: AppTextStyles.font11Regular),
                ],
              ),
            ),
            Text(score, style: AppTextStyles.font15Bold),
          ],
        ),
      ),
    );
  }
}
