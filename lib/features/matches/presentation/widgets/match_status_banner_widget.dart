import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../data/models/match_details_model.dart';

/// What the caller should know or do next about this match, if anything.
class MatchStatusBannerWidget extends StatelessWidget {
  const MatchStatusBannerWidget({
    required this.details,
    required this.nowUtc,
    super.key,
  });

  final MatchDetailsModel details;
  final DateTime nowUtc;

  @override
  Widget build(BuildContext context) {
    final match = details.match;
    final lang = context.locale.languageCode;
    String t(String key, [List<String>? args]) =>
        'matches.match.$key'.tr(context: context, args: args);
    final score =
        '${(match.homeScore ?? 0).toLocalizedDigits(lang)}–${(match.awayScore ?? 0).toLocalizedDigits(lang)}';
    final submitter = match.resultSubmittedByTeamId == match.homeTeamId
        ? match.homeTeamName
        : match.awayTeamName;

    final (String?, AlertBannerType) banner;
    if (match.isDisputed) {
      banner = (
        t('disputed_note', [match.disputeReason ?? '']),
        AlertBannerType.error,
      );
    } else if (details.canVerifyResult) {
      banner = (t('verify_note', [submitter, score]), AlertBannerType.warning);
    } else if (match.isPendingVerification) {
      banner = (t('awaiting_verification_note', [score]), AlertBannerType.info);
    } else if (details.canSubmitResult(nowUtc)) {
      banner = (t('submit_note'), AlertBannerType.warning);
    } else if (details.canLead && match.isAwaitingResult) {
      banner = (t('not_started_note'), AlertBannerType.info);
    } else {
      banner = (null, AlertBannerType.info);
    }
    final (message, type) = banner;

    if (message == null) return const SizedBox.shrink();
    return AlertBannerWidget(message: message, type: type);
  }
}
