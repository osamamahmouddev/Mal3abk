import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../../../core/widgets/fade_slide_in_widget.dart';
import '../../../../core/widgets/pitch_card_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../data/models/explore_venue_card_model.dart';
import '../cubit/explore_list_cubit.dart';
import '../cubit/explore_list_state.dart';
import '../cubit/favorite_toggle_cubit.dart';
import '../cubit/favorite_toggle_state.dart';

class ExploreListBlocBuilder extends StatelessWidget {
  const ExploreListBlocBuilder({required this.onSlotTap, super.key});

  final ValueChanged<String> onSlotTap;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;

    String specs(ExploreVenueCardModel item) => [
      if (item.pitchTypes.isNotEmpty)
        item.pitchTypes.join(' · ')
      else
        item.area,
      if (item.distanceKm case final km?)
        'explore.distance_km'.tr(
          context: context,
          namedArgs: {
            'dist': lang == 'ar'
                ? km.toStringAsFixed(1).toArabicDigits()
                : km.toStringAsFixed(1),
          },
        ),
    ].join(' · ');

    return BlocListener<FavoriteToggleCubit, FavoriteToggleState>(
      listenWhen: (_, current) => current.failure != null,
      listener: (context, state) => AppTopSnackBar.showError(
        context,
        state.failure!.tr(context: context),
      ),
      child: BlocBuilder<ExploreListCubit, ExploreListState>(
        builder: (context, state) => switch (state) {
          ExploreListSuccess(:final result) when result.items.isEmpty =>
            CustomStateWidget(
              icon: const Icon(Icons.search_off_rounded, size: 48),
              title: 'explore.no_results_title'.tr(context: context),
              description: 'explore.no_results_desc'.tr(context: context),
            ),
          ExploreListSuccess(:final result) =>
            BlocBuilder<FavoriteToggleCubit, FavoriteToggleState>(
              builder: (context, _) {
                final favorites = context.read<FavoriteToggleCubit>();
                return RefreshIndicator.adaptive(
                  onRefresh: context.read<ExploreListCubit>().fetchVenues,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                    itemCount: result.items.length,
                    separatorBuilder: (_, _) => hSpace(12),
                    itemBuilder: (context, index) {
                      final item = result.items[index];
                      final next = item.nextAvailableStartUtc;
                      return FadeSlideInWidget(
                        index: index,
                        child: PitchCardWidget(
                          name: item.name,
                          specs: specs(item),
                          pricePerHour: item.fromHourlyPrice == null
                              ? ''
                              : 'common.price_egp'.tr(
                                  context: context,
                                  args: [
                                    item.fromHourlyPrice!
                                        .round()
                                        .toLocalizedDigits(lang),
                                  ],
                                ),
                          imageUrl: item.coverPhotoUrl,
                          isFavorite: favorites.isFavorite(
                            item.venueId,
                            loaded: item.isFavorite,
                          ),
                          onFavoriteTap: () {
                            HapticFeedback.lightImpact();
                            favorites.toggle(
                              item.venueId,
                              loaded: item.isFavorite,
                            );
                          },
                          availableSlots: [
                            if (next != null)
                              CairoTime.dayAndTime(DateTime.parse(next), lang),
                          ],
                          onTap: () => Navigator.of(context).pushNamed(
                            AppRoutes.venueProfile,
                            arguments: item.venueId,
                          ),
                          onSlotTap: (_) => onSlotTap(item.venueId),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ExploreListError(:final message) => CustomStateWidget(
            title: message.tr(context: context),
            description: '',
            actionText: 'common.retry'.tr(context: context),
            onActionTap: context.read<ExploreListCubit>().fetchVenues,
          ),
          _ => const ShimmerListSkeletonWidget(itemHeight: 150, itemCount: 4),
        },
      ),
    );
  }
}
