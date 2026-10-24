import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Official Brand Palette from Figma & Brand Kit
  // Primary Navy (Dark Header / Buttons / Active elements in Figma: #0F1B3D & #0F172A)
  static const Color brandNavy = Color(0xFF0F1B3D); 
  static const Color brandPrimary = Color(0xFF0F1B3D);
  static const Color brandPrimaryDark = Color(0xFF071832);
  static const Color brandPrimaryLight = Color(0xFF1B2A52);

  // Accent Red (CTA buttons / Cancel / Urgent badges: #D63B2F)
  static const Color brandRed = Color(0xFFD63B2F);
  static const Color secondary = brandRed;
  static const Color redLight = Color(0xFFFDECEA);
  static const Color redBorder = Color(0xFFF3C4BF);
  static const Color redDark = Color(0xFF8A1F17);
  static const Color redText = Color(0xFFA8261C);

  // Status Green / Grass pitch (#1B6E3E, #287D4C, #2E8B55)
  static const Color successGreen = Color(0xFF1B6E3E);
  static const Color successLight = Color(0xFFE5F5EB);
  static const Color successBorder = Color(0xFFC3E8D0);
  static const Color pitchGreen = Color(0xFF287D4C);
  static const Color pitchGreenDark = Color(0xFF1E603A);

  // Achievement / Warning Gold (#F5B62B, #FEF3D6, #7A4D00)
  static const Color accentGold = Color(0xFFF5B62B);
  static const Color goldLight = Color(0xFFFEF3D6);
  static const Color goldDark = Color(0xFF7A4D00);
  static const Color goldBorder = Color(0xFFF8E3AD);

  // Neutral scale & Surfaces
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;

  // Backgrounds
  static const Color pageBackground = Color(0xFFF3F5F9);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color lightGrayBackground = Color(0xFFF4F5F7);
  static const Color lightSurface = Color(0xFFEEF0F5);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A); // Main dark text
  static const Color textSecondary = Color(0xFF5B6475); // Muted / subtitle text
  static const Color textMuted = Color(0xFF737D91);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Border & Divider Colors
  static const Color border = Color(0xFFE4E7EC);
  static const Color borderCard = Color(0xFFEDF0F5);
  static const Color borderInput = Color(0xFFC9CFD9);
  static const Color focusedBorder = Color(0xFF0F1B3D);

  // Status mapping
  static const Color success = successGreen;
  static const Color error = brandRed;
  static const Color warning = accentGold;
  static const Color info = Color(0xFF3498DB);

  // Backward compatibility neutrals
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
}
