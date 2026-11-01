import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import 'team_profile_hero_widget.dart';
import 'team_profile_variant.dart';
import 'team_stats_grid_widget.dart';

class TeamProfileHeaderSectionWidget extends StatelessWidget {
  const TeamProfileHeaderSectionWidget({required this.variant, super.key});

  final TeamProfileVariant variant;

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'teams.$key'.tr(context: context);

    final hero = switch (variant) {
      TeamProfileVariant.mine => TeamProfileHeroWidget(
        initials: t('sample.nogoum_i'),
        avatarColor: AppColors.brandRed,
        name: t('profile.mine_name'),
        meta: t('profile.mine_meta'),
        badgeText: t('profile.mine_rank'),
      ),
      TeamProfileVariant.other => TeamProfileHeroWidget(
        initials: t('sample.soqour_i'),
        avatarColor: AppColors.white,
        avatarTextColor: AppColors.brandNavy,
        name: t('profile.other_name'),
        meta: t('profile.other_meta'),
        badgeText: t('profile.other_rank'),
      ),
      TeamProfileVariant.fresh => TeamProfileHeroWidget(
        initials: t('sample.raad_i'),
        avatarColor: AppColors.mapUserDot,
        name: t('profile.new_name'),
        meta: t('profile.new_meta'),
        badgeText: t('profile.new_rank'),
        rankedBadge: false,
      ),
    };

    final stats = switch (variant) {
      TeamProfileVariant.mine => const TeamStatsGridWidget(
        wins: '١٤',
        draws: '٣',
        losses: '٥',
        goalsFor: '٦٨',
        goalsAgainst: '٤١',
        winRate: '٦٤٪',
      ),
      TeamProfileVariant.other => const TeamStatsGridWidget(
        wins: '١٨',
        draws: '٣',
        losses: '٤',
        goalsFor: '٧٩',
        goalsAgainst: '٤٤',
        winRate: '٧٢٪',
      ),
      TeamProfileVariant.fresh => const TeamStatsGridWidget(
        wins: '٠',
        draws: '٠',
        losses: '٠',
        goalsFor: '٠',
        goalsAgainst: '٠',
        winRate: '—',
      ),
    };

    return Column(
      children: [
        hero,
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
          child: stats,
        ),
      ],
    );
  }
}
