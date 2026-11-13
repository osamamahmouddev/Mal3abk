import 'package:flutter/widgets.dart';

/// The app's motion language: one set of durations and curves, so every
/// transition feels like it belongs to the same product.
///
/// - Things the player causes (a tap, a tab switch) answer fast: [fast] to
///   [base].
/// - Things that arrive (a screen, a list, a loaded result) take their time and
///   decelerate into place: [slow], [page].
/// - Nothing bounces except a confirmation ([spring]).
///
/// Every widget that animates asks [AppAnimations.duration] for its duration,
/// which is zero when the system's "remove animations" / reduce-motion setting
/// is on.
abstract final class AppAnimations {
  // Durations ---------------------------------------------------------------

  /// Feedback under a finger: press scale, ripples, toggles.
  static const Duration fast = Duration(milliseconds: 120);

  /// Small state changes: a chip, a nav item, a color.
  static const Duration base = Duration(milliseconds: 220);

  /// Content arriving: list items, a section replacing its skeleton.
  static const Duration slow = Duration(milliseconds: 360);

  /// A whole screen entering.
  static const Duration page = Duration(milliseconds: 380);

  /// A number counting up to its value.
  static const Duration count = Duration(milliseconds: 700);

  /// Delay between siblings entering one after another.
  static const Duration staggerStep = Duration(milliseconds: 55);

  /// Items past this index enter together instead of waiting their turn, so a
  /// long list never feels slow.
  static const int maxStaggerIndex = 6;

  // Curves ------------------------------------------------------------------

  /// Default for anything entering or moving: quick start, long soft landing.
  static const Curve standard = Cubic(0.2, 0, 0, 1);

  /// Entering with more character (nav pill, sheets).
  static const Curve emphasized = Cubic(0.05, 0.7, 0.1, 1);

  /// Leaving: starts slow and gets out of the way.
  static const Curve exit = Cubic(0.3, 0, 0.8, 0.15);

  /// A confirmation settling with a small overshoot.
  static const Curve spring = Curves.easeOutBack;

  // Distances ---------------------------------------------------------------

  /// How far content travels while fading in, as a fraction of its own size.
  static const double entranceOffset = 0.06;

  /// Horizontal travel of a pushed screen, as a fraction of its width.
  static const double pageOffset = 0.08;

  /// Scale of a pressed control.
  static const double pressedScale = 0.97;

  // Reduced motion ----------------------------------------------------------

  /// True when the player turned animations off in the system settings.
  static bool isReduced(BuildContext context) =>
      MediaQuery.maybeDisableAnimationsOf(context) ?? false;

  /// [normal], or zero when animations are off.
  static Duration duration(BuildContext context, Duration normal) =>
      isReduced(context) ? Duration.zero : normal;

  /// How long sibling number [index] waits before entering.
  static Duration staggerDelay(int index) =>
      staggerStep * index.clamp(0, maxStaggerIndex);
}
