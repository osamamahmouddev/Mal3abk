import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/extensions/place_name_extension.dart';
import '../../../../core/styles/app_colors.dart';
import '../../data/models/team_profile_model.dart';
import 'team_profile_hero_widget.dart';
import 'team_stats_grid_widget.dart';

class TeamProfileHeaderSectionWidget extends StatelessWidget {
  const TeamProfileHeaderSectionWidget({required this.profile, super.key});

  final TeamProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final stats = profile.stats;
    final captain = profile.roster.where((m) => m.isCaptain).firstOrNull;
    final ranked = stats.rank > 0;

    return Column(
      children: [
        TeamProfileHeroWidget(
          initials: profile.name.initials,
          avatarColor: profile.isCallerMember
              ? AppColors.brandRed
              : AppColors.white,
          avatarTextColor: profile.isCallerMember
              ? AppColors.white
              : AppColors.brandNavy,
          name: profile.name,
          meta: 'teams.profile.meta'.tr(
            context: context,
            args: [
              context.placeName(city: profile.city, area: profile.district),
              captain?.playerName ?? '—',
              profile.roster.length.toLocalizedDigits(lang),
            ],
          ),
          badgeText: ranked
              ? 'teams.profile.rank_badge'.tr(
                  context: context,
                  args: [
                    stats.rank.toLocalizedDigits(lang),
                    profile.governorate,
                  ],
                )
              : 'teams.profile.unranked'.tr(context: context),
          rankedBadge: ranked,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
          child: TeamStatsGridWidget(
            wins: stats.wins.toLocalizedDigits(lang),
            draws: stats.draws.toLocalizedDigits(lang),
            losses: stats.losses.toLocalizedDigits(lang),
            goalsFor: stats.goalsFor.toLocalizedDigits(lang),
            goalsAgainst: stats.goalsAgainst.toLocalizedDigits(lang),
            winRate: '${stats.winPercentage.round().toLocalizedDigits(lang)}٪',
          ),
        ),
      ],
    );
  }
}
