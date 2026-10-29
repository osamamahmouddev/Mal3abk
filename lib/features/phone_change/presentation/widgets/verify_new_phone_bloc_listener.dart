import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/verify_new_phone_cubit.dart';
import '../cubit/verify_new_phone_state.dart';

/// The change revokes every session, so the player signs in again with the
/// new number.
class VerifyNewPhoneBlocListener extends StatelessWidget {
  const VerifyNewPhoneBlocListener({
    required this.requestId,
    required this.child,
    super.key,
  });

  final String requestId;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyNewPhoneCubit, VerifyNewPhoneState>(
      listener: (context, state) {
        switch (state) {
          case VerifyNewPhoneSuccess():
            AppTopSnackBar.showSuccess(
              context,
              'phone_change.verify_new.success'.tr(context: context),
            );
            context.openLogin();
          case VerifyNewPhoneError(:final message):
            AppTopSnackBar.showError(context, message.tr(context: context));
          default:
            break;
        }
      },
      child: child,
    );
  }
}
