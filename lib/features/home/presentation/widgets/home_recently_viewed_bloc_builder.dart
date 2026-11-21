import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/section_header_widget.dart';
import '../../../explore/data/models/explore_venue_card_model.dart';
import '../cubit/recently_viewed_cubit.dart';
import 'home_nearby_pitch_card_widget.dart';

/// Venues the player opened lately, hidden when there are none.
class HomeRecentlyViewedBlocBuilder extends StatelessWidget {
  const HomeRecentlyViewedBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final padding = EdgeInsets.symmetric(horizontal: 16.w);
    final cubit = context.read<RecentlyViewedCubit>();

    return BlocBuilder<RecentlyViewedCubit, List<ExploreVenueCardModel>>(
      builder: (context, venues) {
        if (venues.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            hSpace(18),
            Padding(
              padding: padding,
              child: SectionHeaderWidget(
                title: 'home.recently_viewed'.tr(context: context),
                actionText: 'home.clear'.tr(context: context),
                actionColor: AppColors.redText,
                onAction: () {
                  HapticFeedback.lightImpact();
                  cubit.clear();
                },
              ),
            ),
            hSpace(12),
            SizedBox(
              height: 187.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: padding,
                clipBehavior: Clip.none,
                itemCount: venues.length,
                separatorBuilder: (_, _) => vSpace(12),
                itemBuilder: (context, index) {
                  final venue = venues[index];
                  final next = venue.nextAvailableStartUtc;
                  final isAvailableNow =
                      next != null &&
                      CairoTime.parseUtc(next).isBefore(
                        DateTime.now().toUtc().add(const Duration(hours: 1)),
                      );
                  return Align(
                    alignment: AlignmentDirectional.topStart,
                    child: HomeNearbyPitchCardWidget(
                      imageUrl: venue.coverPhotoUrl,
                      name: venue.name,
                      isAvailableNow: isAvailableNow,
                      price: venue.fromHourlyPrice == null
                          ? ''
                          : 'common.price_egp'.tr(
                              context: context,
                              args: [
                                venue.fromHourlyPrice!
                                    .round()
                                    .toLocalizedDigits(lang),
                              ],
                            ),
                      dist: [venue.area, venue.city].join(' · '),
                      slot: next == null
                          ? 'home.no_slots_soon'.tr(context: context)
                          : 'explore.next_available'.tr(
                              context: context,
                              args: [
                                CairoTime.dayAndTime(
                                  CairoTime.parseUtc(next),
                                  lang,
                                ),
                              ],
                            ),
                      onTap: () async {
                        await Navigator.of(context).pushNamed(
                          AppRoutes.venueProfile,
                          arguments: venue.venueId,
                        );
                        await cubit.load();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
