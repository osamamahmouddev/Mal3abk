import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/challenge_details_cubit.dart';
import '../cubit/challenge_response_cubit.dart';
import '../cubit/challenge_response_state.dart';

class ChallengeResponseBlocListener extends StatelessWidget {
  const ChallengeResponseBlocListener({
    required this.challengeId,
    required this.child,
    super.key,
  });

  final String challengeId;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChallengeResponseCubit, ChallengeResponseState>(
      listener: (context, state) {
        switch (state) {
          case ChallengeResponseSuccess(:final action):
            HapticFeedback.mediumImpact();
            AppTopSnackBar.showSuccess(
              context,
              'matches.challenge.responses.${action.name}'.tr(context: context),
            );
            context.read<ChallengeDetailsCubit>().load(challengeId);
          case ChallengeResponseError(:final message):
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
