import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.hintText,
    super.key,
    this.labelText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.focusNode,
    this.keyboardType,
    this.autofocus = false,
    this.validator,
    this.autovalidateMode,
    this.fillColor = AppColors.white,
    this.enabled = true,
    this.readOnly = false,
    this.minLines,
    this.maxLines = 1,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius,
    this.contentPadding,
    this.isDense,
    this.style,
    this.hintStyle,
    this.errorText,
    this.inputFormatters,
  });

  final String hintText;
  final String? labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextAlign textAlign;

  /// Forces the text direction, e.g. [TextDirection.ltr] for phone numbers
  /// inside an RTL screen; null follows the screen.
  final TextDirection? textDirection;
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool autofocus;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final Color? fillColor;
  final bool enabled;
  final bool readOnly;
  final int? minLines;
  final int? maxLines;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isDense;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = BorderRadius.circular((borderRadius ?? 12).r);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: AppTextStyles.font14SemiBold.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          vSpace(8),
        ],
        Directionality(
          textDirection: textDirection ?? Directionality.of(context),
          child: TextFormField(
            controller: controller,
            initialValue: initialValue,
            focusNode: focusNode,
            keyboardType: keyboardType,
            textInputAction: TextInputAction.next,
            textAlign: textAlign,
            textDirection: textDirection,
            autofocus: autofocus,
            readOnly: readOnly,
            enabled: enabled,
            obscureText: obscureText,
            minLines: minLines,
            maxLines: maxLines,
            onChanged: onChanged,
            onTap: onTap,
            onFieldSubmitted: onFieldSubmitted,
            validator: validator,
            autovalidateMode: autovalidateMode,
            inputFormatters: inputFormatters,
            style: style ?? AppTextStyles.font14Medium,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle:
                  hintStyle ??
                  AppTextStyles.font14Regular.copyWith(
                    color: AppColors.textMuted,
                  ),
              errorText: errorText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: fillColor,
              isDense: isDense,
              contentPadding:
                  contentPadding ??
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              border: OutlineInputBorder(
                borderRadius: effectiveBorderRadius,
                borderSide: BorderSide(
                  color: borderColor ?? AppColors.borderInput,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: effectiveBorderRadius,
                borderSide: BorderSide(
                  color: borderColor ?? AppColors.borderInput,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: effectiveBorderRadius,
                borderSide: BorderSide(
                  color: focusedBorderColor ?? AppColors.focusedBorder,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: effectiveBorderRadius,
                borderSide: const BorderSide(color: AppColors.error, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: effectiveBorderRadius,
                borderSide: const BorderSide(
                  color: AppColors.error,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
