import 'package:flutter/animation.dart';

import '../animations/app_animations.dart';

/// Short names for the shared motion values in [AppAnimations], which is where
/// durations and curves are defined. Prefer [AppAnimations] in new code.
class AppMotion {
  const AppMotion._();

  static const Duration fast = AppAnimations.fast;
  static const Duration medium = AppAnimations.base;
  static const Duration slow = AppAnimations.slow;
  static const Duration staggerStep = AppAnimations.staggerStep;

  /// Items past this index enter together instead of waiting their turn.
  static const int maxStaggerIndex = AppAnimations.maxStaggerIndex;

  static const Curve standard = AppAnimations.standard;

  /// With a small overshoot: checkboxes, radios and the nav icon pop into place.
  static const Curve emphasized = AppAnimations.spring;

  static const double pressedScale = AppAnimations.pressedScale;
  static const double entranceOffset = AppAnimations.entranceOffset;
}
