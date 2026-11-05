import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/app_badge_widget.dart';
import '../../data/models/match_model.dart';

class MatchStatusBadgeWidget extends StatelessWidget {
  const MatchStatusBadgeWidget({required this.match, super.key});

  final MatchModel match;

  @override
  Widget build(BuildContext context) {
    final (key, type) = switch (match) {
      MatchModel(status: MatchModel.cancelled) => (
        'cancelled',
        AppBadgeType.neutral,
      ),
      MatchModel(status: MatchModel.completed) => (
        'completed',
        AppBadgeType.success,
      ),
      MatchModel(isDisputed: true) => ('disputed', AppBadgeType.error),
      MatchModel(isPendingVerification: true) => (
        'pending_verification',
        AppBadgeType.warning,
      ),
      _ => ('scheduled', AppBadgeType.accent),
    };
    return AppBadgeWidget(
      text: 'matches.match.status.$key'.tr(context: context),
      type: type,
    );
  }
}
