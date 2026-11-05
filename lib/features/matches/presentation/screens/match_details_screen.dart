import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../cubit/match_details_cubit.dart';
import '../widgets/match_details_bloc_builder.dart';
import '../widgets/match_details_footer_bloc_builder.dart';
import '../widgets/match_result_bloc_listener.dart';

class MatchDetailsScreen extends StatelessWidget {
  const MatchDetailsScreen({required this.matchId, super.key});

  final String matchId;

  @override
  Widget build(BuildContext context) {
    return MatchResultBlocListener(
      onSuccess: () => context.read<MatchDetailsCubit>().load(matchId),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: 'matches.match_details_title'.tr(context: context),
        ),
        bottomNavigationBar: const MatchDetailsFooterBlocBuilder(),
        body: SafeArea(child: MatchDetailsBlocBuilder(matchId: matchId)),
      ),
    );
  }
}
