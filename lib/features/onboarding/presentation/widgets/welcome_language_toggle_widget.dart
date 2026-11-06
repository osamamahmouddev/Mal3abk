import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

/// English / عربي switch on the dark welcome screen. Before sign-in the choice
/// is only local; it goes to the account with the profile.
class WelcomeLanguageToggleWidget extends StatelessWidget {
  const WelcomeLanguageToggleWidget({super.key});

  static const List<(String, String)> languages = [
    ('en', 'English'),
    ('ar', 'عربي'),
  ];

  @override
  Widget build(BuildContext context) {
    final current = context.locale.languageCode;
    return Container(
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        color: AppColors.white10,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (code, label) in languages)
            GestureDetector(
              onTap: () {
                if (code == current) return;
                HapticFeedback.selectionClick();
                context.setLocale(Locale(code));
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: code == current
                      ? AppColors.white
                      : AppColors.transparent,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Text(
                  label,
                  style: AppTextStyles.font12Bold.copyWith(
                    color: code == current
                        ? AppColors.brandNavy
                        : AppColors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
