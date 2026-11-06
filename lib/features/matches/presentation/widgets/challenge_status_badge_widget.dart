import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/app_badge_widget.dart';
import '../../data/models/team_challenge_model.dart';

class ChallengeStatusBadgeWidget extends StatelessWidget {
  const ChallengeStatusBadgeWidget({required this.status, super.key});

  final ChallengeStatus status;

  @override
  Widget build(BuildContext context) {
    return AppBadgeWidget(
      text: 'matches.challenge.status.${status.name}'.tr(context: context),
      type: switch (status) {
        ChallengeStatus.accepted => AppBadgeType.success,
        ChallengeStatus.pending ||
        ChallengeStatus.counterProposed => AppBadgeType.warning,
        ChallengeStatus.declined => AppBadgeType.error,
        _ => AppBadgeType.neutral,
      },
    );
  }
}
