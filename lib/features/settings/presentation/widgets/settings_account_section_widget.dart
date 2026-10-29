import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import 'logout_bloc_listener.dart';
import 'logout_tiles_bloc_builder.dart';
import 'settings_action_tile_widget.dart';

class SettingsAccountSectionWidget extends StatelessWidget {
  const SettingsAccountSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LogoutBlocListener(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'settings.account_section'.tr(context: context),
            style: AppTextStyles.font15Bold,
          ),
          hSpace(8),
          CustomCardWidget(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SettingsActionTileWidget(
                  icon: Icons.phone_iphone_rounded,
                  title: 'settings.change_phone'.tr(context: context),
                  onTap: () => context.pushNamed(AppRoutes.changePhone),
                ),
                const Divider(height: 1, color: AppColors.border),
                const LogoutTilesBlocBuilder(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
