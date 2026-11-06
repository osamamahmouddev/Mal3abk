import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/explore_map_cubit.dart';
import '../cubit/explore_map_state.dart';
import 'explore_map_locate_button_widget.dart';
import 'explore_map_venue_sheet_widget.dart';

/// "My location" and the selected venue's card at the bottom of the map.
class ExploreMapSelectionBlocBuilder extends StatelessWidget {
  const ExploreMapSelectionBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExploreMapCubit>();
    return BlocBuilder<ExploreMapCubit, ExploreMapState>(
      buildWhen: (previous, current) =>
          previous is! ExploreMapReady ||
          current is! ExploreMapReady ||
          previous.selected != current.selected,
      builder: (context, state) {
        final selected = state is ExploreMapReady ? state.selected : null;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(end: 4.w, bottom: 10.h),
              child: ExploreMapLocateButtonWidget(
                onTap: () async {
                  HapticFeedback.selectionClick();
                  if (await cubit.locateMe() == null && context.mounted) {
                    AppTopSnackBar.showError(
                      context,
                      'explore.quick.location_off'.tr(context: context),
                    );
                  }
                },
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: selected == null
                  ? const SizedBox.shrink()
                  : ExploreMapVenueSheetWidget(
                      key: ValueKey(selected.venueId),
                      pin: selected,
                      onClose: () => cubit.select(null),
                    ),
            ),
          ],
        );
      },
    );
  }
}
