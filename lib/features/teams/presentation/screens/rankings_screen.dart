import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../widgets/team_rank_card_widget.dart';

class RankingsScreen extends StatelessWidget {
  const RankingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'teams.rankings_title'.tr(context: context),
        subtitle: 'مدينة نصر والقاهرة',
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          children: const [
            TeamRankCardWidget(rank: 1, teamName: 'فريق الفراعنة', record: '٢٨ فوز · ٠ خسارة', points: '٨٤ نقطة', isFirst: true),
            TeamRankCardWidget(rank: 2, teamName: 'نسور الدلتا', record: '٢٤ فوز · ٢ خسارة', points: '٧٤ نقطة', isFirst: false),
            TeamRankCardWidget(rank: 3, teamName: 'فريق الأبطال', record: '٢٠ فوز · ٤ خسارة', points: '٦٤ نقطة', isFirst: false),
            TeamRankCardWidget(rank: 4, teamName: 'فريق النجوم (فريقك)', record: '١٤ فوز · ٥ خسارة', points: '٤٥ نقطة', isFirst: false, isMyTeam: true),
            TeamRankCardWidget(rank: 5, teamName: 'الصقور', record: '١٢ فوز · ٦ خسارة', points: '٤٠ نقطة', isFirst: false),
          ],
        ),
      ),
    );
  }
}
