import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../data/models/team_leaderboard_entry_model.dart';
import 'team_rank_card_widget.dart';

class RankingsTableWidget extends StatelessWidget {
  const RankingsTableWidget({
    required this.entries,
    required this.myTeamIds,
    super.key,
  });

  final List<TeamLeaderboardEntryModel> entries;
  final Set<String> myTeamIds;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    String t(String key) => 'teams.rankings.$key'.tr(context: context);
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
                  child: Text(t('col_rank'), style: headStyle),
                ),
                Expanded(flex: 5, child: Text(t('col_team'), style: headStyle)),
                Expanded(
                  flex: 3,
                  child: Text(
                    t('col_record'),
                    style: headStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 32.w,
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(t('col_points'), style: headStyle),
                ),
              ],
            ),
          ),
          for (final entry in entries)
            InkWell(
              onTap: () => Navigator.of(
                context,
              ).pushNamed(AppRoutes.teamProfile, arguments: entry.teamId),
              child: TeamRankCardWidget(
                rank: entry.rank.toLocalizedDigits(lang),
                teamName: entry.name,
                trend: entry.city,
                record:
                    '${entry.wins.toLocalizedDigits(lang)}-${entry.draws.toLocalizedDigits(lang)}-${entry.losses.toLocalizedDigits(lang)}',
                points: entry.points.toLocalizedDigits(lang),
                isMyTeam: myTeamIds.contains(entry.teamId),
              ),
            ),
        ],
      ),
    );
  }
}
