import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_dialog_widget.dart';

class RestoreAccountDialogWidget extends StatelessWidget {
  const RestoreAccountDialogWidget({
    required this.onRestore,
    required this.onCancel,
    super.key,
  });

  final VoidCallback onRestore;
  final VoidCallback onCancel;

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onRestore,
    required VoidCallback onCancel,
  }) {
    final navigator = Navigator.of(context, rootNavigator: true);
    return CustomDialogWidget.show<void>(
      context: context,
      barrierDismissible: false,
      title: 'auth.restore_dialog.title'.tr(context: context),
      description: 'auth.restore_dialog.description'.tr(context: context),
      primaryActionText: 'auth.restore_dialog.restore'.tr(context: context),
      secondaryActionText: 'auth.restore_dialog.cancel'.tr(context: context),
      onPrimaryAction: () {
        navigator.pop();
        onRestore();
      },
      onSecondaryAction: () {
        navigator.pop();
        onCancel();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialogWidget(
      title: 'auth.restore_dialog.title'.tr(context: context),
      description: 'auth.restore_dialog.description'.tr(context: context),
      primaryActionText: 'auth.restore_dialog.restore'.tr(context: context),
      secondaryActionText: 'auth.restore_dialog.cancel'.tr(context: context),
      onPrimaryAction: onRestore,
      onSecondaryAction: onCancel,
    );
  }
}
