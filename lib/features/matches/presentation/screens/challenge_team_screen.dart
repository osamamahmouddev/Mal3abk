import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../teams/data/models/team_profile_model.dart';
import '../../data/models/send_challenge_request_body.dart';
import '../cubit/send_challenge_cubit.dart';
import '../widgets/challenge_schedule_picker_widget.dart';
import '../widgets/challenge_team_picker_bloc_builder.dart';
import '../widgets/send_challenge_bloc_listener.dart';
import '../widgets/send_challenge_submit_bloc_builder.dart';
import '../widgets/team_matchup_header_widget.dart';

class ChallengeTeamScreen extends HookWidget {
  const ChallengeTeamScreen({required this.opponent, super.key});

  final TeamProfileModel opponent;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final initial = useMemoized(ChallengeSchedulePickerWidget.firstAvailable);
    final myTeamId = useState<String?>(null);
    final day = useState(initial.$1);
    final hour = useState(initial.$2);
    final duration = useState(90);
    final notes = useTextEditingController();

    final kickOffUtc = CairoTime.toUtc(day.value, hour.value);
    final rank = opponent.stats.rank;
    final summary = [
      CairoTime.dayAndTime(kickOffUtc, lang),
      'matches.minutes'.tr(
        context: context,
        args: [duration.value.toLocalizedDigits(lang)],
      ),
    ].join(' · ');

    void submit() {
      final teamId = myTeamId.value;
      if (teamId == null) return;
      HapticFeedback.lightImpact();
      FocusScope.of(context).unfocus();
      context.read<SendChallengeCubit>().send(
        SendChallengeRequestBody(
          challengerTeamId: teamId,
          challengedTeamId: opponent.id,
          proposedDateUtc: kickOffUtc,
          durationMinutes: duration.value,
          notes: notes.text,
        ),
      );
    }

    return SendChallengeBlocListener(
      opponentName: opponent.name,
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: 'matches.challenge_team_title'.tr(context: context),
        ),
        bottomNavigationBar: SendChallengeSubmitBlocBuilder(
          summary: summary,
          onSubmit: myTeamId.value == null ? null : submit,
        ),
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            children: [
              Hero(
                tag: 'team-${opponent.id}',
                child: TeamMatchupHeaderWidget(
                  homeName: 'matches.challenge.my_team'.tr(context: context),
                  awayName: opponent.name,
                  center: 'common.vs'.tr(context: context),
                  awayCaption: rank > 0
                      ? 'teams.profile.rank_badge'.tr(
                          context: context,
                          args: [rank.toLocalizedDigits(lang), opponent.city],
                        )
                      : opponent.city,
                ),
              ),
              hSpace(18),
              ChallengeTeamPickerBlocBuilder(
                opponentId: opponent.id,
                selectedTeamId: myTeamId.value,
                onSelected: (id) => myTeamId.value = id,
              ),
              ChallengeSchedulePickerWidget(
                day: day.value,
                hour: hour.value,
                durationMinutes: duration.value,
                onDayChanged: (value) {
                  day.value = value;
                  if (value == CairoTime.today() &&
                      hour.value <= CairoTime.now().hour) {
                    hour.value = ChallengeSchedulePickerWidget.firstAvailable(
                      preferredHour: hour.value,
                    ).$2;
                  }
                },
                onHourChanged: (value) => hour.value = value,
                onDurationChanged: (value) => duration.value = value,
              ),
              hSpace(18),
              Text(
                'matches.challenge.notes'.tr(context: context),
                style: AppTextStyles.font15Bold,
              ),
              hSpace(10),
              CustomTextFormField(
                controller: notes,
                hintText: 'matches.challenge.notes_hint'.tr(context: context),
                minLines: 2,
                maxLines: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
