import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/verify_old_phone_cubit.dart';
import '../cubit/verify_old_phone_state.dart';

/// After the current phone is confirmed the API texts the new phone.
class VerifyOldPhoneBlocListener extends StatelessWidget {
  const VerifyOldPhoneBlocListener({
    required this.requestId,
    required this.child,
    super.key,
  });

  final String requestId;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyOldPhoneCubit, VerifyOldPhoneState>(
      listener: (context, state) {
        switch (state) {
          case VerifyOldPhoneSuccess():
            context.pushReplacementNamed(
              AppRoutes.verifyNewPhone,
              arguments: requestId,
            );
          case VerifyOldPhoneError(:final message):
            AppTopSnackBar.showError(context, message.tr(context: context));
          default:
            break;
        }
      },
      child: child,
    );
  }
}
