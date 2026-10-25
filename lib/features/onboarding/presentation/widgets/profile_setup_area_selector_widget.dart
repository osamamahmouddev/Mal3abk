import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/pill_choice_wrap_widget.dart';

class ProfileSetupAreaSelectorWidget extends StatelessWidget {
  const ProfileSetupAreaSelectorWidget({
    required this.selectedArea,
    required this.onSelect,
    super.key,
  });

  static const List<String> areaKeys = [
    'nasr_city',
    'heliopolis',
    'tagamoa',
    'maadi',
    'dokki',
    'october',
  ];

  final String selectedArea;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return PillChoiceWrapWidget(
      labels: [
        for (final key in areaKeys)
          'onboarding.profile_setup.area_$key'.tr(context: context),
      ],
      selectedIndex: areaKeys.indexOf(selectedArea),
      onSelect: (index) => onSelect(areaKeys[index]),
    );
  }
}
