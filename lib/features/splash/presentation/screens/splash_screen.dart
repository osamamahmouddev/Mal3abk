import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';
import '../widgets/splash_body_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        switch (state) {
          case SplashAuthenticated():
            context.pushReplacementNamed(AppRoutes.home);
          case SplashUnauthenticated():
            context.pushReplacementNamed(AppRoutes.login);
          default:
            break;
        }
      },
      child: const Scaffold(
        backgroundColor: AppColors.brandNavy,
        body: SplashBodyWidget(),
      ),
    );
  }
}
