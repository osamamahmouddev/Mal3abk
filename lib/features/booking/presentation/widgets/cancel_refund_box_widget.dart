import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../data/models/cancel_preview_model.dart';

class CancelRefundBoxWidget extends StatelessWidget {
  const CancelRefundBoxWidget({required this.preview, super.key});

  final CancelPreviewModel preview;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final refunds = preview.estimatedRefundAmount > 0;
    final (bg, fg) = refunds
        ? (AppColors.successLight, AppColors.successText)
        : (AppColors.redLight, AppColors.redDark);
    String t(String key, [List<String>? args]) =>
        'booking.cancel.$key'.tr(context: context, args: args);

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            refunds
                ? t('refund_amount', [
                    preview.estimatedRefundAmount.round().toLocalizedDigits(
                      lang,
                    ),
                    preview.refundPercentage.round().toLocalizedDigits(lang),
                  ])
                : t('no_refund'),
            style: AppTextStyles.font15Bold.copyWith(color: fg),
          ),
          if (preview.cancellationDeadlineUtc case final deadline?) ...[
            hSpace(4),
            Text(
              t('deadline', [CairoTime.dayAndTime(deadline, lang)]),
              style: AppTextStyles.font12Regular.copyWith(color: fg),
            ),
          ],
          if (preview.policySummary case final policy?
              when policy.isNotEmpty) ...[
            hSpace(6),
            Text(
              policy,
              style: AppTextStyles.font12Regular.copyWith(color: fg),
            ),
          ],
        ],
      ),
    );
  }
}
