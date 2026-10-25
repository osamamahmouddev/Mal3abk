import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/empty_note_box_widget.dart';
import 'team_profile_variant.dart';
import 'team_result_row_widget.dart';

class TeamProfileMatchesSectionWidget extends StatelessWidget {
  const TeamProfileMatchesSectionWidget({required this.variant, super.key});

  final TeamProfileVariant variant;

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'teams.profile.$key'.tr(context: context);

    final results = switch (variant) {
      TeamProfileVariant.mine => [
          (TeamResultType.pending, t('res_pending'), t('r1_title'), t('r1_meta'), '٤–٣'),
          (TeamResultType.draw, t('res_draw'), t('r2_title'), t('r2_meta'), '٢–٢'),
          (TeamResultType.loss, t('res_loss'), t('r3_title'), t('r3_meta'), '١–٣'),
        ],
      TeamProfileVariant.other => [
          (TeamResultType.win, t('res_win'), t('o1_title'), t('o1_meta'), '٥–٢'),
          (TeamResultType.pending, t('res_pending'), t('o2_title'), t('o2_meta'), '٣–٤'),
        ],
      TeamProfileVariant.fresh => <(TeamResultType, String, String, String, String)>[],
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(t('next_match'), style: AppTextStyles.font15Bold),
        hSpace(14),
        if (variant == TeamProfileVariant.mine)
          CustomCardWidget(
            borderRadius: 18,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t('next_vs'), style: AppTextStyles.font14Bold),
                      hSpace(4),
                      Text(t('next_meta'), style: AppTextStyles.font12Regular),
                    ],
                  ),
                ),
                AppBadgeWidget(
                  text: t('not_booked'),
                  type: AppBadgeType.warning,
                  borderRadius: 11.5,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  textStyle: AppTextStyles.font11Bold.copyWith(color: AppColors.goldDark),
                ),
              ],
            ),
          )
        else
          EmptyNoteBoxWidget(
            text: variant == TeamProfileVariant.fresh ? t('no_matches_new') : t('no_matches'),
          ),
        hSpace(10),
        Text(t('last_results'), style: AppTextStyles.font15Bold),
        hSpace(14),
        if (results.isEmpty)
          EmptyNoteBoxWidget(text: t('no_results'))
        else
          CustomCardWidget(
            borderRadius: 18,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                for (final (type, letter, title, meta, score) in results)
                  TeamResultRowWidget(
                    type: type,
                    letter: letter,
                    title: title,
                    meta: meta,
                    score: score,
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
