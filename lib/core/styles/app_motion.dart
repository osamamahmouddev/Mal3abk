import 'package:flutter/animation.dart';

/// Central animation durations and curves.
class AppMotion {
  const AppMotion._();

  static const Duration fast = Duration(milliseconds: 120);
  static const Duration medium = Duration(milliseconds: 200);
  static const Duration slow = Duration(milliseconds: 320);
  static const Duration staggerStep = Duration(milliseconds: 50);

  /// Items past this index enter together instead of waiting their turn.
  static const int maxStaggerIndex = 6;

  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeOutBack;

  static const double pressedScale = 0.97;
  static const double entranceOffset = 0.08;
}
