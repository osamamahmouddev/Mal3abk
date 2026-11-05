import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/match_result_cubit.dart';
import '../cubit/match_result_state.dart';

/// Reports a submitted, confirmed or disputed result and calls [onSuccess].
class MatchResultBlocListener extends StatelessWidget {
  const MatchResultBlocListener({
    required this.onSuccess,
    required this.child,
    super.key,
  });

  final VoidCallback onSuccess;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MatchResultCubit, MatchResultState>(
      listener: (context, state) {
        switch (state) {
          case MatchResultSuccess(:final action):
            HapticFeedback.mediumImpact();
            AppTopSnackBar.showSuccess(
              context,
              'matches.match.results.${action.name}'.tr(context: context),
            );
            onSuccess();
          case MatchResultError(:final message):
            HapticFeedback.heavyImpact();
            AppTopSnackBar.showError(context, message.tr(context: context));
          default:
            break;
        }
      },
      child: child,
    );
  }
}
