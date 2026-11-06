import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
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

    final lines = [
      p.depositType == 'Percentage'
          ? t('deposit_percent', [n(p.depositValue)])
          : t('deposit_fixed', [n(p.depositValue)]),
      t('proof_window', [n(p.proofSubmissionWindowMinutes)]),
      switch (p.refundEligibility) {
        'NoRefund' => t('no_refund'),
        'PartialRefund' => t('partial_refund', [
          n(p.refundPercentage),
          n(p.cancellationDeadlineHours),
        ]),
        _ => t('full_refund', [n(p.cancellationDeadlineHours)]),
      },
      t('late_grace', [n(p.lateArrivalGraceMinutes)]),
      switch (p.noShowRule) {
        'ForfeitFullAmount' => t('no_show_full'),
        'NoPenalty' => t('no_show_none'),
        _ => t('no_show_deposit'),
      },
      if (p.allowReschedule) t('reschedule', [n(p.rescheduleDeadlineHours)]),
    ];

    return CustomCardWidget(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'explore.venue.policy_title'.tr(context: context),
            style: AppTextStyles.font16Bold,
          ),
          hSpace(10),
          for (final line in lines) ...[
            Text('• $line', style: AppTextStyles.font13Regular),
            hSpace(6),
          ],
          if (p.terms case final terms? when terms.isNotEmpty) ...[
            hSpace(4),
            Text(terms, style: AppTextStyles.font12Regular),
          ],
        ],
      ),
    );
  }
}
