import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/section_header_widget.dart';
import 'team_player_row_widget.dart';
import 'team_profile_variant.dart';

class TeamProfilePlayersSectionWidget extends StatelessWidget {
  const TeamProfilePlayersSectionWidget({required this.variant, super.key});

  final TeamProfileVariant variant;

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'teams.$key'.tr(context: context);
    String captain(String key) =>
        'teams.profile.captain_suffix'.tr(context: context, args: [t('sample.$key')]);

    final (count, players) = switch (variant) {
      TeamProfileVariant.mine => ('٨', [
          (t('sample.ahmed_i'), captain('ahmed'), t('positions.mid')),
          (t('sample.karim_i'), t('sample.karim'), t('positions.mid')),
          (t('sample.mohamed_i'), t('sample.mohamed'), t('positions.def')),
          (t('sample.youssef_h_i'), t('sample.youssef_h'), t('positions.gk')),
          (t('sample.ziad_i'), t('sample.ziad'), t('positions.mid')),
        ]),
      TeamProfileVariant.other => ('١٠', [
          (t('sample.youssef_i'), captain('youssef'), t('positions.fwd')),
          (t('sample.ali_i'), t('sample.ali'), t('positions.mid')),
          (t('sample.mostafa_i'), t('sample.mostafa'), t('positions.gk')),
        ]),
      TeamProfileVariant.fresh => ('١', [
          (t('sample.ahmed_i'), captain('ahmed'), t('positions.mid')),
        ]),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeaderWidget(
          title: 'teams.profile.players'.tr(context: context, args: [count]),
          actionText: variant == TeamProfileVariant.other
              ? null
              : 'teams.profile.manage'.tr(context: context),
          onAction: () => Navigator.of(context).pushNamed(AppRoutes.manageMembers),
        ),
        hSpace(14),
        CustomCardWidget(
          borderRadius: 18,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (final (initials, name, position) in players)
                TeamPlayerRowWidget(initials: initials, name: name, position: position),
            ],
          ),
        ),
      ],
    );
  }
}
