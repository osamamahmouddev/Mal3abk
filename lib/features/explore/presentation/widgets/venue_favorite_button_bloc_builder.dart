import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/favorite_heart_widget.dart';
import '../cubit/favorite_toggle_cubit.dart';
import '../cubit/favorite_toggle_state.dart';
import 'venue_hero_button_widget.dart';

/// Heart button on the venue profile; only this button rebuilds when the
/// favourite flips.
class VenueFavoriteButtonBlocBuilder extends StatelessWidget {
  const VenueFavoriteButtonBlocBuilder({
    required this.venueId,
    required this.loadedIsFavorite,
    super.key,
  });

  final String venueId;
  final bool loadedIsFavorite;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteToggleCubit, FavoriteToggleState>(
      builder: (context, _) {
        final favorites = context.read<FavoriteToggleCubit>();
        final isFavorite = favorites.isFavorite(
          venueId,
          loaded: loadedIsFavorite,
        );
        return VenueHeroButtonWidget(
          icon: FavoriteHeartWidget(isFavorite: isFavorite, size: 20.r),
          onTap: () {
            HapticFeedback.lightImpact();
            favorites.toggle(venueId, loaded: loadedIsFavorite);
          },
        );
      },
    );
  }
}
