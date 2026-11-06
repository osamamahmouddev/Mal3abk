import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../cubit/match_details_cubit.dart';
import '../cubit/match_details_state.dart';
import 'match_result_actions_bloc_builder.dart';

class MatchDetailsFooterBlocBuilder extends StatelessWidget {
  const MatchDetailsFooterBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchDetailsCubit, MatchDetailsState>(
      builder: (context, state) {
        if (state case MatchDetailsSuccess(:final details)
            when details.canVerifyResult ||
                details.canSubmitResult(DateTime.now().toUtc())) {
          return BottomActionBarWidget(
            child: MatchResultActionsBlocBuilder(details: details),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
