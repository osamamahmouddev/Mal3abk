import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/app_animations.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

/// Picks who is signing in: a player (phone code) or a venue owner/staff
/// member (email and password).
class AccountRoleSwitchWidget extends StatelessWidget {
  const AccountRoleSwitchWidget({
    required this.isOwner,
    required this.onChanged,
    super.key,
  });

  final bool isOwner;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'venue_auth.role.label'.tr(context: context),
      child: Container(
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          color: AppColors.tableHead,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.chipBorder),
        ),
        child: Row(
          children: [
            _RoleTab(
              icon: Icons.sports_soccer_rounded,
              label: 'venue_auth.role.player'.tr(context: context),
              selected: !isOwner,
              onTap: () => onChanged(false),
            ),
            _RoleTab(
              icon: Icons.stadium_rounded,
              label: 'venue_auth.role.owner'.tr(context: context),
              selected: isOwner,
              onTap: () => onChanged(true),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleTab extends StatelessWidget {
  const _RoleTab({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.white : AppColors.textBody;
    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (selected) return;
            HapticFeedback.selectionClick();
            onTap();
          },
          child: AnimatedContainer(
            duration: AppAnimations.duration(context, AppAnimations.base),
            curve: Curves.easeOutCubic,
            constraints: BoxConstraints(minHeight: 46.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? AppColors.brandNavy : AppColors.transparent,
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18.r, color: color),
                SizedBox(width: 6.w),
                Flexible(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font14Bold.copyWith(color: color),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
