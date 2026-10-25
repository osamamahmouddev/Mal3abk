import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../widgets/team_member_tile_widget.dart';
import '../widgets/team_stat_box_widget.dart';

class TeamProfileScreen extends StatelessWidget {
  const TeamProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            backgroundColor: AppColors.brandNavy,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_rounded, color: AppColors.white),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.brandNavy,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 36.r,
                        backgroundColor: AppColors.white,
                        child: Text(
                          'نج',
                          style: AppTextStyles.font22Bold.copyWith(
                            color: AppColors.brandNavy,
                          ),
                        ),
                      ),
                      hSpace(8),
                      Text('فريق النجوم', style: AppTextStyles.font20Bold.copyWith(color: AppColors.white)),
                      Text(
                        'مدينة نصر · الكابتن: أحمد سامي',
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCardWidget(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TeamStatBoxWidget(
                          value: '٢٢',
                          label: 'teams.played_matches'.tr(context: context),
                        ),
                        TeamStatBoxWidget(
                          value: '١٤',
                          label: 'teams.wins'.tr(context: context),
                        ),
                        TeamStatBoxWidget(
                          value: '#٤',
                          label: 'teams.rank'.tr(context: context),
                        ),
                      ],
                    ),
                  ),
                  hSpace(16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'teams.invite_players_title'.tr(context: context),
                          type: CustomButtonType.secondary,
                          height: 46.h,
                          onTap: () => Navigator.of(context).pushNamed(AppRoutes.invitePlayers),
                        ),
                      ),
                      vSpace(10),
                      Expanded(
                        child: CustomButton(
                          text: 'matches.challenge_team_title'.tr(context: context),
                          type: CustomButtonType.primary,
                          height: 46.h,
                          onTap: () => Navigator.of(context).pushNamed(AppRoutes.challengeTeam),
                        ),
                      ),
                    ],
                  ),
                  hSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'teams.team_members'.tr(context: context),
                        style: AppTextStyles.font16Bold,
                      ),
                      CustomButton(
                        text: 'common.edit'.tr(context: context),
                        type: CustomButtonType.ghost,
                        onTap: () => Navigator.of(context).pushNamed(AppRoutes.manageMembers),
                      ),
                    ],
                  ),
                  const TeamMemberTileWidget(name: 'أحمد سامي', role: 'كابتن · وسط', isCaptain: true),
                  const TeamMemberTileWidget(name: 'محمد علي', role: 'مدافع', isCaptain: false),
                  const TeamMemberTileWidget(name: 'كريم محمود', role: 'حارس مرمى', isCaptain: false),
                  const TeamMemberTileWidget(name: 'عمر خالد', role: 'مهاجم', isCaptain: false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
