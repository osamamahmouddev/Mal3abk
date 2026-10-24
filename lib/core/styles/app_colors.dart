import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Official Brand Palette from Malabak Logo Kit
  static const Color brandNavy = Color(0xFF071832); // Primary Navy
  static const Color brandRed = Color(0xFFEB4F42);  // Accent Red
  static const Color brandGold = Color(0xFFF6B326); // Achievement Gold

  // Brand primary set to Navy (#071832)
  static const Color brandPrimary = brandNavy;
  static const Color brandPrimaryDark = Color(0xFF040F20);
  static const Color brandPrimaryLight = Color(0xFF132B50);

  // Secondary / Accent
  static const Color secondary = brandRed;
  static const Color secondaryLight = Color(0xFFFFECEB);
  static const Color accentGold = brandGold;

  // Primary navy scale
  static const Color primary50 = Color(0xFFEDF2F8);
  static const Color primary100 = Color(0xFFD3E0EE);
  static const Color primary200 = Color(0xFFA6C0DD);
  static const Color primary300 = Color(0xFF6E9BC7);
  static const Color primary400 = Color(0xFF3B72A8);
  static const Color primary500 = Color(0xFF071832);
  static const Color primary600 = Color(0xFF06142A);
  static const Color primary700 = Color(0xFF051022);
  static const Color primary800 = Color(0xFF040C1A);
  static const Color primary900 = Color(0xFF02070F);

  // Neutral scale
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color pageBackground = Color(0xFFF8F9FA);
  static const Color cardBackground = Color(0xFFFFFFFF);

  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE5E5E5);
  static const Color neutral300 = Color(0xFFD4D4D4);
  static const Color neutral400 = Color(0xFFA3A3A3);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral600 = Color(0xFF525252);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral800 = Color(0xFF262626);
  static const Color neutral900 = Color(0xFF171717);

  // Text colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textMuted = Color(0xFF9E9E9E);

  // Border & Divider
  static const Color border = Color(0xFFE0E0E0);
  static const Color focusedBorder = brandNavy;

  // Status colors
  static const Color success = Color(0xFF2ECC71);
  static const Color error = brandRed;
  static const Color warning = brandGold;
  static const Color info = Color(0xFF3498DB);
}
