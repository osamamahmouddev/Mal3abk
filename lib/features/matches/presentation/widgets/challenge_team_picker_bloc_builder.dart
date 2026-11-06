import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/custom_chip_widget.dart';
import '../../../../core/widgets/custom_skeleton_widget.dart';
import '../../../teams/presentation/cubit/my_teams_cubit.dart';
import '../../../teams/presentation/cubit/my_teams_state.dart';

/// Teams the caller leads, excluding the opponent; selects the first one
/// automatically.
class ChallengeTeamPickerBlocBuilder extends StatelessWidget {
  const ChallengeTeamPickerBlocBuilder({
    required this.opponentId,
    required this.selectedTeamId,
    required this.onSelected,
    super.key,
  });

  final String opponentId;
  final String? selectedTeamId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyTeamsCubit, MyTeamsState>(
      listener: (context, state) {
        if (state case MyTeamsSuccess(
          :final teams,
        ) when selectedTeamId == null) {
          final first = teams
              .where((t) => t.isLeader && t.id != opponentId)
              .firstOrNull;
          if (first != null) onSelected(first.id);
        }
      },
      builder: (context, state) {
        return switch (state) {
          MyTeamsSuccess(:final teams) => () {
            final leading = teams
                .where((t) => t.isLeader && t.id != opponentId)
                .toList(growable: false);
            if (leading.isEmpty) {
              return AlertBannerWidget(
                type: AlertBannerType.warning,
                message: 'matches.challenge.no_leading_team'.tr(
                  context: context,
                ),
              );
            }
            if (leading.length == 1) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'matches.challenge.pick_team'.tr(context: context),
                  style: AppTextStyles.font15Bold,
                ),
                hSpace(10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final team in leading)
                      CustomChipWidget(
                        label: team.name,
                        isSelected: team.id == selectedTeamId,
                        onTap: () => onSelected(team.id),
                      ),
                  ],
                ),
                hSpace(18),
              ],
            );
          }(),
          MyTeamsError(:final message) => AlertBannerWidget(
            type: AlertBannerType.error,
            message: message.tr(context: context),
            actionText: 'common.retry'.tr(context: context),
            onActionTap: () => context.read<MyTeamsCubit>().load(),
          ),
          _ => const CustomSkeletonWidget(height: 40),
        };
      },
    );
  }
}
