import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import 'explore_map_pill_widget.dart';
import 'explore_search_summary_widget.dart';
import 'explore_view_toggle_widget.dart';

class ExploreMapTopOverlayWidget extends StatelessWidget {
  const ExploreMapTopOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      child: Column(
        children: [
          const ExploreSearchSummaryWidget(
            floating: true,
            subtitleKey: 'explore.map_summary_when',
            activeFilters: 2,
          ),
          hSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ExploreViewToggleWidget(isMap: true),
              ExploreMapPillWidget(
                label: 'explore.map_available_count'.tr(
                  context: context,
                  args: ['٤'],
                ),
              ),
            ],
          ),
          hSpace(24),
          ExploreMapPillWidget(
            label: 'explore.search_this_area'.tr(context: context),
            dark: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
