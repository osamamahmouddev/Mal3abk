import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/send_otp_cubit.dart';
import '../cubit/send_otp_state.dart';

class SendOtpBlocListener extends StatelessWidget {
  const SendOtpBlocListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendOtpCubit, SendOtpState>(
      listener: (context, state) {
        switch (state) {
          case SendOtpError(:final message):
            AppTopSnackBar.showError(context, message.tr(context: context));
          case SendOtpSuccess(:final resendError?):
            AppTopSnackBar.showError(context, resendError.tr(context: context));
          default:
            break;
        }
      },
      child: child,
    );
  }
}
