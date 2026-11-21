import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/extensions/place_name_extension.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/initials_avatar_widget.dart';
import '../../data/models/team_invite_preview_model.dart';

/// The team an invite code leads to: name, place, how full it is, and a note
/// when the player is already in it or it has no room.
class TeamInvitePreviewCardWidget extends StatelessWidget {
  const TeamInvitePreviewCardWidget({required this.preview, super.key});

  final TeamInvitePreviewModel preview;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final note = preview.isAlreadyMember
        ? 'errors.teams.player_already_in_team'
        : preview.isFull
        ? 'errors.teams.roster_full'
        : null;
    return CustomCardWidget(
      padding: EdgeInsets.all(14.r),
      child: Row(
        children: [
          InitialsAvatarWidget(
            initials: preview.name.initials,
            color: AppColors.brandRed,
            size: 48,
            textStyle: AppTextStyles.font16Bold,
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  preview.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font16Bold,
                ),
                hSpace(4),
                Text(
                  [
                    context.placeName(
                      city: preview.city,
                      area: preview.district,
                    ),
                    'teams.join.members_count'.tr(
                      context: context,
                      args: [
                        preview.memberCount.toLocalizedDigits(lang),
                        preview.maxMembers.toLocalizedDigits(lang),
                      ],
                    ),
                  ].join(' · '),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                if (note != null) ...[
                  hSpace(6),
                  Text(
                    note.tr(context: context),
                    style: AppTextStyles.font12Bold.copyWith(
                      color: AppColors.goldDark,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
