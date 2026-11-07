import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/empty_note_box_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../data/models/located_home_feed_model.dart';
import '../cubit/home_feed_cubit.dart';
import '../cubit/home_feed_state.dart';
import 'home_nearby_pitch_card_widget.dart';

class HomeNearbyPitchesBlocBuilder extends StatelessWidget {
  const HomeNearbyPitchesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final padding = EdgeInsets.symmetric(horizontal: 16.w);

    return BlocBuilder<HomeFeedCubit, HomeFeedState>(
      builder: (context, state) => switch (state) {
        HomeFeedSuccess(located: LocatedHomeFeedModel(:final feed))
            when feed.nearby.items.isNotEmpty =>
          SizedBox(
            height: 187.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: padding,
              clipBehavior: Clip.none,
              itemCount: feed.nearby.items.length,
              separatorBuilder: (_, _) => vSpace(12),
              itemBuilder: (context, index) {
                final venue = feed.nearby.items[index];
                final next = venue.nextAvailableStartUtc;
                return Align(
                  alignment: AlignmentDirectional.topStart,
                  child: HomeNearbyPitchCardWidget(
                    imageUrl: venue.coverPhotoUrl,
                    name: venue.name,
                    price: venue.fromHourlyPrice == null
                        ? ''
                        : 'common.price_egp'.tr(
                            context: context,
                            args: [
                              venue.fromHourlyPrice!.round().toLocalizedDigits(
                                lang,
                              ),
                            ],
                          ),
                    dist: [
                      venue.area,
                      if (venue.pitchTypes.isNotEmpty)
                        venue.pitchTypes.join(' · '),
                    ].join(' · '),
                    slot: next == null
                        ? 'home.no_slots_soon'.tr(context: context)
                        : 'explore.next_available'.tr(
                            context: context,
                            args: [
                              CairoTime.dayAndTime(DateTime.parse(next), lang),
                            ],
                          ),
                    onTap: () => Navigator.of(context).pushNamed(
                      AppRoutes.venueProfile,
                      arguments: venue.venueId,
                    ),
                  ),
                );
              },
            ),
          ),
        HomeFeedSuccess() => Padding(
          padding: padding,
          child: EmptyNoteBoxWidget(
            text: 'home.no_nearby'.tr(context: context),
          ),
        ),
        HomeFeedError(:final message) => Padding(
          padding: padding,
          child: EmptyNoteBoxWidget(text: message.tr(context: context)),
        ),
        _ => ShimmerListSkeletonWidget(
          itemHeight: 160,
          itemCount: 1,
          padding: padding,
        ),
      },
    );
  }
}
