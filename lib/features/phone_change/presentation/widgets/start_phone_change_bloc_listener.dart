import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/start_phone_change_cubit.dart';
import '../cubit/start_phone_change_state.dart';

class StartPhoneChangeBlocListener extends StatelessWidget {
  const StartPhoneChangeBlocListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<StartPhoneChangeCubit, StartPhoneChangeState>(
      listener: (context, state) {
        switch (state) {
          case StartPhoneChangeSuccess(:final data):
            context.pushReplacementNamed(
              AppRoutes.verifyOldPhone,
              arguments: data.requestId,
            );
          case StartPhoneChangeError(:final message):
            AppTopSnackBar.showError(context, message.tr(context: context));
          default:
            break;
        }
      },
      child: child,
    );
  }
}
