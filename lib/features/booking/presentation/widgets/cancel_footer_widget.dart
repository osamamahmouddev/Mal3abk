import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';

class CancelFooterWidget extends StatelessWidget {
  const CancelFooterWidget({
    required this.canConfirm,
    required this.onConfirm,
    super.key,
  });

  final bool canConfirm;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return BottomActionBarWidget(
      child: Row(
        children: [
          Expanded(
            flex: 170,
            child: CustomButton(
              text: 'booking.cancel.keep'.tr(context: context),
              type: CustomButtonType.outline,
              height: 54.h,
              borderRadius: 16,
              textStyle: AppTextStyles.font15SemiBold.copyWith(
                color: AppColors.brandNavy,
              ),
              onTap: () => Navigator.of(context).maybePop(),
            ),
          ),
          vSpace(8),
          Expanded(
            flex: 180,
            child: CustomButton(
              text: 'booking.cancel.confirm'.tr(context: context),
              height: 54.h,
              borderRadius: 16,
              backgroundColor: canConfirm
                  ? AppColors.brandRed
                  : AppColors.border,
              boxShadow: canConfirm ? AppShadows.redGlow : null,
              textStyle: AppTextStyles.font15Bold.copyWith(
                color: canConfirm ? AppColors.white : AppColors.mapLabel,
              ),
              onTap: onConfirm,
            ),
          ),
        ],
      ),
    );
  }
}
