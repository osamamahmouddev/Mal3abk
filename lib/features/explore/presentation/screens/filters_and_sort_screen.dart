import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../widgets/filter_section_widget.dart';
import '../widgets/filters_footer_widget.dart';

class FiltersAndSortScreen extends HookWidget {
  const FiltersAndSortScreen({super.key});

  /// (title, hint, options, allowsMultiple)
  static const List<(String, String?, List<String>, bool)> sections = [
    ('sort', null, ['sort_nearest', 'sort_cheapest', 'sort_top_rated', 'sort_soonest'], false),
    ('distance', 'distance_hint', ['dist_1', 'dist_3', 'dist_5', 'dist_10'], false),
    ('time', 'time_hint', ['time_4_7', 'time_7_10', 'time_10_1', 'time_after_1'], false),
    ('max_price', null, ['price_150', 'price_200', 'price_250'], false),
    ('size', 'size_hint', ['size_5', 'size_7', 'size_11'], true),
    ('cover', null, ['cover_open', 'cover_covered'], false),
    ('surface', null, ['surface_artificial', 'surface_natural'], false),
    (
      'amenities',
      'amenities_hint',
      ['amenity_lights', 'amenity_changing', 'amenity_shower', 'amenity_parking', 'amenity_cafe'],
      true,
    ),
    ('rating', null, ['rating_4', 'rating_45'], false),
  ];

  static const Map<String, Set<String>> defaults = {
    'sort': {'sort_nearest'},
    'distance': {'dist_3'},
    'time': {'time_7_10'},
  };

  @override
  Widget build(BuildContext context) {
    final selections = useState<Map<String, Set<String>>>(defaults);

    void toggle(String section, String option, bool multiple) {
      final current = selections.value[section] ?? const <String>{};
      final next = multiple ? {...current} : <String>{};
      if (current.contains(option)) {
        next.remove(option);
      } else {
        next.add(option);
      }
      selections.value = {...selections.value, section: next};
    }

    void clear() => selections.value = const {};

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBarWidget(
        title: 'explore.filters.title'.tr(context: context),
        isClose: true,
        actions: [
          GestureDetector(
            onTap: clear,
            child: Text(
              'explore.filters.clear'.tr(context: context),
              style: AppTextStyles.font14SemiBold.copyWith(
                color: AppColors.redText,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FiltersFooterWidget(
        resultCount: '١٦',
        onClear: clear,
        onApply: () => Navigator.of(context).maybePop(),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 5.h, 16.w, 16.h),
        children: [
          for (final (title, hint, options, multiple) in sections)
            FilterSectionWidget(
              titleKey: title,
              hintKey: hint,
              optionKeys: options,
              selected: selections.value[title] ?? const {},
              onToggle: (option) => toggle(title, option, multiple),
            ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 14.h, end: 29.w),
            child: Text(
              'explore.filters.footnote'.tr(context: context),
              style: AppTextStyles.font12Regular.copyWith(height: 19 / 12),
            ),
          ),
        ],
      ),
    );
  }
}
