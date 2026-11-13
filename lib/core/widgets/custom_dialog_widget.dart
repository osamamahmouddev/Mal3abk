import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'custom_button.dart';

class CustomDialogWidget extends StatelessWidget {
  const CustomDialogWidget({
    required this.title,
    required this.description,
    super.key,
    this.primaryActionText,
    this.secondaryActionText,
    this.onPrimaryAction,
    this.onSecondaryAction,
    this.isDestructive = false,
    this.icon,
  });

  final String title;
  final String description;
  final String? primaryActionText;
  final String? secondaryActionText;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;
  final bool isDestructive;
  final Widget? icon;

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String description,
    String? primaryActionText,
    String? secondaryActionText,
    VoidCallback? onPrimaryAction,
    VoidCallback? onSecondaryAction,
    bool isDestructive = false,
    Widget? icon,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => CustomDialogWidget(
        title: title,
        description: description,
        primaryActionText: primaryActionText,
        secondaryActionText: secondaryActionText,
        onPrimaryAction: onPrimaryAction,
        onSecondaryAction: onSecondaryAction,
        isDestructive: isDestructive,
        icon: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[icon!, hSpace(14)],
            Text(
              title,
              style: AppTextStyles.font18Bold,
              textAlign: TextAlign.center,
            ),
            hSpace(8),
            Text(
              description,
              style: AppTextStyles.font14Regular,
              textAlign: TextAlign.center,
            ),
            if (primaryActionText != null || secondaryActionText != null) ...[
              hSpace(20),
              Row(
                children: [
                  if (secondaryActionText != null)
                    Expanded(
                      child: CustomButton(
                        text: secondaryActionText!,
                        onTap:
                            onSecondaryAction ??
                            () => Navigator.of(context).maybePop(),
                        type: CustomButtonType.outline,
                        height: 44.h,
                      ),
                    ),
                  if (primaryActionText != null && secondaryActionText != null)
                    vSpace(10),
                  if (primaryActionText != null)
                    Expanded(
                      child: CustomButton(
                        text: primaryActionText!,
                        onTap: onPrimaryAction ?? () {},
                        type: isDestructive
                            ? CustomButtonType.primary
                            : CustomButtonType.secondary,
                        height: 44.h,
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
