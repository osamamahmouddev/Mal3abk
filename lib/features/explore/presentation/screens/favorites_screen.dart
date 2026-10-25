import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../widgets/favorite_venue_card_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void openVenue() => Navigator.of(context).pushNamed(AppRoutes.venueProfile);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'explore.favorites_title'.tr(context: context),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
        children: [
          FavoriteVenueCardWidget(
            name: 'explore.sample1_name'.tr(context: context),
            rating: 'explore.sample1_rating'.tr(context: context),
            meta: 'explore.fav1_meta'.tr(context: context),
            priceFrom: 'explore.sample1_price'.tr(context: context),
            todaySlots: [
              'explore.slot_9pm'.tr(context: context),
              'explore.slot_11pm'.tr(context: context),
            ],
            onView: openVenue,
            onRemove: () {},
          ),
          hSpace(12),
          FavoriteVenueCardWidget(
            name: 'explore.sample2_name'.tr(context: context),
            rating: 'explore.sample2_rating'.tr(context: context),
            meta: 'explore.fav2_meta'.tr(context: context),
            priceFrom: 'explore.sample2_price'.tr(context: context),
            todaySlots: ['explore.slot_8pm'.tr(context: context)],
            onView: openVenue,
            onRemove: () {},
          ),
          hSpace(12),
          FavoriteVenueCardWidget(
            name: 'explore.sample3_name'.tr(context: context),
            rating: 'explore.sample3_rating'.tr(context: context),
            meta: 'explore.fav3_meta'.tr(context: context),
            priceFrom: 'explore.sample3_price'.tr(context: context),
            todaySlots: const [],
            onView: openVenue,
            onRemove: () {},
          ),
        ],
      ),
    );
  }
}
