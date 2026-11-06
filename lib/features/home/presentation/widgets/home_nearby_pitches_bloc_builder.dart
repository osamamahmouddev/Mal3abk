import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../data/models/located_home_feed_model.dart';
import '../cubit/home_feed_cubit.dart';
import '../cubit/home_feed_state.dart';
import 'home_nearby_pitch_card_widget.dart';
import 'home_nearby_pitches_carousel_widget.dart';

class HomeNearbyPitchesBlocBuilder extends StatelessWidget {
  const HomeNearbyPitchesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeFeedCubit, HomeFeedState>(
      builder: (context, state) {
        return switch (state) {
          HomeFeedLoading() => Container(
            height: 187.h,
            alignment: Alignment.center,
            child: const CircularProgressIndicator.adaptive(),
          ),
          HomeFeedSuccess(located: LocatedHomeFeedModel(:final feed)) =>
            feed.nearby.items.isNotEmpty
                ? Container(
                    height: 187.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      clipBehavior: Clip.none,
                      itemCount: feed.nearby.items.length,
                      separatorBuilder: (_, _) => hSpace(12),
                      itemBuilder: (context, index) {
                        final venue = feed.nearby.items[index];
                        final pitchTypes = venue.pitchTypes.isNotEmpty
                            ? venue.pitchTypes.join(' · ')
                            : venue.area;
                        final distText = venue.distanceKm != null
                            ? '${venue.distanceKm!.toStringAsFixed(1)} كم · $pitchTypes'
                            : '${venue.area} · $pitchTypes';
                        final slotText = venue.nextAvailableStartUtc != null
                            ? 'متاح اليوم'
                            : 'home.sample_slot'.tr(context: context);
                        const ratingText = '4.8';

                        return Align(
                          alignment: AlignmentDirectional.topStart,
                          child: HomeNearbyPitchCardWidget(
                            name: venue.name,
                            rating: ratingText,
                            dist: distText,
                            slot: slotText,
                            onTap: () => Navigator.of(context).pushNamed(
                              AppRoutes.venueProfile,
                              arguments: venue.venueId,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const HomeNearbyPitchesCarouselWidget(),
          _ => const HomeNearbyPitchesCarouselWidget(),
        };
      },
    );
  }
}
