import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/send_challenge_cubit.dart';
import '../cubit/send_challenge_state.dart';

class SendChallengeBlocListener extends StatelessWidget {
  const SendChallengeBlocListener({
    required this.opponentName,
    required this.child,
    super.key,
  });

  final String opponentName;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendChallengeCubit, SendChallengeState>(
      listener: (context, state) {
        switch (state) {
          case SendChallengeSuccess(:final challenge):
            HapticFeedback.mediumImpact();
            AppTopSnackBar.showSuccess(
              context,
              'matches.challenge.sent'.tr(
                context: context,
                args: [opponentName],
              ),
            );
            Navigator.of(context).pushReplacementNamed(
              AppRoutes.challengeDetails,
              arguments: challenge.id,
            );
          case SendChallengeError(:final message):
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
