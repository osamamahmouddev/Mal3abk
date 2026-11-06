import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/info_note_card_widget.dart';
import '../../data/models/match_details_model.dart';
import '../cubit/match_result_cubit.dart';
import '../widgets/match_result_bloc_listener.dart';
import '../widgets/score_stepper_widget.dart';
import '../widgets/submit_result_bloc_builder.dart';

class SubmitResultScreen extends HookWidget {
  const SubmitResultScreen({required this.details, super.key});

  final MatchDetailsModel details;

  @override
  Widget build(BuildContext context) {
    final match = details.match;
    final myTeamId = details.myTeam!.id;
    final homeScore = useState(0);
    final awayScore = useState(0);
    final opponent = myTeamId == match.homeTeamId
        ? match.awayTeamName
        : match.homeTeamName;
    final lang = context.locale.languageCode;

    return MatchResultBlocListener(
      onSuccess: () => Navigator.of(context).pop(true),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: 'matches.submit_result_title'.tr(context: context),
        ),
        bottomNavigationBar: SubmitResultBlocBuilder(
          onSubmit: () {
            HapticFeedback.mediumImpact();
            context.read<MatchResultCubit>().submit(
              match.id,
              teamId: myTeamId,
              homeScore: homeScore.value,
              awayScore: awayScore.value,
            );
          },
        ),
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            children: [
              Text(
                [
                  CairoTime.dayAndTime(match.scheduledStartUtc, lang),
                  ?match.venueName,
                ].join(' · '),
                textAlign: TextAlign.center,
                style: AppTextStyles.font13Regular,
              ),
              hSpace(20),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 8.w),
                decoration: BoxDecoration(
                  color: AppColors.brandNavy,
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScoreStepperWidget(
                      teamName: match.homeTeamName,
                      score: homeScore.value,
                      color: AppColors.brandPrimaryLight,
                      onChanged: (value) => homeScore.value = value,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: Text(
                        '–',
                        style: AppTextStyles.font24Bold.copyWith(
                          color: AppColors.accentGold,
                        ),
                      ),
                    ),
                    ScoreStepperWidget(
                      teamName: match.awayTeamName,
                      score: awayScore.value,
                      color: AppColors.brandRed,
                      onChanged: (value) => awayScore.value = value,
                    ),
                  ],
                ),
              ),
              hSpace(20),
              InfoNoteCardWidget(
                title: 'matches.match.submit_info_title'.tr(context: context),
                body: 'matches.match.submit_info'.tr(
                  context: context,
                  args: [opponent],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
