import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_font_family.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    const defaultBorderRadius = BorderRadius.all(Radius.circular(16));

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.brandPrimary,
        primary: AppColors.brandPrimary,
        secondary: AppColors.brandRed,
        surface: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.pageBackground,
      canvasColor: AppColors.white,
      cardColor: AppColors.cardBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.pageBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(
            backgroundColor: AppColors.pageBackground,
          ),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      useMaterial3: true,
      fontFamily: AppFontFamily.ibmPlexSansArabic,
    );
  }
}
