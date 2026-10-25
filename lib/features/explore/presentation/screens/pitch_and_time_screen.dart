import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/price_action_footer_widget.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';
import '../widgets/pitch_day_selector_widget.dart';
import '../widgets/pitch_duration_selector_widget.dart';
import '../widgets/pitch_slot_legend_widget.dart';
import '../widgets/pitch_time_grid_widget.dart';

class PitchAndTimeScreen extends HookWidget {
  const PitchAndTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDay = useState(0);
    final selectedPitch = useState(0);
    final selectedSlot = useState('t8');

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'explore.slots.title'.tr(context: context),
        subtitle: 'explore.venue.name'.tr(context: context),
      ),
      bottomNavigationBar: PriceActionFooterWidget(
        caption: 'explore.slots.summary'.tr(context: context),
        price: 'explore.sample1_price'.tr(context: context),
        ctaText: 'explore.slots.continue'.tr(context: context),
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.bookingReview),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
        children: [
          PitchDaySelectorWidget(
            selectedIndex: selectedDay.value,
            onSelect: (index) => selectedDay.value = index,
          ),
          hSpace(16),
          Row(
            children: [
              for (var i = 0; i < 2; i++) ...[
                if (i > 0) vSpace(8),
                Expanded(
                  child: SelectableTileWidget(
                    title: 'explore.slots.pitch${i + 1}'.tr(context: context),
                    subtitle: 'explore.slots.price_${i == 0 ? 150 : 220}'
                        .tr(context: context),
                    subtitleStyle: AppTextStyles.font12Regular,
                    subtitleOpacity: 0.85,
                    boldTitle: true,
                    isSelected: selectedPitch.value == i,
                    onTap: () => selectedPitch.value = i,
                    height: 58,
                    borderRadius: 12,
                  ),
                ),
              ],
            ],
          ),
          hSpace(16),
          Text(
            'explore.slots.section'.tr(context: context),
            style: AppTextStyles.font15Bold,
          ),
          hSpace(14),
          PitchTimeGridWidget(
            selectedKey: selectedSlot.value,
            onSelect: (key) => selectedSlot.value = key,
          ),
          hSpace(12),
          const PitchSlotLegendWidget(),
          hSpace(24),
          Text(
            'explore.slots.duration'.tr(context: context),
            style: AppTextStyles.font15Bold,
          ),
          hSpace(12),
          const PitchDurationSelectorWidget(),
        ],
      ),
    );
  }
}
