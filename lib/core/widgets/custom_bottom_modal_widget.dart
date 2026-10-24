import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'custom_button.dart';

class CustomBottomModalWidget extends StatelessWidget {
  const CustomBottomModalWidget({
    required this.title,
    required this.content,
    super.key,
    this.primaryActionText,
    this.secondaryActionText,
    this.onPrimaryAction,
    this.onSecondaryAction,
    this.isDestructive = false,
  });

  final String title;
  final Widget content;
  final String? primaryActionText;
  final String? secondaryActionText;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;
  final bool isDestructive;

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    String? primaryActionText,
    String? secondaryActionText,
    VoidCallback? onPrimaryAction,
    VoidCallback? onSecondaryAction,
    bool isDestructive = false,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CustomBottomModalWidget(
        title: title,
        content: content,
        primaryActionText: primaryActionText,
        secondaryActionText: secondaryActionText,
        onPrimaryAction: onPrimaryAction,
        onSecondaryAction: onSecondaryAction,
        isDestructive: isDestructive,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        20.w,
        14.h,
        20.w,
        MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 44.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.borderInput,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.font18Bold,
              ),
              IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: Icon(
                  Icons.close_rounded,
                  size: 22.sp,
                  color: AppColors.textSecondary,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          content,
          if (primaryActionText != null || secondaryActionText != null) ...[
            SizedBox(height: 24.h),
            Row(
              children: [
                if (secondaryActionText != null)
                  Expanded(
                    child: CustomButton(
                      text: secondaryActionText!,
                      onTap: onSecondaryAction ?? () => Navigator.of(context).maybePop(),
                      type: CustomButtonType.outline,
                      height: 48.h,
                    ),
                  ),
                if (primaryActionText != null && secondaryActionText != null)
                  SizedBox(width: 12.w),
                if (primaryActionText != null)
                  Expanded(
                    child: CustomButton(
                      text: primaryActionText!,
                      onTap: onPrimaryAction ?? () {},
                      type: isDestructive
                          ? CustomButtonType.primary
                          : CustomButtonType.secondary,
                      height: 48.h,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

