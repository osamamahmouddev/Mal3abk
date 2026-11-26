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

/// The leaderboard below the podium. The column titles stay pinned at the top
/// of the card while only the team rows (and the [footer]) scroll under them.
class RankingsTableWidget extends StatelessWidget {
  const RankingsTableWidget({
    required this.entries,
    required this.myTeamIds,
    super.key,
    this.footer,
  });

  final List<TeamLeaderboardEntryModel> entries;
  final Set<String> myTeamIds;

  /// Shown after the last row, inside the scrolling part.
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    String t(String key) => 'teams.rankings.$key'.tr(context: context);
    final headStyle = AppTextStyles.font11Regular.copyWith(
      fontWeight: FontWeight.w600,
    );
    final footer = this.footer;

    return CustomCardWidget(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  Expanded(
                    flex: 5,
                    child: Text(t('col_team'), style: headStyle),
                  ),
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
            // Takes only what the rows need, and scrolls once they no longer
            // fit under the pinned titles.
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: entries.length + (footer == null ? 0 : 1),
                itemBuilder: (context, i) {
                  if (i == entries.length) {
                    return Padding(
                      padding: EdgeInsets.all(12.r),
                      child: footer,
                    );
                  }
                  final entry = entries[i];
                  return InkWell(
                    onTap: () => Navigator.of(
                      context,
                    ).pushNamed(AppRoutes.teamProfile, arguments: entry.teamId),
                    child: TeamRankCardWidget(
                      rank: entry.rank.toLocalizedDigits(lang),
                      teamName: entry.name,
                      initials: entry.name.initials,
                      logoUrl: entry.logoUrl,
                      trend: entry.city,
                      record:
                          '${entry.wins.toLocalizedDigits(lang)}-${entry.draws.toLocalizedDigits(lang)}-${entry.losses.toLocalizedDigits(lang)}',
                      points: entry.points.toLocalizedDigits(lang),
                      isMyTeam: myTeamIds.contains(entry.teamId),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
