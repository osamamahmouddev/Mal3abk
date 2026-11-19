import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../../../core/widgets/fade_slide_in_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';
import 'favorite_venue_card_widget.dart';
import '../../../../core/animations/ball_refresh_indicator.dart';

class FavoritesBlocBuilder extends StatelessWidget {
  const FavoritesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoritesCubit>();
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      listenWhen: (_, current) =>
          current is FavoritesSuccess && current.failure != null,
      listener: (context, state) {
        if (state case FavoritesSuccess(:final failure?)) {
          AppTopSnackBar.showError(context, failure.tr(context: context));
        }
      },
      builder: (context, state) => switch (state) {
        FavoritesSuccess(:final venues) when venues.isEmpty =>
          CustomStateWidget(
            icon: const Icon(Icons.favorite_border_rounded, size: 48),
            title: 'explore.favorites_empty_title'.tr(context: context),
            description: 'explore.favorites_empty_desc'.tr(context: context),
          ),
        FavoritesSuccess(:final venues) => BallRefreshIndicator(
          onRefresh: cubit.load,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: EdgeInsets.all(16.r),
            itemCount: venues.length,
            separatorBuilder: (_, _) => hSpace(12),
            itemBuilder: (context, index) {
              final venue = venues[index];
              return FadeSlideInWidget(
                index: index,
                child: FavoriteVenueCardWidget(
                  venue: venue,
                  onView: () => Navigator.of(
                    context,
                  ).pushNamed(AppRoutes.venueProfile, arguments: venue.venueId),
                  onRemove: () {
                    HapticFeedback.lightImpact();
                    cubit.remove(venue.venueId);
                  },
                ),
              );
            },
          ),
        ),
        FavoritesError(:final message) => CustomStateWidget(
          title: message.tr(context: context),
          description: '',
          actionText: 'common.retry'.tr(context: context),
          onActionTap: cubit.load,
        ),
        _ => const ShimmerListSkeletonWidget(itemHeight: 230, itemCount: 2),
      },
    );
  }
}
