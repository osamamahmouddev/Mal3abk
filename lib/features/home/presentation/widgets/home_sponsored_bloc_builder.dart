import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/section_header_widget.dart';
import '../../../explore/data/models/sponsored_item_model.dart';
import '../../data/models/located_home_feed_model.dart';
import '../cubit/home_feed_cubit.dart';
import '../cubit/home_feed_state.dart';
import 'home_nearby_pitch_card_widget.dart';

/// Venues the platform team is promoting on the home screen, each tagged as an
/// ad. Hidden while sponsored items are switched off or none is running.
class HomeSponsoredBlocBuilder extends StatelessWidget {
  const HomeSponsoredBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeFeedCubit, HomeFeedState>(
      builder: (context, state) {
        final items = switch (state) {
          HomeFeedSuccess(located: LocatedHomeFeedModel(:final feed)) =>
            feed.sponsored?.items ?? const <SponsoredItemModel>[],
          _ => const <SponsoredItemModel>[],
        };
        if (items.isEmpty) return const SizedBox.shrink();
        return SponsoredVenuesStripWidget(
          title: 'home.sponsored'.tr(context: context),
          items: items,
        );
      },
    );
  }
}

/// A titled, horizontally scrolling row of promoted venues (home and explore).
class SponsoredVenuesStripWidget extends StatelessWidget {
  const SponsoredVenuesStripWidget({
    required this.title,
    required this.items,
    this.sidePadding = 16,
    super.key,
  });

  final String title;
  final List<SponsoredItemModel> items;

  /// Space on each side; zero inside a list that already pads its content.
  final double sidePadding;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final padding = EdgeInsets.symmetric(horizontal: sidePadding.w);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: padding,
          child: SectionHeaderWidget(title: title),
        ),
        hSpace(12),
        SizedBox(
          height: 187.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: padding,
            clipBehavior: Clip.none,
            itemCount: items.length,
            separatorBuilder: (_, _) => vSpace(12),
            itemBuilder: (context, index) {
              final item = items[index];
              final venue = item.venue;
              final price =
                  venue.offer?.fromHourlyPriceAfter ?? venue.fromHourlyPrice;
              return Align(
                alignment: AlignmentDirectional.topStart,
                child: HomeNearbyPitchCardWidget(
                  imageUrl: venue.coverPhotoUrl,
                  name: venue.name,
                  sponsoredLabel: 'home.sponsored_badge'.tr(context: context),
                  price: price == null
                      ? ''
                      : 'common.price_egp'.tr(
                          context: context,
                          args: [price.round().toLocalizedDigits(lang)],
                        ),
                  dist: [
                    venue.area,
                    venue.city,
                  ].where((s) => s.isNotEmpty).join(' · '),
                  // The admin's promotional line, when it says more than the name.
                  slot:
                      item.title.trim().isNotEmpty &&
                          item.title.trim() != venue.name
                      ? item.title.trim()
                      : 'home.sponsored_cta'.tr(context: context),
                  onTap: () => Navigator.of(
                    context,
                  ).pushNamed(AppRoutes.venueProfile, arguments: venue.venueId),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
