import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../auth/presentation/cubit/logout_cubit.dart';
import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';

/// Unlock buttons under the logo while the app lock is on.
class SplashLockBlocBuilder extends StatelessWidget {
  const SplashLockBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        if (state is! SplashLocked) return const SizedBox.shrink();
        return Padding(
          padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomButton(
                text: 'auth.lock.unlock'.tr(context: context),
                height: 54.h,
                borderRadius: 16,
                icon: Icon(
                  Icons.fingerprint_rounded,
                  color: AppColors.white,
                  size: 24.sp,
                ),
                textStyle: AppTextStyles.font16Bold.copyWith(
                  color: AppColors.white,
                ),
                onTap: () => context.read<SplashCubit>().unlock(
                  'auth.lock.reason'.tr(context: context),
                ),
              ),
              hSpace(8),
              CustomButton(
                text: 'auth.lock.use_phone'.tr(context: context),
                type: CustomButtonType.ghost,
                height: 46.h,
                textStyle: AppTextStyles.font14SemiBold.copyWith(
                  color: AppColors.onNavyMuted,
                ),
                onTap: () => context.read<LogoutCubit>().logout(),
              ),
            ],
          ),
        );
      },
    );
  }
}
