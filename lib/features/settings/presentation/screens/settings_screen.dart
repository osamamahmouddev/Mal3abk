import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../widgets/account_action_bloc_listener.dart';
import '../widgets/consents_bloc_builder.dart';
import '../widgets/notification_preferences_bloc_builder.dart';
import '../widgets/settings_account_section_widget.dart';
import '../widgets/settings_language_section_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountActionBlocListener(
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: 'settings.title'.tr(context: context),
        ),
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            children: [
              const NotificationPreferencesBlocBuilder(),
              hSpace(20),
              const ConsentsBlocBuilder(),
              hSpace(20),
              const SettingsLanguageSectionWidget(),
              hSpace(20),
              const SettingsAccountSectionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
