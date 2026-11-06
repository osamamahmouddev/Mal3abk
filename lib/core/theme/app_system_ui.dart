import 'package:flutter/services.dart';

import '../styles/app_colors.dart';

/// Status bar styles. Only status bar fields are set so the Android
/// navigation bar keeps its default look.
class AppSystemUi {
  const AppSystemUi._();

  /// Dark icons for light pages (app-wide default).
  static const SystemUiOverlayStyle onLight = SystemUiOverlayStyle(
    statusBarColor: AppColors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );

  /// White icons for navy heroes drawn under the status bar.
  static const SystemUiOverlayStyle onDark = SystemUiOverlayStyle(
    statusBarColor: AppColors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );
}
