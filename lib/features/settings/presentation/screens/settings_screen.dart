import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../widgets/settings_account_section_widget.dart';
import '../widgets/settings_switch_tile_widget.dart';

class SettingsScreen extends HookWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingAlerts = useState(true);
    final teamInvites = useState(true);
    final matchResults = useState(true);
    final promotions = useState(false);
    final appearInSearch = useState(true);
    final showPhoneToTeam = useState(true);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(title: 'settings.title'.tr(context: context)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'settings.notifications_section'.tr(context: context),
                style: AppTextStyles.font15Bold,
              ),
              hSpace(8),
              CustomCardWidget(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    SettingsSwitchTileWidget(
                      title: 'settings.booking_alerts_title'.tr(
                        context: context,
                      ),
                      subtitle: 'settings.booking_alerts_sub'.tr(
                        context: context,
                      ),
                      value: bookingAlerts.value,
                      onChanged: (v) => bookingAlerts.value = v,
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    SettingsSwitchTileWidget(
                      title: 'settings.team_invites_title'.tr(context: context),
                      subtitle: 'settings.team_invites_sub'.tr(
                        context: context,
                      ),
                      value: teamInvites.value,
                      onChanged: (v) => teamInvites.value = v,
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    SettingsSwitchTileWidget(
                      title: 'settings.match_results_title'.tr(
                        context: context,
                      ),
                      subtitle: 'settings.match_results_sub'.tr(
                        context: context,
                      ),
                      value: matchResults.value,
                      onChanged: (v) => matchResults.value = v,
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    SettingsSwitchTileWidget(
                      title: 'settings.promotions_title'.tr(context: context),
                      subtitle: 'settings.promotions_sub'.tr(context: context),
                      value: promotions.value,
                      onChanged: (v) => promotions.value = v,
                    ),
                  ],
                ),
              ),
              hSpace(20),
              Text(
                'settings.privacy_section'.tr(context: context),
                style: AppTextStyles.font15Bold,
              ),
              hSpace(8),
              CustomCardWidget(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    SettingsSwitchTileWidget(
                      title: 'settings.appear_in_search_title'.tr(
                        context: context,
                      ),
                      subtitle: 'settings.appear_in_search_sub'.tr(
                        context: context,
                      ),
                      value: appearInSearch.value,
                      onChanged: (v) => appearInSearch.value = v,
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    SettingsSwitchTileWidget(
                      title: 'settings.show_phone_title'.tr(context: context),
                      subtitle: 'settings.show_phone_sub'.tr(context: context),
                      value: showPhoneToTeam.value,
                      onChanged: (v) => showPhoneToTeam.value = v,
                    ),
                  ],
                ),
              ),
              hSpace(20),
              const SettingsAccountSectionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
