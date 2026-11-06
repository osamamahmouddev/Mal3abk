import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class SettingsSwitchTileWidget extends StatelessWidget {
  const SettingsSwitchTileWidget({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title, style: AppTextStyles.font14SemiBold),
      subtitle: Text(subtitle, style: AppTextStyles.font11Regular),
      value: value,
      activeThumbColor: AppColors.brandNavy,
      onChanged: onChanged,
    );
  }
}
