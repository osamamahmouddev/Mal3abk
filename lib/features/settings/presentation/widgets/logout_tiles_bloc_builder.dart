import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_dialog_widget.dart';
import '../../../auth/presentation/cubit/logout_cubit.dart';
import '../../../auth/presentation/cubit/logout_state.dart';
import 'settings_action_tile_widget.dart';

class LogoutTilesBlocBuilder extends StatelessWidget {
  const LogoutTilesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogoutCubit, LogoutState>(
      builder: (context, state) {
        final isLoading = state is LogoutLoading;
        return Column(
          children: [
            SettingsActionTileWidget(
              icon: Icons.logout_rounded,
              title: 'auth.logout'.tr(context: context),
              isLoading: isLoading,
              onTap: () => context.read<LogoutCubit>().logout(),
            ),
            const Divider(height: 1, color: AppColors.border),
            SettingsActionTileWidget(
              icon: Icons.devices_other_rounded,
              title: 'settings.logout_all'.tr(context: context),
              isDestructive: true,
              isLoading: isLoading,
              onTap: () => CustomDialogWidget.show<void>(
                context: context,
                title: 'settings.logout_all_confirm_title'.tr(context: context),
                description: 'settings.logout_all_confirm_body'.tr(
                  context: context,
                ),
                primaryActionText: 'settings.logout_all_confirm_action'.tr(
                  context: context,
                ),
                secondaryActionText: 'common.cancel'.tr(context: context),
                isDestructive: true,
                onPrimaryAction: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  context.read<LogoutCubit>().logoutAll();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
