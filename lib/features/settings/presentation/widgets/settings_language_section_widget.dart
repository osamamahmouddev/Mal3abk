import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_chip_widget.dart';
import '../cubit/account_action_cubit.dart';

class SettingsLanguageSectionWidget extends StatelessWidget {
  const SettingsLanguageSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final current = context.locale.languageCode;

    Future<void> select(String code) async {
      if (code == current) return;
      HapticFeedback.selectionClick();
      final cubit = context.read<AccountActionCubit>();
      await context.setLocale(Locale(code));
      await cubit.changeLanguage(code);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'settings.language_section'.tr(context: context),
          style: AppTextStyles.font15Bold,
        ),
        hSpace(8),
        Wrap(
          spacing: 8.w,
          children: [
            CustomChipWidget(
              label: 'common.arabic'.tr(context: context),
              isSelected: current == 'ar',
              onTap: () => select('ar'),
            ),
            CustomChipWidget(
              label: 'common.english'.tr(context: context),
              isSelected: current == 'en',
              onTap: () => select('en'),
            ),
          ],
        ),
      ],
    );
  }
}
