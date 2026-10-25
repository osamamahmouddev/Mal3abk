import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import 'home_nearby_pitch_card_widget.dart';

class HomeNearbyPitchesCarouselWidget extends StatelessWidget {
  const HomeNearbyPitchesCarouselWidget({super.key});

  static const List<String> venueKeys = ['sample_venue1', 'sample_venue2'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 187.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        clipBehavior: Clip.none,
        itemCount: venueKeys.length,
        separatorBuilder: (_, _) => vSpace(12),
        itemBuilder: (context, index) {
          final key = venueKeys[index];
          return Align(
            alignment: AlignmentDirectional.topStart,
            child: HomeNearbyPitchCardWidget(
              name: 'home.${key}_name'.tr(context: context),
              rating: 'home.${key}_rating'.tr(context: context),
              dist: 'home.${key}_dist'.tr(context: context),
              slot: 'home.sample_slot'.tr(context: context),
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.venueProfile),
            ),
          );
        },
      ),
    );
  }
}
