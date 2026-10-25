import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        switch (state) {
          case LoginSuccess():
            context.pushNamedAndRemoveUntil(
              AppRoutes.main,
              (route) => false,
            );
          case LoginError(:final message):
            AppTopSnackBar.showError(context, message);
          default:
            break;
        }
      },
      child: child,
    );
  }
}
