import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/pitch_card_widget.dart';
import '../widgets/explore_quick_filters_widget.dart';
import '../widgets/explore_search_summary_widget.dart';
import '../widgets/explore_view_toggle_widget.dart';

class ExploreListScreen extends HookWidget {
  const ExploreListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = useState(<int>{0});

    void openPitchAndTime(String _) =>
        Navigator.of(context).pushNamed(AppRoutes.pitchAndTime);

    void toggleFavorite(int index) {
      final next = {...favorites.value};
      if (!next.remove(index)) next.add(index);
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
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 26.h, 16.w, 16.h),
                children: [
                  PitchCardWidget(
                    name: 'explore.sample1_name'.tr(context: context),
                    specs: 'explore.sample1_specs'.tr(context: context),
                    pricePerHour: 'explore.sample1_price'.tr(context: context),
                    rating: 'explore.sample1_rating'.tr(context: context),
                    isFavorite: favorites.value.contains(0),
                    onFavoriteTap: () => toggleFavorite(0),
                    availableSlots: [
                      'explore.slot_8pm'.tr(context: context),
                      'explore.slot_11pm'.tr(context: context),
                      'explore.slot_12am'.tr(context: context),
                    ],
                    onTap: () =>
                        Navigator.of(context).pushNamed(AppRoutes.venueProfile),
                    onSlotTap: openPitchAndTime,
                  ),
                  hSpace(12),
                  PitchCardWidget(
                    name: 'explore.sample2_name'.tr(context: context),
                    specs: 'explore.sample2_specs'.tr(context: context),
                    pricePerHour: 'explore.sample2_price'.tr(context: context),
                    rating: 'explore.sample2_rating'.tr(context: context),
                    isFavorite: favorites.value.contains(1),
                    onFavoriteTap: () => toggleFavorite(1),
                    availableSlots: [
                      'explore.slot_8pm'.tr(context: context),
                      'explore.slot_9pm'.tr(context: context),
                    ],
                    onTap: () =>
                        Navigator.of(context).pushNamed(AppRoutes.venueProfile),
                    onSlotTap: openPitchAndTime,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
