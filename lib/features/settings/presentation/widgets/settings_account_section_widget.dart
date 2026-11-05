import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/custom_dialog_widget.dart';
import '../../../step_up/data/models/step_up_scope.dart';
import '../../../step_up/presentation/widgets/step_up_sheet_widget.dart';
import '../cubit/account_action.dart';
import '../cubit/account_action_cubit.dart';
import '../cubit/account_action_state.dart';
import 'logout_bloc_listener.dart';
import 'logout_tiles_bloc_builder.dart';
import 'settings_action_tile_widget.dart';
import 'settings_section_card_widget.dart';

class SettingsAccountSectionWidget extends StatelessWidget {
  const SettingsAccountSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AccountActionCubit>();

    Future<void> exportData() async {
      final token = await StepUpSheetWidget.show(
        context,
        scope: StepUpScope.exportData,
      );
      if (token != null) await cubit.exportData(stepUpToken: token);
    }

    void confirmDelete() {
      final navigator = Navigator.of(context, rootNavigator: true);
      CustomDialogWidget.show<void>(
        context: context,
        title: 'settings.delete.confirm_title'.tr(context: context),
        description: 'settings.delete.confirm_body'.tr(context: context),
        primaryActionText: 'settings.delete.confirm_action'.tr(
          context: context,
        ),
        secondaryActionText: 'common.cancel'.tr(context: context),
        isDestructive: true,
        onSecondaryAction: navigator.pop,
        onPrimaryAction: () async {
          navigator.pop();
          final token = await StepUpSheetWidget.show(
            context,
            scope: StepUpScope.deleteAccount,
          );
          if (token != null) await cubit.deleteAccount(stepUpToken: token);
        },
      );
    }

    return LogoutBlocListener(
      child: BlocBuilder<AccountActionCubit, AccountActionState>(
        builder: (context, state) {
          bool loading(AccountAction action) =>
              state is AccountActionLoading && state.action == action;
          return SettingsSectionCardWidget(
            title: 'settings.account_section'.tr(context: context),
            children: [
              SettingsActionTileWidget(
                icon: Icons.phone_iphone_rounded,
                title: 'settings.change_phone'.tr(context: context),
                onTap: () => context.pushNamed(AppRoutes.changePhone),
              ),
              SettingsActionTileWidget(
                icon: Icons.devices_rounded,
                title: 'settings.sessions.title'.tr(context: context),
                onTap: () => context.pushNamed(AppRoutes.activeSessions),
              ),
              SettingsActionTileWidget(
                icon: Icons.download_rounded,
                title: 'settings.export.title'.tr(context: context),
                isLoading: loading(AccountAction.exportData),
                onTap: exportData,
              ),
              const LogoutTilesBlocBuilder(),
              SettingsActionTileWidget(
                icon: Icons.delete_forever_rounded,
                title: 'settings.delete.title'.tr(context: context),
                isDestructive: true,
                isLoading: loading(AccountAction.deleteAccount),
                onTap: confirmDelete,
              ),
            ],
          );
        },
      ),
    );
  }
}
