import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../widgets/explore_list_bloc_builder.dart';
import '../widgets/explore_quick_filters_widget.dart';
import '../widgets/explore_search_summary_widget.dart';
import '../widgets/explore_view_toggle_widget.dart';

class ExploreListScreen extends HookWidget {
  const ExploreListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = useState(<String>{'0'});

    void openPitchAndTime(String venueId) => Navigator.of(
      context,
    ).pushNamed(AppRoutes.pitchAndTime, arguments: venueId);

    void toggleFavorite(String id) {
      final next = {...favorites.value};
      if (!next.remove(id)) next.add(id);
      favorites.value = next;
    }

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'explore.results_count'.tr(context: context, args: ['٢']),
                    style: AppTextStyles.font13Regular,
                  ),
                  const ExploreViewToggleWidget(isMap: false),
                ],
              ),
            ),
            Expanded(
              child: ExploreListBlocBuilder(
                favorites: favorites.value,
                onFavoriteTap: toggleFavorite,
                onSlotTap: openPitchAndTime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
