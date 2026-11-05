import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../extensions/app_display_extensions.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

/// "Resend in 0:59", then a resend link. Restarts whenever [restartKey]
/// changes.
class ResendCountdownWidget extends HookWidget {
  const ResendCountdownWidget({
    required this.onResend,
    super.key,
    this.seconds = 60,
    this.restartKey = 0,
    this.enabled = true,
  });

  final VoidCallback onResend;
  final int seconds;
  final int restartKey;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final remaining = useState(seconds);
    useEffect(() {
      remaining.value = seconds;
      final timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (remaining.value <= 1) t.cancel();
        remaining.value = (remaining.value - 1).clamp(0, seconds);
      });
      return timer.cancel;
    }, [restartKey]);

    final lang = context.locale.languageCode;
    if (remaining.value > 0) {
      final s = remaining.value;
      final raw = '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';
      final clock = lang == 'ar' ? raw.toArabicDigits() : raw;
      return Text(
        'common.resend_in'.tr(context: context, args: [clock]),
        textAlign: TextAlign.center,
        style: AppTextStyles.font13Regular,
      );
    }
    return TextButton(
      onPressed: enabled ? onResend : null,
      child: Text(
        'common.resend_code'.tr(context: context),
        style: AppTextStyles.font14Bold.copyWith(color: AppColors.brandNavy),
      ),
    );
  }
}
