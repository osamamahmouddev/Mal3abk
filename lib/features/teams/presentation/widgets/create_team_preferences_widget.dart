import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/pill_choice_wrap_widget.dart';
import '../../../../core/widgets/radio_option_card_widget.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';

/// Area, preferred pitch size and visibility choices of the create-team form.
class CreateTeamPreferencesWidget extends HookWidget {
  const CreateTeamPreferencesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final area = useState(0);
    final pitchType = useState(0);
    final isPublic = useState(true);

    final pitchLabels = [
      'explore.filters.size_5'.tr(context: context),
      'explore.filters.size_7'.tr(context: context),
      'teams.create.any'.tr(context: context),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('${'teams.create.area'.tr(context: context)} *', style: AppTextStyles.font14SemiBold),
        hSpace(14),
        PillChoiceWrapWidget(
          labels: [
            'onboarding.profile_setup.area_nasr_city'.tr(context: context),
            'onboarding.profile_setup.area_heliopolis'.tr(context: context),
            'onboarding.profile_setup.area_tagamoa'.tr(context: context),
            'teams.create.area_abbasiya'.tr(context: context),
          ],
          selectedIndex: area.value,
          onSelect: (index) => area.value = index,
        ),
        hSpace(14),
        Text('teams.create.pitch_type'.tr(context: context), style: AppTextStyles.font14SemiBold),
        hSpace(14),
        Row(
          children: [
            for (var i = 0; i < pitchLabels.length; i++) ...[
              if (i > 0) vSpace(8),
              Expanded(
                child: SelectableTileWidget(
                  title: pitchLabels[i],
                  isSelected: pitchType.value == i,
                  onTap: () => pitchType.value = i,
                  height: 46,
                  borderRadius: 12,
                ),
              ),
            ],
          ],
        ),
        hSpace(14),
        Text('teams.create.visibility'.tr(context: context), style: AppTextStyles.font14SemiBold),
        hSpace(14),
        RadioOptionCardWidget(
          title: 'teams.create.public'.tr(context: context),
          subtitle: 'teams.create.public_sub'.tr(context: context),
          titleStyle: AppTextStyles.font14Bold,
          isSelected: isPublic.value,
          onTap: () => isPublic.value = true,
        ),
        hSpace(8),
        RadioOptionCardWidget(
          title: 'teams.create.private'.tr(context: context),
          subtitle: 'teams.create.private_sub'.tr(context: context),
          titleStyle: AppTextStyles.font14Bold,
          isSelected: !isPublic.value,
          onTap: () => isPublic.value = false,
        ),
      ],
    );
  }
}
