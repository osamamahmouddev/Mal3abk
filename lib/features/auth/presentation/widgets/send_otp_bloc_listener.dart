import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/send_otp_cubit.dart';
import '../cubit/send_otp_state.dart';
import '../cubit/verify_otp_cubit.dart';

class SendOtpBlocListener extends StatelessWidget {
  const SendOtpBlocListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendOtpCubit, SendOtpState>(
      listener: (context, state) {
        switch (state) {
          // A rate limit is explained by the banner on the phone step.
          case SendOtpError(:final message, retryAt: null):
            AppTopSnackBar.showError(context, message.tr(context: context));
          case SendOtpSuccess(:final resendError?):
            AppTopSnackBar.showError(context, resendError.tr(context: context));
          default:
            break;
        }
      },
      // Android verified the number by itself: sign in without a typed code.
      child: BlocListener<SendOtpCubit, SendOtpState>(
        listenWhen: (previous, current) =>
            _autoCredential(current) != null &&
            _autoCredential(current) != _autoCredential(previous),
        listener: (context, state) => context
            .read<VerifyOtpCubit>()
            .verifyWithCredential(_autoCredential(state)!),
        child: child,
      ),
    );
  }

  static PhoneAuthCredential? _autoCredential(SendOtpState state) =>
      state is SendOtpSuccess ? state.autoCredential : null;
}
