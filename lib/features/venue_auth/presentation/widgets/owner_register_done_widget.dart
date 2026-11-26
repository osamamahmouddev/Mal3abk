import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/owner_register_cubit.dart';
import '../cubit/owner_register_state.dart';

/// After sign-up: the activation link went to the owner's mobile; once it is
/// opened they sign in and set up their venue.
class OwnerRegisterDoneWidget extends StatelessWidget {
  const OwnerRegisterDoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue_auth.register.$key'.tr(context: context);
    return BlocBuilder<OwnerRegisterCubit, OwnerRegisterState>(
      builder: (context, state) {
        if (state is! OwnerRegisterSuccess) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.mark_email_read_outlined,
              size: 56.r,
              color: AppColors.pitchGreen,
            ),
            hSpace(12),
            Text(
              'venue_auth.register.done_body'.tr(
                context: context,
                args: [state.phoneNumber],
              ),
              style: AppTextStyles.font14Regular,
              textAlign: TextAlign.center,
            ),
            hSpace(20),
            if (state.resent) ...[
              AlertBannerWidget(
                type: AlertBannerType.info,
                icon: Icons.check_circle_outline_rounded,
                message: t('resent'),
              ),
              hSpace(12),
            ],
            CustomButton(
              text: t('resend'),
              type: CustomButtonType.secondary,
              height: 50.h,
              borderRadius: 16,
              isLoading: state.resending,
              onTap: () =>
                  context.read<OwnerRegisterCubit>().resendActivation(),
            ),
            hSpace(12),
            CustomButton(
              text: t('back_to_login'),
              height: 54.h,
              borderRadius: 16,
              textStyle: AppTextStyles.font17Bold.copyWith(
                color: AppColors.white,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
