import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../styles/app_colors.dart';
import 'app_animations.dart';

/// One big heart, TikTok-style: it pops in under the finger tilted a little,
/// then floats up and fades out, and tells its parent when it is gone.
class FlyingHeartWidget extends HookWidget {
  const FlyingHeartWidget({
    required this.tilt,
    required this.onDone,
    this.size = 90,
    super.key,
  });

  /// Rotation in radians, varied per heart so repeated taps don't look stamped.
  final double tilt;
  final VoidCallback onDone;
  final double size;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: AppAnimations.duration(
        context,
        const Duration(milliseconds: 900),
      ),
    );
    useEffect(() {
      controller.forward().whenCompleteOrCancel(onDone);
      return null;
    }, const []);

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final t = controller.value;
          // 0–30%: pop in with an overshoot. 30–55%: hold. 55–100%: rise and fade.
          final scale = t < 0.3
              ? Curves.easeOutBack.transform(t / 0.3) * 1.15
              : t < 0.55
              ? 1.15 - 0.15 * ((t - 0.3) / 0.25)
              : 1.0 + 0.2 * ((t - 0.55) / 0.45);
          final rise = t < 0.55
              ? 0.0
              : Curves.easeIn.transform((t - 0.55) / 0.45);
          final opacity = t < 0.55 ? 1.0 : 1 - rise;
          return Transform.translate(
            offset: Offset(0, -size * 0.9 * rise),
            child: Transform.rotate(
              angle: tilt,
              child: Transform.scale(
                scale: scale,
                child: Opacity(opacity: opacity.clamp(0, 1), child: child),
              ),
            ),
          );
        },
        child: Icon(
          Icons.favorite,
          size: size,
          color: AppColors.brandRed,
          shadows: [
            Shadow(
              color: AppColors.black.withValues(alpha: 0.25),
              blurRadius: 12,
            ),
          ],
        ),
      ),
    );
  }
}
