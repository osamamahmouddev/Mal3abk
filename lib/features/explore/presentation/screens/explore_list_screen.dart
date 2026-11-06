import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../widgets/explore_list_bloc_builder.dart';
import '../widgets/explore_results_count_bloc_builder.dart';
import '../widgets/explore_quick_filters_widget.dart';
import '../widgets/explore_search_summary_widget.dart';
import '../widgets/explore_view_toggle_widget.dart';

class ExploreListScreen extends StatelessWidget {
  const ExploreListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void openPitchAndTime(String venueId) => Navigator.of(
      context,
    ).pushNamed(AppRoutes.pitchAndTime, arguments: venueId);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 10.h),
              child: const ExploreSearchSummaryWidget(),
            ),
            const ExploreQuickFiltersWidget(),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ExploreResultsCountBlocBuilder(),
                  ExploreViewToggleWidget(isMap: false),
                ],
              ),
            ),
            Expanded(
              child: ExploreListBlocBuilder(onSlotTap: openPitchAndTime),
            ),
          ],
        ),
      ),
    );
  }
}
