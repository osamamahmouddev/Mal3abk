import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_back_button_widget.dart';

class OnboardingStepHeaderWidget extends StatelessWidget {
  const OnboardingStepHeaderWidget({
    required this.stepLabel,
    required this.completedSteps,
    super.key,
    this.totalSteps = 2,
  });

  final String stepLabel;
  final int completedSteps;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AppBackButtonWidget(),
            Text(stepLabel, style: AppTextStyles.font13Regular),
          ],
        ),
        hSpace(12),
        Row(
          children: [
            for (var i = 0; i < totalSteps; i++) ...[
              if (i > 0) vSpace(6),
              Expanded(
                child: Container(
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: i < completedSteps
                        ? AppColors.brandRed
                        : AppColors.border,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
