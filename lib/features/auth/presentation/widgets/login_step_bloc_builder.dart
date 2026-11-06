import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/send_otp_cubit.dart';
import '../cubit/send_otp_state.dart';
import 'login_otp_step_widget.dart';
import 'login_phone_step_widget.dart';

/// Shows the phone step until a code is sent, then the code step.
class LoginStepBlocBuilder extends StatelessWidget {
  const LoginStepBlocBuilder({required this.phoneController, super.key});

  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendOtpCubit, SendOtpState>(
      builder: (context, state) {
        return switch (state) {
          SendOtpSuccess(:final data, :final sendCount, :final resending) =>
            LoginOtpStepWidget(
              phoneNumber: data.normalizedPhoneNumber,
              sendCount: sendCount,
              isResending: resending,
            ),
          SendOtpLoading() => LoginPhoneStepWidget(
            controller: phoneController,
            isLoading: true,
          ),
          _ => LoginPhoneStepWidget(
            controller: phoneController,
            isLoading: false,
          ),
        };
      },
    );
  }
}
