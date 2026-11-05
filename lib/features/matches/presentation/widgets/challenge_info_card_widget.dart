import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../data/models/team_challenge_model.dart';
import 'challenge_status_badge_widget.dart';

class ChallengeInfoCardWidget extends StatelessWidget {
  const ChallengeInfoCardWidget({required this.challenge, super.key});

  final TeamChallengeModel challenge;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    String t(String key) => 'matches.challenge.$key'.tr(context: context);

    Widget row(String label, String value) => Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(label, style: AppTextStyles.font12Regular)),
          Expanded(
            flex: 2,
            child: Text(value, style: AppTextStyles.font13SemiBold),
          ),
        ],
      ),
    );

    return CustomCardWidget(
      borderRadius: 18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(t('terms'), style: AppTextStyles.font15Bold),
              ),
              ChallengeStatusBadgeWidget(status: challenge.status),
            ],
          ),
          hSpace(4),
          row(t('when'), CairoTime.dayAndTime(challenge.proposedDateUtc, lang)),
          row(
            t('duration'),
            'matches.minutes'.tr(
              context: context,
              args: [challenge.proposedDurationMinutes.toLocalizedDigits(lang)],
            ),
          ),
          row(t('venue'), challenge.proposedVenueName ?? t('venue_tbd')),
          if (challenge.notes case final notes? when notes.isNotEmpty)
            row(t('notes_label'), notes),
          if (challenge.declinedReason case final reason?
              when reason.isNotEmpty)
            row(t('declined_reason'), reason),
        ],
      ),
    );
  }
}
