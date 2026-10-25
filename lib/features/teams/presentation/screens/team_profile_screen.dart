import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../widgets/team_profile_footer_widget.dart';
import '../widgets/team_profile_header_section_widget.dart';
import '../widgets/team_profile_matches_section_widget.dart';
import '../widgets/team_profile_players_section_widget.dart';
import '../widgets/team_profile_variant.dart';

class TeamProfileScreen extends StatelessWidget {
  const TeamProfileScreen({super.key, this.variant = TeamProfileVariant.mine});

  final TeamProfileVariant variant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      bottomNavigationBar: TeamProfileFooterWidget(variant: variant),
      body: ListView(
        padding: EdgeInsets.only(bottom: 16.h),
        children: [
          TeamProfileHeaderSectionWidget(variant: variant),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TeamProfileMatchesSectionWidget(variant: variant),
                hSpace(10),
                TeamProfilePlayersSectionWidget(variant: variant),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
