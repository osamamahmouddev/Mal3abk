import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../cubit/pitch_slot_filter.dart';
import 'pitch_slot_legend_item_widget.dart';

/// Color key under the slot grid; each entry also filters the grid.
class PitchSlotLegendWidget extends StatelessWidget {
  const PitchSlotLegendWidget({
    required this.activeFilter,
    required this.onSelect,
    super.key,
  });

  final PitchSlotFilter activeFilter;
  final ValueChanged<PitchSlotFilter> onSelect;

  @override
  Widget build(BuildContext context) {
    void select(PitchSlotFilter filter) {
      HapticFeedback.selectionClick();
      onSelect(filter);
    }

    return Row(
      children: [
        PitchSlotLegendItemWidget(
          label: 'explore.slots.legend_selected'.tr(context: context),
          swatchColor: AppColors.brandNavy,
          isActive: activeFilter == PitchSlotFilter.selected,
          onTap: () => select(PitchSlotFilter.selected),
        ),
        vSpace(4),
        PitchSlotLegendItemWidget(
          label: 'explore.slots.legend_available'.tr(context: context),
          swatchColor: AppColors.white,
          swatchBorderColor: AppColors.borderInput,
          isActive: activeFilter == PitchSlotFilter.available,
          onTap: () => select(PitchSlotFilter.available),
        ),
        vSpace(4),
        PitchSlotLegendItemWidget(
          label: 'explore.slots.booked'.tr(context: context),
          swatchColor: AppColors.lightSurface,
          swatchBorderColor: AppColors.lightSurfaceDeep,
          isActive: activeFilter == PitchSlotFilter.booked,
          onTap: () => select(PitchSlotFilter.booked),
        ),
      ],
    );
  }
}
