import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/plain_note_box_widget.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';
import '../widgets/rankings_header_widget.dart';
import '../widgets/rankings_table_widget.dart';

class RankingsScreen extends HookWidget {
  const RankingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final period = useState(0);
    final periods = [
      'teams.rankings.july'.tr(context: context),
      'teams.rankings.all_time'.tr(context: context),
    ];

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: ListView(
        padding: EdgeInsets.only(bottom: 24.h),
        children: [
          const RankingsHeaderWidget(),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    for (var i = 0; i < periods.length; i++) ...[
                      if (i > 0) vSpace(8),
                      SelectableTileWidget(
                        title: periods[i],
                        isSelected: period.value == i,
                        onTap: () => period.value = i,
                        height: 36,
                        borderRadius: 18,
                        horizontalPadding: 10,
                        titleStyle: AppTextStyles.font14SemiBold,
                      ),
                    ],
                  ],
                ),
                hSpace(10),
                const RankingsTableWidget(),
                hSpace(10),
                PlainNoteBoxWidget(
                  text: 'teams.rankings.note'.tr(context: context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
