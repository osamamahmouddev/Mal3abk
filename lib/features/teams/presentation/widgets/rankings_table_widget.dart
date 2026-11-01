import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import 'team_rank_card_widget.dart';

class RankingsTableWidget extends StatelessWidget {
  const RankingsTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'teams.$key'.tr(context: context);
    final headStyle = AppTextStyles.font11Regular.copyWith(
      fontWeight: FontWeight.w600,
    );

    return CustomCardWidget(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            height: 33.h,
            color: AppColors.tableHead,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              children: [
                Container(
                  width: 30.w,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(t('rankings.col_rank'), style: headStyle),
                ),
                Expanded(
                  flex: 5,
                  child: Text(t('rankings.col_team'), style: headStyle),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    t('rankings.col_record'),
                    style: headStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 32.w,
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(t('rankings.col_points'), style: headStyle),
                ),
              ],
            ),
          ),
          TeamRankCardWidget(
            rank: '٤',
            teamName: 'teams.rankings.your_team'.tr(
              context: context,
              args: [t('profile.mine_name')],
            ),
            trend: '▲ ٢',
            record: '١٤-٣-٥',
            points: '٣١',
            isMyTeam: true,
          ),
          TeamRankCardWidget(
            rank: '٥',
            teamName: t('profile.new_name'),
            trend: '▼ ١',
            record: '٨-٢-٥',
            points: '٢٦',
          ),
          TeamRankCardWidget(
            rank: '٦',
            teamName: t('sample.flamingo'),
            trend: t('rankings.no_change'),
            record: '٧-٤-٦',
            points: '٢٥',
          ),
        ],
      ),
    );
  }
}
