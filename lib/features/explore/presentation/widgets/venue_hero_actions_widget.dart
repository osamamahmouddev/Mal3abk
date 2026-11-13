import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_assets.dart';
import 'venue_favorite_button_bloc_builder.dart';
import 'venue_hero_button_widget.dart';

/// Back and favourite buttons pinned to the top of the venue profile, so they
/// stay reachable while the page scrolls under them.
class VenueHeroActionsWidget extends StatelessWidget {
  const VenueHeroActionsWidget({
    required this.venueId,
    required this.loadedIsFavorite,
    super.key,
  });

  final String venueId;
  final bool loadedIsFavorite;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            VenueHeroButtonWidget(
              iconAsset: AppAssets.icArrowBack20,
              mirrorInLtr: true,
              onTap: () => Navigator.of(context).maybePop(),
            ),
            VenueFavoriteButtonBlocBuilder(
              venueId: venueId,
              loadedIsFavorite: loadedIsFavorite,
            ),
          ],
        ),
      ),
    );
  }
}
