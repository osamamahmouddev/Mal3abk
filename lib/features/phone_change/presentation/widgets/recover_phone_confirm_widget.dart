import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../cubit/recover_phone_cubit.dart';

/// Asks before restoring, so opening the link alone changes nothing. A link
/// without a token shows the invalid-link state instead.
class RecoverPhoneConfirmWidget extends StatelessWidget {
  const RecoverPhoneConfirmWidget({required this.recoveryToken, super.key});

  final String recoveryToken;

  @override
  Widget build(BuildContext context) {
    if (recoveryToken.trim().isEmpty) {
      return CustomStateWidget(
        icon: Icon(
          Icons.link_off_rounded,
          color: AppColors.textSecondary,
          size: 56.sp,
        ),
        title: 'phone_change.recover.invalid_link_title'.tr(context: context),
        description: 'errors.identity.recovery_link_invalid'.tr(
          context: context,
        ),
        actionText: 'phone_change.recover.sign_in'.tr(context: context),
        onActionTap: context.openLogin,
      );
    }

    return CustomStateWidget(
      icon: Icon(
        Icons.shield_outlined,
        color: AppColors.brandNavy,
        size: 56.sp,
      ),
      title: 'phone_change.recover.confirm_title'.tr(context: context),
      description: 'phone_change.recover.confirm_description'.tr(
        context: context,
      ),
      actionText: 'phone_change.recover.confirm_action'.tr(context: context),
      onActionTap: () =>
          context.read<RecoverPhoneCubit>().recover(recoveryToken),
    );
  }
}
