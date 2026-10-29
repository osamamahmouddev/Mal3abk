import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../auth/presentation/cubit/logout_cubit.dart';
import '../../../auth/presentation/cubit/logout_state.dart';

class LogoutBlocListener extends StatelessWidget {
  const LogoutBlocListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, LogoutState>(
      listener: (context, state) {
        switch (state) {
          case LogoutSuccess():
            context.openLogin();
          case LogoutError(:final message):
            AppTopSnackBar.showError(context, message.tr(context: context));
          default:
            break;
        }
      },
      child: child,
    );
  }
}
