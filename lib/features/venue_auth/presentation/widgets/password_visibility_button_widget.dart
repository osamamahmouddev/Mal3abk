import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';

class PasswordVisibilityButtonWidget extends StatelessWidget {
  const PasswordVisibilityButtonWidget({
    required this.obscured,
    required this.onTap,
    super.key,
  });

  final bool obscured;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      tooltip:
          (obscured ? 'venue_auth.show_password' : 'venue_auth.hide_password')
              .tr(context: context),
      icon: Icon(
        obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        size: 20.r,
        color: AppColors.textMuted,
      ),
    );
  }
}
