import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../widgets/challenge_details_bloc_builder.dart';
import '../widgets/challenge_details_footer_bloc_builder.dart';
import '../widgets/challenge_response_bloc_listener.dart';

class ChallengeDetailsScreen extends StatelessWidget {
  const ChallengeDetailsScreen({required this.challengeId, super.key});

  final String challengeId;

  @override
  Widget build(BuildContext context) {
    return ChallengeResponseBlocListener(
      challengeId: challengeId,
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: 'matches.challenge_details_title'.tr(context: context),
        ),
        bottomNavigationBar: const ChallengeDetailsFooterBlocBuilder(),
        body: SafeArea(
          child: ChallengeDetailsBlocBuilder(challengeId: challengeId),
        ),
      ),
    );
  }
}
