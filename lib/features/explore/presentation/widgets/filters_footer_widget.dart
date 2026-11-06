import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/primary_cta_button_widget.dart';

class FiltersFooterWidget extends StatelessWidget {
  const FiltersFooterWidget({
    required this.onClear,
    required this.onApply,
    super.key,
  });

  final VoidCallback onClear;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        minimum: EdgeInsets.only(bottom: 25.h),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
          child: Row(
            children: [
              CustomButton(
                text: 'explore.filters.clear_all'.tr(context: context),
                type: CustomButtonType.outline,
                width: 110.w,
                height: 52.h,
                borderRadius: 16,
                backgroundColor: AppColors.white,
                textStyle: AppTextStyles.font15SemiBold.copyWith(
                  color: AppColors.brandNavy,
                ),
                onTap: onClear,
              ),
              vSpace(8),
              Expanded(
                child: PrimaryCtaButtonWidget(
                  text: 'explore.filters.apply'.tr(context: context),
                  onTap: onApply,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
