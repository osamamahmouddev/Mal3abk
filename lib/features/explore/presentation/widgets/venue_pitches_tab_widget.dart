import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/widgets/empty_note_box_widget.dart';
import '../../../../core/widgets/info_note_card_widget.dart';
import '../../data/models/pitch_details_model.dart';
import 'venue_pitch_option_card_widget.dart';

class VenuePitchesTabWidget extends StatelessWidget {
  const VenuePitchesTabWidget({
    required this.pitches,
    required this.onPitchTap,
    super.key,
  });

  final List<PitchDetailsModel> pitches;
  final ValueChanged<int> onPitchTap;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    String t(String key, [List<String>? args]) =>
        'explore.venue.$key'.tr(context: context, args: args);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (pitches.isEmpty)
          EmptyNoteBoxWidget(text: t('no_pitches'))
        else
          for (final (i, pitch) in pitches.indexed) ...[
            VenuePitchOptionCardWidget(
              title: pitch.name,
              subtitle: [
                t('players_per_side', [
                  pitch.playersPerTeam.toLocalizedDigits(lang),
                ]),
                lang == 'ar' ? pitch.surface.nameAr : pitch.surface.nameEn,
              ].join(' · '),
              price: pitch.baseHourlyPrice == null
                  ? ''
                  : 'common.price_egp'.tr(
                      context: context,
                      args: [
                        pitch.baseHourlyPrice!.round().toLocalizedDigits(lang),
                      ],
                    ),
              onTap: () => onPitchTap(i),
            ),
            hSpace(12),
          ],
        hSpace(4),
        InfoNoteCardWidget(title: t('payment_title'), body: t('payment_body')),
      ],
    );
  }
}
