import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_font_family.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    const defaultBorderRadius = BorderRadius.all(Radius.circular(12));

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.brandPrimary),
      scaffoldBackgroundColor: AppColors.pageBackground,
      canvasColor: AppColors.white,
      cardColor: AppColors.cardBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
      ),
      useMaterial3: true,
      fontFamily: AppFontFamily.ibmPlexSansArabic,
    );
  }
}
