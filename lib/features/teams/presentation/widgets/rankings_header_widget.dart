import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/theme/app_system_ui.dart';
import '../../../../core/widgets/app_on_dark_back_button_widget.dart';
import '../../data/models/team_leaderboard_entry_model.dart';
import 'leaderboard_filter_bloc_builder.dart';
import 'rankings_podium_column_widget.dart';

class RankingsHeaderWidget extends StatelessWidget {
  const RankingsHeaderWidget({
    required this.podium,
    required this.governorate,
    super.key,
  });

  final List<TeamLeaderboardEntryModel> podium;
  final String? governorate;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    TeamLeaderboardEntryModel? at(int index) =>
        podium.length > index ? podium[index] : null;
    String pts(TeamLeaderboardEntryModel entry) => 'teams.rankings.points'.tr(
      context: context,
      args: [entry.points.toLocalizedDigits(lang)],
    );
    const heights = [78.0, 60.0, 48.0];
    const order = [1, 0, 2];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.onDark,
      child: Container(
        color: AppColors.brandNavy,
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                AppAssets.rankingsPattern,
                fit: BoxFit.fill,
              ),
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const AppOnDarkBackButtonWidget(),
                        Expanded(
                          child: Text(
                            'teams.rankings.title'.tr(context: context),
                            textAlign: TextAlign.center,
                            style: AppTextStyles.font18Bold.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        vSpace(44),
                      ],
                    ),
                    hSpace(14),
                    LeaderboardFilterBlocBuilder(selected: governorate),
                    hSpace(14),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (final (i, index) in order.indexed) ...[
                          if (i > 0) vSpace(8),
                          Expanded(
                            child: switch (at(index)) {
                              final entry? => RankingsPodiumColumnWidget(
                                initials: entry.name.initials,
                                name: entry.name,
                                rank: entry.rank.toLocalizedDigits(lang),
                                points: pts(entry),
                                blockHeight: heights[index],
                                isWinner: index == 0,
                              ),
                              null => const SizedBox.shrink(),
                            },
                          ),
                        ],
                      ],
                    ),
                    hSpace(18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
