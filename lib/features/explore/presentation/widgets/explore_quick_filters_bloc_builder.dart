import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/location/location_service.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';
import '../../data/models/explore_filter_model.dart';
import '../cubit/explore_list_cubit.dart';
import '../cubit/explore_list_state.dart';
import 'explore_filter_when_label_extension.dart';

/// One-tap shortcuts over the same filters as the filters screen.
class ExploreQuickFiltersBlocBuilder extends StatelessWidget {
  const ExploreQuickFiltersBlocBuilder({super.key});

  static const int budgetCap = 200;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    return BlocBuilder<ExploreListCubit, ExploreListState>(
      builder: (context, _) {
        final cubit = context.read<ExploreListCubit>();
        final f = cubit.filter;
        final when = f.hasPickedWhen ? f.whenLabel(context) : null;
        final nearMeOn =
            cubit.near != null && f.sort == ExploreSortOption.distance;
        final chips = [
          // The day and hour picked on the home card; tapping clears them.
          if (when != null)
            (
              when,
              true,
              () => f.copyWith(
                day: () => null,
                startHour: () => null,
                timeWindow: () => null,
              ),
            ),
          ('explore.quick.near_me'.tr(context: context), nearMeOn, null),
          (
            'explore.quick.tonight'.tr(context: context),
            f.timeWindow == ExploreTimeWindow.evening,
            () => f.copyWith(
              timeWindow: () => f.timeWindow == ExploreTimeWindow.evening
                  ? null
                  : ExploreTimeWindow.evening,
              // "Tonight" is today, whatever day was picked before.
              day: () => null,
              startHour: () => null,
            ),
          ),
          (
            'explore.quick.under'.tr(
              context: context,
              args: [budgetCap.toLocalizedDigits(lang)],
            ),
            f.maxPrice == budgetCap,
            () => f.copyWith(
              maxPrice: () => f.maxPrice == budgetCap ? null : budgetCap,
            ),
          ),
          (
            'explore.quick.cheapest'.tr(context: context),
            f.sort == ExploreSortOption.price,
            () => f.copyWith(
              sort: f.sort == ExploreSortOption.price
                  ? (cubit.near == null
                        ? ExploreSortOption.popularity
                        : ExploreSortOption.distance)
                  : ExploreSortOption.price,
            ),
          ),
        ];

        return SizedBox(
          height: 36.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: chips.length,
            separatorBuilder: (_, _) => vSpace(6),
            itemBuilder: (context, i) {
              final (label, active, next) = chips[i];
              return SelectableTileWidget(
                title: label,
                isSelected: active,
                onTap: () async {
                  HapticFeedback.selectionClick();
                  if (next != null) {
                    await cubit.applyFilter(next());
                  } else if (nearMeOn) {
                    // "Near me" toggles like the other chips.
                    await cubit.stopUsingLocation();
                  } else if (!await cubit.useMyLocation() && context.mounted) {
                    AppTopSnackBar.showInfo(
                      context,
                      'explore.quick.location_off'.tr(context: context),
                      actionLabel: 'common.settings'.tr(context: context),
                      onAction: () => const LocationService().openAppSettings(),
                    );
                  }
                },
                height: 36,
                borderRadius: 18,
                horizontalPadding: 13,
                titleStyle: AppTextStyles.font13SemiBold,
                borderColor: AppColors.chipBorder,
              );
            },
          ),
        );
      },
    );
  }
}
