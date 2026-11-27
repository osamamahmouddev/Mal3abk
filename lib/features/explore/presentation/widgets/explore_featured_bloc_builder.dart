import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../home/presentation/widgets/home_sponsored_bloc_builder.dart';
import '../../data/models/sponsored_item_model.dart';
import '../cubit/featured_venues_cubit.dart';

/// Promoted venues at the top of the explore list, each tagged as an ad.
/// Nothing is shown while featured venues are switched off or none is running.
class ExploreFeaturedBlocBuilder extends StatelessWidget {
  const ExploreFeaturedBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedVenuesCubit, List<SponsoredItemModel>>(
      builder: (context, items) {
        if (items.isEmpty) return const SizedBox.shrink();
        // The list already pads its sides.
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: SponsoredVenuesStripWidget(
            title: 'home.sponsored'.tr(context: context),
            items: items,
            sidePadding: 0,
          ),
        );
      },
    );
  }
}
