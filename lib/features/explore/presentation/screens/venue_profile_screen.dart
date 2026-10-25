import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_tab_bar_widget.dart';
import '../../../../core/widgets/info_note_card_widget.dart';
import '../widgets/venue_hero_widget.dart';
import '../widgets/venue_info_header_widget.dart';
import '../widgets/venue_pitch_option_card_widget.dart';
import '../widgets/venue_price_footer_widget.dart';

class VenueProfileScreen extends HookWidget {
  const VenueProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);

    void openPitchAndTime() =>
        Navigator.of(context).pushNamed(AppRoutes.pitchAndTime);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      bottomNavigationBar: const VenuePriceFooterWidget(),
      body: ListView(
        padding: EdgeInsets.only(bottom: 16.h),
        children: [
          const VenueHeroWidget(),
          const VenueInfoHeaderWidget(),
          CustomTabBarWidget(
            tabs: [
              'explore.venue.tab_pitches'.tr(context: context),
              'explore.venue.tab_amenities'.tr(context: context),
              'explore.venue.tab_policies'.tr(context: context),
            ],
            selectedIndex: selectedTab.value,
            onTabSelected: (index) => selectedTab.value = index,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
            child: Column(
              children: [
                VenuePitchOptionCardWidget(
                  title: 'explore.venue.pitch1'.tr(context: context),
                  subtitle: 'explore.venue.specs_5'.tr(context: context),
                  price: 'explore.sample1_price'.tr(context: context),
                  onTap: openPitchAndTime,
                ),
                hSpace(12),
                VenuePitchOptionCardWidget(
                  title: 'explore.venue.pitch2'.tr(context: context),
                  subtitle: 'explore.venue.specs_7'.tr(context: context),
                  price: 'explore.venue.price_220'.tr(context: context),
                  onTap: openPitchAndTime,
                ),
                hSpace(12),
                VenuePitchOptionCardWidget(
                  title: 'explore.venue.pitch3'.tr(context: context),
                  subtitle: 'explore.venue.specs_5'.tr(context: context),
                  price: 'explore.sample1_price'.tr(context: context),
                  onTap: openPitchAndTime,
                ),
                hSpace(12),
                InfoNoteCardWidget(
                  title: 'explore.venue.payment_title'.tr(context: context),
                  body: 'explore.venue.payment_body'.tr(context: context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
