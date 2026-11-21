import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../widgets/profile_header_bloc_builder.dart';
import '../widgets/profile_nav_tile_widget.dart';
import '../widgets/profile_teams_tile_bloc_builder.dart';
import '../widgets/profile_venue_owner_card_widget.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ProfileHeaderBlocBuilder(),
              hSpace(16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    CustomCardWidget(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          const ProfileTeamsTileBlocBuilder(),
                          const Divider(height: 1, color: AppColors.border),
                          ProfileNavTileWidget(
                            icon: Icons.calendar_today_outlined,
                            title: 'profile.booking_history'.tr(
                              context: context,
                            ),
                            onTap: () => Navigator.of(
                              context,
                            ).pushNamed(AppRoutes.myBookings),
                          ),
                          const Divider(height: 1, color: AppColors.border),
                          ProfileNavTileWidget(
                            icon: Icons.favorite_border_rounded,
                            title: 'profile.favorite_pitches'.tr(
                              context: context,
                            ),
                            onTap: () => Navigator.of(
                              context,
                            ).pushNamed(AppRoutes.favorites),
                          ),
                          const Divider(height: 1, color: AppColors.border),
                          ProfileNavTileWidget(
                            icon: Icons.notifications_none_rounded,
                            title: 'profile.notifications'.tr(context: context),
                            onTap: () => Navigator.of(
                              context,
                            ).pushNamed(AppRoutes.notifications),
                          ),
                        ],
                      ),
                    ),
                    hSpace(14),
                    CustomCardWidget(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          ProfileNavTileWidget(
                            icon: Icons.settings_outlined,
                            title: 'profile.settings'.tr(context: context),
                            trailing:
                                (context.locale.languageCode == 'ar'
                                        ? 'common.arabic'
                                        : 'common.english')
                                    .tr(context: context),
                            onTap: () => Navigator.of(
                              context,
                            ).pushNamed(AppRoutes.settings),
                          ),
                          const Divider(height: 1, color: AppColors.border),
                          ProfileNavTileWidget(
                            icon: Icons.help_outline_rounded,
                            title: 'profile.help_and_support'.tr(
                              context: context,
                            ),
                            onTap: () => Navigator.of(
                              context,
                            ).pushNamed(AppRoutes.helpAndSupport),
                          ),
                        ],
                      ),
                    ),
                    hSpace(14),
                    const ProfileVenueOwnerCardWidget(),
                    hSpace(24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
