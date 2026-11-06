import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../data/models/team_profile_model.dart';
import '../widgets/tactical_board_bloc_builder.dart';

class TacticalBoardScreen extends StatelessWidget {
  const TacticalBoardScreen({required this.profile, super.key});

  final TeamProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'teams.tactics.title'.tr(context: context),
        subtitle: profile.name,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
        children: [
          TacticalBoardBlocBuilder(
            names: {
              for (final member in profile.roster)
                member.playerId: member.playerName ?? '—',
            },
          ),
        ],
      ),
    );
  }
}
