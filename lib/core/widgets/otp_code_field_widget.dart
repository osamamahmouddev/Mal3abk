import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

/// Six digit boxes backed by one invisible field, so paste and SMS autofill
/// work. Calls [onCompleted] once all digits are entered.
class OtpCodeFieldWidget extends HookWidget {
  const OtpCodeFieldWidget({
    required this.controller,
    super.key,
    this.length = 6,
    this.onCompleted,
    this.hasError = false,
    this.autofocus = true,
  });

  final TextEditingController controller;
  final int length;
  final ValueChanged<String>? onCompleted;
  final bool hasError;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final value = useValueListenable(controller).text;
    final focused = useListenableSelector(focusNode, () => focusNode.hasFocus);

    return GestureDetector(
      onTap: focusNode.requestFocus,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 46.w,
                    height: 56.h,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        width: 1.5,
                        color: hasError
                            ? AppColors.brandRed
                            : focused && i == value.length.clamp(0, length - 1)
                            ? AppColors.brandNavy
                            : AppColors.borderInput,
                      ),
                    ),
                    child: Text(
                      i < value.length ? value[i] : '',
                      style: AppTextStyles.font20Bold,
                    ),
                  ),
              ],
            ),
          ),
          Opacity(
            opacity: 0,
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: autofocus,
              keyboardType: TextInputType.number,
              autofillHints: const [AutofillHints.oneTimeCode],
              showCursor: false,
              enableInteractiveSelection: false,
              maxLength: length,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(counterText: ''),
              onChanged: (text) {
                HapticFeedback.selectionClick();
                if (text.length == length) onCompleted?.call(text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
