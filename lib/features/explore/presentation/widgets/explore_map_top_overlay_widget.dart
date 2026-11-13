import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../data/models/explore_filter_model.dart';
import '../cubit/explore_map_cubit.dart';
import '../cubit/explore_map_state.dart';
import 'explore_map_pill_widget.dart';
import 'explore_search_summary_widget.dart';
import 'explore_view_toggle_widget.dart';

class ExploreMapTopOverlayWidget extends StatelessWidget {
  const ExploreMapTopOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final cubit = context.read<ExploreMapCubit>();

    return BlocBuilder<ExploreMapCubit, ExploreMapState>(
      builder: (context, state) {
        final ready = state is ExploreMapReady ? state : null;
        final notice = switch (ready) {
          ExploreMapReady(tooWide: true) => 'explore.map.zoom_in',
          ExploreMapReady(truncated: true) => 'explore.map.truncated',
          ExploreMapReady(:final failure?) => failure,
          _ => null,
        };
        return Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
          child: Column(
            children: [
              ExploreSearchSummaryWidget(
                floating: true,
                titleKey: ready?.hasMyLocation == true
                    ? 'explore.summary_near'
                    : 'explore.summary_all',
                subtitleKey: 'explore.map.subtitle',
                activeFilters: cubit.filter.activeCount,
                onOpenFilters: () async {
                  final next = await Navigator.of(context).pushNamed(
                    AppRoutes.filtersAndSort,
                    arguments: (cubit.filter, false),
                  );
                  if (next is ExploreFilterModel) await cubit.applyFilter(next);
                },
              ),
              hSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ExploreViewToggleWidget(isMap: true),
                  if (ready != null)
                    ExploreMapPillWidget(
                      label: ready.searching
                          ? 'explore.map.searching'.tr(context: context)
                          : 'explore.map.count'.tr(
                              context: context,
                              args: [ready.pins.length.toLocalizedDigits(lang)],
                            ),
                    ),
                ],
              ),
              if (notice != null) ...[
                hSpace(16),
                ExploreMapPillWidget(
                  label: notice.tr(context: context),
                  dark: true,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
