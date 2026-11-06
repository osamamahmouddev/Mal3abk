import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../../reference/presentation/cubit/filter_options_cubit.dart';
import '../../../reference/presentation/cubit/filter_options_state.dart';
import '../../data/models/explore_filter_model.dart';
import 'filter_section_widget.dart';

/// Pitch type, surface and facility chips from the server's reference data.
class FilterReferenceSectionsBlocBuilder extends StatelessWidget {
  const FilterReferenceSectionsBlocBuilder({
    required this.filter,
    required this.onChanged,
    super.key,
  });

  final ExploreFilterModel filter;
  final ValueChanged<ExploreFilterModel> onChanged;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    String t(String key) => 'explore.filters.$key'.tr(context: context);

    return BlocBuilder<FilterOptionsCubit, FilterOptionsState>(
      builder: (context, state) => switch (state) {
        FilterOptionsSuccess(:final options) => Column(
          children: [
            FilterSectionWidget(
              title: t('size'),
              options: [
                for (final i in options.pitchTypes)
                  (i.code, lang == 'ar' ? i.nameAr : i.nameEn),
              ],
              selected: {?filter.pitchType},
              onToggle: (code) => onChanged(
                filter.copyWith(
                  pitchType: () => filter.pitchType == code ? null : code,
                ),
              ),
            ),
            FilterSectionWidget(
              title: t('surface'),
              options: [
                for (final i in options.surfaces)
                  (i.code, lang == 'ar' ? i.nameAr : i.nameEn),
              ],
              selected: {?filter.surface},
              onToggle: (code) => onChanged(
                filter.copyWith(
                  surface: () => filter.surface == code ? null : code,
                ),
              ),
            ),
            FilterSectionWidget(
              title: t('amenities'),
              hint: t('amenities_hint'),
              options: [
                for (final i in options.facilities)
                  (i.code, lang == 'ar' ? i.nameAr : i.nameEn),
              ],
              selected: filter.facilities,
              onToggle: (code) {
                final next = {...filter.facilities};
                if (!next.remove(code)) next.add(code);
                onChanged(filter.copyWith(facilities: next));
              },
            ),
          ],
        ),
        FilterOptionsError(:final message) => AlertBannerWidget(
          type: AlertBannerType.error,
          message: message.tr(context: context),
          actionText: 'common.retry'.tr(context: context),
          onActionTap: context.read<FilterOptionsCubit>().load,
        ),
        _ => const ShimmerListSkeletonWidget(itemHeight: 90, itemCount: 3),
      },
    );
  }
}
