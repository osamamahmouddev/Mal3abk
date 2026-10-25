import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/widgets/custom_card_widget.dart';
import 'invite_player_row_widget.dart';

class InvitePlayersListWidget extends HookWidget {
  const InvitePlayersListWidget({super.key});

  /// (sample key, initial status)
  static const List<(String, InvitePlayerStatus)> players = [
    ('karim', InvitePlayerStatus.sent),
    ('mohamed', InvitePlayerStatus.available),
    ('youssef_h', InvitePlayerStatus.member),
    ('omar', InvitePlayerStatus.available),
    ('ziad', InvitePlayerStatus.available),
    ('hany', InvitePlayerStatus.available),
  ];

  static const Map<String, String> metaKeys = {
    'karim': 'm_karim',
    'mohamed': 'm_mohamed',
    'youssef_h': 'm_youssef',
    'omar': 'm_omar',
    'ziad': 'm_ziad',
    'hany': 'm_hany',
  };

  @override
  Widget build(BuildContext context) {
    final invited = useState(<String>{});

    return CustomCardWidget(
      borderRadius: 18,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (final (key, status) in players)
            InvitePlayerRowWidget(
              initials: 'teams.sample.${key}_i'.tr(context: context),
              name: 'teams.sample.$key'.tr(context: context),
              meta: 'teams.invite.${metaKeys[key]}'.tr(context: context),
              status: invited.value.contains(key) ? InvitePlayerStatus.sent : status,
              onInvite: () => invited.value = {...invited.value, key},
            ),
        ],
      ),
    );
  }
}
