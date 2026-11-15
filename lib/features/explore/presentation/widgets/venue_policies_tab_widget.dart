import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/empty_note_box_widget.dart';
import '../../data/models/public_deposit_policy_model.dart';

class VenuePoliciesTabWidget extends StatelessWidget {
  const VenuePoliciesTabWidget({required this.policy, super.key});

  final PublicDepositPolicyModel? policy;

  @override
  Widget build(BuildContext context) {
    final p = policy;
    if (p == null) {
      return EmptyNoteBoxWidget(
        text: 'explore.venue.policy_standard'.tr(context: context),
      );
    }
    final lang = context.locale.languageCode;
    String n(num value) => value.round().toLocalizedDigits(lang);
    String t(String key, [List<String>? args]) =>
        'explore.venue.policy.$key'.tr(context: context, args: args);

    final items = <_PolicyItem>[
      _PolicyItem(
        icon: Icons.payments_outlined,
        iconColor: const Color(0xFF16A34A),
        iconBgColor: const Color(0xFFF0FDF4),
        text: p.depositType == 'Percentage'
            ? t('deposit_percent', [n(p.depositValue)])
            : t('deposit_fixed', [n(p.depositValue)]),
      ),
      _PolicyItem(
        icon: Icons.timer_outlined,
        iconColor: const Color(0xFFEA580C),
        iconBgColor: const Color(0xFFFFF7ED),
        text: t('proof_window', [n(p.proofSubmissionWindowMinutes)]),
      ),
      _PolicyItem(
        icon: Icons.published_with_changes_rounded,
        iconColor: const Color(0xFF2563EB),
        iconBgColor: const Color(0xFFEFF6FF),
        text: switch (p.refundEligibility) {
          'NoRefund' => t('no_refund'),
          'PartialRefund' => t('partial_refund', [
            n(p.refundPercentage),
            n(p.cancellationDeadlineHours),
          ]),
          _ => t('full_refund', [n(p.cancellationDeadlineHours)]),
        },
      ),
      _PolicyItem(
        icon: Icons.schedule_rounded,
        iconColor: const Color(0xFF0D9488),
        iconBgColor: const Color(0xFFF0FDFA),
        text: t('late_grace', [n(p.lateArrivalGraceMinutes)]),
      ),
      _PolicyItem(
        icon: Icons.person_off_outlined,
        iconColor: const Color(0xFFE11D48),
        iconBgColor: const Color(0xFFFFF1F2),
        text: switch (p.noShowRule) {
          'ForfeitFullAmount' => t('no_show_full'),
          'NoPenalty' => t('no_show_none'),
          _ => t('no_show_deposit'),
        },
      ),
      if (p.allowReschedule)
        _PolicyItem(
          icon: Icons.edit_calendar_rounded,
          iconColor: const Color(0xFF7C3AED),
          iconBgColor: const Color(0xFFF5F3FF),
          text: t('reschedule', [n(p.rescheduleDeadlineHours)]),
        ),
    ];

    return CustomCardWidget(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.shield_outlined,
                  size: 20.r,
                  color: AppColors.pitchGreenDark,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  'explore.venue.policy_title'.tr(context: context),
                  style: AppTextStyles.font16Bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          const Divider(height: 1, color: AppColors.borderCard),
          SizedBox(height: 12.h),
          for (var i = 0; i < items.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 34.r,
                  height: 34.r,
                  decoration: BoxDecoration(
                    color: items[i].iconBgColor,
                    borderRadius: BorderRadius.circular(9.r),
                  ),
                  child: Icon(
                    items[i].icon,
                    size: 18.r,
                    color: items[i].iconColor,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    items[i].text,
                    style: AppTextStyles.font14Medium.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
            if (i < items.length - 1) SizedBox(height: 10.h),
          ],
          if (p.terms case final terms? when terms.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.pageBackground,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.borderCard),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 18.r,
                    color: AppColors.textMuted,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      terms,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PolicyItem {
  const _PolicyItem({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.text,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String text;
}
