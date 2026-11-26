import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../auth/presentation/cubit/logout_cubit.dart';
import '../../../auth/presentation/cubit/logout_state.dart';
import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';
import '../widgets/splash_body_widget.dart';
import '../widgets/splash_lock_bloc_builder.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            switch (state) {
              case SplashAuthenticated(isVenue: true):
                context.openVenueShell();
              case SplashAuthenticated():
                context.openMainShell();
              case SplashUnauthenticated():
                context.pushReplacementNamed(AppRoutes.welcome);
              case SplashLocked():
                context.read<SplashCubit>().unlock(
                  'auth.lock.reason'.tr(context: context),
                );
              default:
                break;
            }
          },
        ),
        BlocListener<LogoutCubit, LogoutState>(
          listener: (context, state) {
            if (state is LogoutSuccess) context.openLogin();
          },
        ),
      ],
      child: const Scaffold(
        backgroundColor: AppColors.brandPrimaryDark,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: SplashBodyWidget()),
              SplashLockBlocBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
