import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/send_otp_cubit.dart';
import '../cubit/verify_otp_cubit.dart';
import '../cubit/verify_otp_state.dart';
import 'restore_account_dialog_widget.dart';

/// New players continue to profile setup; returning players go home.
class VerifyOtpBlocListener extends StatelessWidget {
  const VerifyOtpBlocListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyOtpCubit, VerifyOtpState>(
      listener: (context, state) {
        switch (state) {
          case VerifyOtpSuccess(:final data) when data.isNewUser:
            context.pushReplacementNamed(AppRoutes.profileSetup);
          case VerifyOtpSuccess():
            context.openMainShell();
          case VerifyOtpAccountPendingDeletion():
            RestoreAccountDialogWidget.show(
              context: context,
              onRestore: () {
                context.read<VerifyOtpCubit>().enableRestoreAccount();
                context.read<SendOtpCubit>().resend();
              },
              onCancel: () {
                context.read<VerifyOtpCubit>().reset();
                context.read<SendOtpCubit>().reset();
              },
            );
          case VerifyOtpError(:final message):
            AppTopSnackBar.showError(context, message.tr(context: context));
          default:
            break;
        }
      },
      child: child,
    );
  }
}
