import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/account_action_cubit.dart';
import '../cubit/account_action_state.dart';

class AccountActionBlocListener extends StatelessWidget {
  const AccountActionBlocListener({required this.child, super.key});

  static const String exportFileName = 'malabak-personal-data.json';

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountActionCubit, AccountActionState>(
      listener: (context, state) async {
        switch (state) {
          case AccountExported(:final data):
            HapticFeedback.mediumImpact();
            await SharePlus.instance.share(
              ShareParams(
                files: [
                  XFile.fromData(
                    data,
                    mimeType: 'application/json',
                    name: exportFileName,
                  ),
                ],
                fileNameOverrides: const [exportFileName],
              ),
            );
          case AccountDeleted():
            HapticFeedback.heavyImpact();
            AppTopSnackBar.showSuccess(
              context,
              'settings.delete.done'.tr(context: context),
            );
            context.openLogin();
          case AccountActionError(:final message):
            AppTopSnackBar.showError(context, message.tr(context: context));
          default:
            break;
        }
      },
      child: child,
    );
  }
}
