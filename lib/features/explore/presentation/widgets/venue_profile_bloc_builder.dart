import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/tab_content_switcher_widget.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../../../core/widgets/custom_tab_bar_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../cubit/favorite_toggle_cubit.dart';
import '../screens/pitch_and_time_screen.dart';
import '../cubit/favorite_toggle_state.dart';
import '../cubit/venue_profile_cubit.dart';
import '../cubit/venue_profile_state.dart';
import 'venue_amenities_tab_widget.dart';
import 'venue_hero_actions_widget.dart';
import 'venue_hero_widget.dart';
import 'venue_info_header_widget.dart';
import 'venue_offer_banner_widget.dart';
import 'venue_pitches_tab_widget.dart';
import 'venue_policies_tab_widget.dart';
import 'venue_price_footer_widget.dart';
import '../../../../core/animations/ball_refresh_indicator.dart';

class VenueProfileBlocBuilder extends StatelessWidget {
  const VenueProfileBlocBuilder({
    required this.venueId,
    required this.selectedTab,
    required this.onTabSelected,
    super.key,
  });

  final String venueId;
  final int selectedTab;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;

    return BlocListener<FavoriteToggleCubit, FavoriteToggleState>(
      listenWhen: (_, current) => current.failure != null,
      listener: (context, state) => AppTopSnackBar.showError(
        context,
        state.failure!.tr(context: context),
      ),
      child: BlocBuilder<VenueProfileCubit, VenueProfileState>(
        builder: (context, state) => switch (state) {
          VenueProfileSuccess(
            :final venue,
            :final pitches,
            :final isFavorite,
          ) =>
            () {
              void book([int pitchIndex = 0]) =>
                  Navigator.of(context).pushNamed(
                    AppRoutes.pitchAndTime,
                    arguments: PitchAndTimeArgs(
                      venueId: venueId,
                      venueName: venue.name,
                      pitchIndex: pitchIndex,
                    ),
                  );
              return Scaffold(
                backgroundColor: AppColors.pageBackground,
                bottomNavigationBar: VenuePriceFooterWidget(
                  price: venue.fromHourlyPrice == null
                      ? ''
                      : 'common.price_egp'.tr(
                          context: context,
                          args: [
                            (venue.offer?.fromHourlyPriceAfter ??
                                    venue.fromHourlyPrice!)
                                .round()
                                .toLocalizedDigits(lang),
                          ],
                        ),
                  onTap: book,
                ),
                body: Stack(
                  children: [
                    BallRefreshIndicator(
                      onRefresh: () =>
                          context.read<VenueProfileCubit>().loadVenue(venueId),
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: EdgeInsets.only(bottom: 16.h),
                        children: [
                          VenueHeroWidget(
                            venueId: venue.venueId,
                            photos: venue.photos,
                            onDoubleTapLike: () {
                              final favorites = context
                                  .read<FavoriteToggleCubit>();
                              if (!favorites.isFavorite(
                                venueId,
                                loaded: isFavorite,
                              )) {
                                favorites.toggle(venueId, loaded: isFavorite);
                              }
                            },
                          ),
                          VenueInfoHeaderWidget(
                            name: venue.name,
                            address: [
                              venue.address,
                              venue.area,
                            ].where((p) => p.isNotEmpty).join('، '),
                          ),
                          if (venue.offer case final offer?)
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
                              child: VenueOfferBannerWidget(
                                offer: offer,
                                fromHourlyPrice: venue.fromHourlyPrice,
                              ),
                            ),
                          CustomTabBarWidget(
                            tabs: [
                              'explore.venue.tab_pitches'.tr(context: context),
                              'explore.venue.tab_amenities'.tr(
                                context: context,
                              ),
                              'explore.venue.tab_policies'.tr(context: context),
                            ],
                            selectedIndex: selectedTab,
                            onTabSelected: onTabSelected,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                            child: TabContentSwitcherWidget(
                              index: selectedTab,
                              child: switch (selectedTab) {
                                1 => VenueAmenitiesTabWidget(
                                  facilities: venue.facilities,
                                ),
                                2 => VenuePoliciesTabWidget(
                                  policy: venue.depositPolicy,
                                ),
                                _ => VenuePitchesTabWidget(
                                  pitches: pitches,
                                  onPitchTap: book,
                                ),
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    VenueHeroActionsWidget(
                      venueId: venue.venueId,
                      loadedIsFavorite: isFavorite,
                    ),
                  ],
                ),
              );
            }(),
          VenueProfileError(:final message) => Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: CustomAppBarWidget(
              title: 'explore.venue.title'.tr(context: context),
            ),
            body: CustomStateWidget(
              title: message.tr(context: context),
              description: '',
              actionText: 'common.retry'.tr(context: context),
              onActionTap: () =>
                  context.read<VenueProfileCubit>().loadVenue(venueId),
            ),
          ),
          _ => const Scaffold(
            backgroundColor: AppColors.pageBackground,
            body: ShimmerListSkeletonWidget(itemHeight: 200, itemCount: 3),
          ),
        },
      ),
    );
  }
}
