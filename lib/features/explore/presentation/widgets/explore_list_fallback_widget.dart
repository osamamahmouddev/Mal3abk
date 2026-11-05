import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/fade_slide_in_widget.dart';
import '../../../../core/widgets/pitch_card_widget.dart';

class ExploreListFallbackWidget extends StatelessWidget {
  const ExploreListFallbackWidget({
    required this.favorites,
    required this.onFavoriteTap,
    required this.onSlotTap,
    super.key,
  });

  final Set<String> favorites;
  final ValueChanged<String> onFavoriteTap;
  final ValueChanged<String> onSlotTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 26.h, 16.w, 16.h),
      children: [
        FadeSlideInWidget(
          child: PitchCardWidget(
            name: 'explore.sample1_name'.tr(context: context),
            specs: 'explore.sample1_specs'.tr(context: context),
            pricePerHour: 'explore.sample1_price'.tr(context: context),
            rating: 'explore.sample1_rating'.tr(context: context),
            isFavorite: favorites.contains('0'),
            onFavoriteTap: () => onFavoriteTap('0'),
            availableSlots: [
              'explore.slot_8pm'.tr(context: context),
              'explore.slot_11pm'.tr(context: context),
              'explore.slot_12am'.tr(context: context),
            ],
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.venueProfile),
            onSlotTap: onSlotTap,
          ),
        ),
        vSpace(12),
        FadeSlideInWidget(
          index: 1,
          child: PitchCardWidget(
            name: 'explore.sample2_name'.tr(context: context),
            specs: 'explore.sample2_specs'.tr(context: context),
            pricePerHour: 'explore.sample2_price'.tr(context: context),
            rating: 'explore.sample2_rating'.tr(context: context),
            isFavorite: favorites.contains('1'),
            onFavoriteTap: () => onFavoriteTap('1'),
            availableSlots: [
              'explore.slot_8pm'.tr(context: context),
              'explore.slot_9pm'.tr(context: context),
            ],
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.venueProfile),
            onSlotTap: onSlotTap,
          ),
        ),
      ],
    );
  }
}
