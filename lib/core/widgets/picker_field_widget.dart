import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'press_scale_widget.dart';

/// A form field that opens a picker: the chosen value (or a hint) with a
/// chevron, in the same shape as the text fields around it.
class PickerFieldWidget extends StatelessWidget {
  const PickerFieldWidget({
    required this.hint,
    required this.onTap,
    this.value,
    this.icon,
    super.key,
  });

  final String hint;
  final String? value;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.isNotEmpty;
    return Semantics(
      button: true,
      label: hasValue ? value : hint,
      child: PressScaleWidget(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Container(
            height: 52.h,
            padding: EdgeInsetsDirectional.only(start: 14.w, end: 10.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: hasValue ? AppColors.brandNavy : AppColors.borderInput,
              ),
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 18.r, color: AppColors.textSecondary),
                  vSpace(8),
                ],
                Expanded(
                  child: Text(
                    hasValue ? value! : hint,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: hasValue
                        ? AppTextStyles.font15SemiBold
                        : AppTextStyles.font15Regular.copyWith(
                            color: AppColors.hintText,
                          ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 22.r,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
