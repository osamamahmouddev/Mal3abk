import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../animations/app_animations.dart';
import '../styles/app_colors.dart';

/// The icon of an empty or error state, set in soft layered circles with two
/// brand accent dots so a blank screen still feels designed.
///
/// When it appears, the two dots run one lap around the circle, like a ball
/// dribbled round a training cone, the red one a beat behind the gold, and
/// settle where they rest. Once, about a second; still with reduced motion.
class StateIllustrationWidget extends HookWidget {
  const StateIllustrationWidget({required this.icon, super.key});

  final Widget icon;

  static const Duration orbitDuration = Duration(milliseconds: 1100);

  static const Curve _gold = Interval(0, 0.85, curve: Curves.easeOutCubic);
  static const Curve _red = Interval(0.15, 1, curve: Curves.easeOutCubic);

  @override
  Widget build(BuildContext context) {
    final size = 128.r;
    final orbit = useAnimationController(
      duration: AppAnimations.duration(context, orbitDuration),
    );
    useEffect(() {
      orbit.forward();
      return null;
    }, const []);

    /// A dot layer turned so it ends exactly where it rests after one lap.
    Widget lap(Curve curve, Widget dot) => AnimatedBuilder(
      animation: orbit,
      builder: (context, child) => Transform.rotate(
        angle: -2 * math.pi * (1 - curve.transform(orbit.value)),
        child: child,
      ),
      child: SizedBox.square(
        dimension: size,
        child: Stack(children: [dot]),
      ),
    );

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: AppColors.lightSurface,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 88.r,
            height: 88.r,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.navyShadow12,
                  blurRadius: 24.r,
                  offset: Offset(0, 8.h),
                ),
              ],
            ),
            child: Center(
              child: SizedBox.square(
                dimension: 38.r,
                child: FittedBox(
                  child: IconTheme(
                    data: const IconThemeData(color: AppColors.brandNavy),
                    child: icon,
                  ),
                ),
              ),
            ),
          ),
          RepaintBoundary(
            child: Stack(
              children: [
                lap(
                  _gold,
                  PositionedDirectional(
                    top: 14.r,
                    end: 12.r,
                    child: Container(
                      width: 12.r,
                      height: 12.r,
                      decoration: const BoxDecoration(
                        color: AppColors.accentGold,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                lap(
                  _red,
                  PositionedDirectional(
                    bottom: 20.r,
                    start: 8.r,
                    child: Container(
                      width: 8.r,
                      height: 8.r,
                      decoration: const BoxDecoration(
                        color: AppColors.brandRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
