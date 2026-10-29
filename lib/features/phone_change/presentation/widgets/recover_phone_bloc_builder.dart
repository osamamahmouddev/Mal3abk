import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../cubit/recover_phone_cubit.dart';
import '../cubit/recover_phone_state.dart';
import 'recover_phone_confirm_widget.dart';

class RecoverPhoneBlocBuilder extends StatelessWidget {
  const RecoverPhoneBlocBuilder({required this.recoveryToken, super.key});

  final String recoveryToken;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoverPhoneCubit, RecoverPhoneState>(
      builder: (context, state) {
        return switch (state) {
          RecoverPhoneLoading() => CustomStateWidget(
            isLoading: true,
            title: 'phone_change.recover.loading_title'.tr(context: context),
            description: 'common.loading'.tr(context: context),
          ),
          RecoverPhoneSuccess() => CustomStateWidget(
            icon: Icon(
              Icons.check_circle_rounded,
              color: AppColors.success,
              size: 56.sp,
            ),
            title: 'phone_change.recover.success_title'.tr(context: context),
            description: 'phone_change.recover.success_description'.tr(
              context: context,
            ),
            actionText: 'phone_change.recover.sign_in'.tr(context: context),
            onActionTap: context.openLogin,
          ),
          RecoverPhoneError(:final message) => CustomStateWidget(
            icon: Icon(
              Icons.error_outline_rounded,
              color: AppColors.error,
              size: 56.sp,
            ),
            title: 'phone_change.recover.error_title'.tr(context: context),
            description: message.tr(context: context),
            actionText: 'common.retry'.tr(context: context),
            onActionTap: () =>
                context.read<RecoverPhoneCubit>().recover(recoveryToken),
          ),
          _ => RecoverPhoneConfirmWidget(recoveryToken: recoveryToken),
        };
      },
    );
  }
}
