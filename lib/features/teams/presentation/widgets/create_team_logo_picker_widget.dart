import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/initials_avatar_widget.dart';

class CreateTeamLogoPickerWidget extends StatelessWidget {
  const CreateTeamLogoPickerWidget({
    required this.initials,
    super.key,
    this.onUpload,
  });

  final String initials;
  final VoidCallback? onUpload;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InitialsAvatarWidget(
          initials: initials,
          color: AppColors.brandRed,
          size: 76,
          textStyle: AppTextStyles.font24Bold,
        ),
        vSpace(14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'teams.create.logo'.tr(context: context),
              style: AppTextStyles.font15Bold,
            ),
            hSpace(12),
            GestureDetector(
              onTap: onUpload,
              child: Text(
                'teams.create.upload'.tr(context: context),
                style: AppTextStyles.font13SemiBold.copyWith(
                  color: AppColors.brandNavy,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
