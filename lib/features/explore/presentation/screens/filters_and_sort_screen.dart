import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../data/models/explore_filter_model.dart';
import '../widgets/filter_reference_sections_bloc_builder.dart';
import '../widgets/filter_section_widget.dart';
import '../widgets/filters_footer_widget.dart';

/// Edits a copy of the explore filters and returns it when applied.
class FiltersAndSortScreen extends HookWidget {
  const FiltersAndSortScreen({
    required this.initial,
    required this.hasLocation,
    super.key,
  });

  final ExploreFilterModel initial;

  /// Nearest-first only makes sense when the list knows where the player is.
  final bool hasLocation;

  @override
  Widget build(BuildContext context) {
    final filter = useState(initial);
    final lang = context.locale.languageCode;
    String t(String key) => 'explore.filters.$key'.tr(context: context);
    void clear() => filter.value = ExploreFilterModel(
      sort: hasLocation
          ? ExploreSortOption.distance
          : ExploreSortOption.popularity,
    );
    final current = filter.value;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBarWidget(
        title: t('title'),
        isClose: true,
        actions: [
          GestureDetector(
            onTap: clear,
            child: Text(
              t('clear'),
              style: AppTextStyles.font14SemiBold.copyWith(
                color: AppColors.redText,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FiltersFooterWidget(
        onClear: clear,
        onApply: () => Navigator.of(context).pop(filter.value),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 5.h, 16.w, 16.h),
        children: [
          FilterSectionWidget(
            title: t('sort'),
            options: [
              for (final option in ExploreSortOption.values)
                if (hasLocation || option != ExploreSortOption.distance)
                  (option.name, t('sort_${option.name}')),
            ],
            selected: {current.sort.name},
            onToggle: (name) => filter.value = current.copyWith(
              sort: ExploreSortOption.values.byName(name),
            ),
          ),
          FilterSectionWidget(
            title: t('time'),
            hint: t('time_hint'),
            options: [
              for (final window in ExploreTimeWindow.values)
                (window.name, t('time_${window.name}')),
            ],
            selected: {?current.timeWindow?.name},
            onToggle: (name) => filter.value = current.copyWith(
              timeWindow: () => current.timeWindow?.name == name
                  ? null
                  : ExploreTimeWindow.values.byName(name),
            ),
          ),
          FilterSectionWidget(
            title: t('max_price'),
            options: [
              for (final cap in ExploreFilterModel.priceCaps)
                (
                  '$cap',
                  'common.price_egp'.tr(
                    context: context,
                    args: [cap.toLocalizedDigits(lang)],
                  ),
                ),
            ],
            selected: {?current.maxPrice?.toString()},
            onToggle: (value) => filter.value = current.copyWith(
              maxPrice: () => current.maxPrice?.toString() == value
                  ? null
                  : int.parse(value),
            ),
          ),
          FilterReferenceSectionsBlocBuilder(
            filter: current,
            onChanged: (next) => filter.value = next,
          ),
        ],
      ),
    );
  }
}
