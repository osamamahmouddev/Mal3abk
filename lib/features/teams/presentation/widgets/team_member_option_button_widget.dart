import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

/// One action in a team member's options sheet.
class TeamMemberOptionButtonWidget extends StatelessWidget {
  const TeamMemberOptionButtonWidget({
    required this.text,
    required this.onTap,
    super.key,
    this.isDestructive = false,
  });

  final String text;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      type: CustomButtonType.outline,
      height: 50.h,
      borderRadius: 12,
      borderColor: isDestructive ? AppColors.redBorder : null,
      textStyle: AppTextStyles.font15SemiBold.copyWith(
        color: isDestructive ? AppColors.redText : AppColors.brandNavy,
      ),
      onTap: onTap,
    );
  }
}
