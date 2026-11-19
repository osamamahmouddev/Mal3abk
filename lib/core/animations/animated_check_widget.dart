import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'animated_check_painter.dart';
import 'app_animations.dart';

/// A confirmation mark that draws itself, settles with a small pop and, with
/// [burst], ends on a "whistle": chalk strokes fly out of the ring once. Use
/// it for the moment something worked (proof sent, booking made), not for
/// decoration. One run of under a second; nothing loops.
class AnimatedCheckWidget extends HookWidget {
  const AnimatedCheckWidget({
    required this.color,
    this.size = 72,
    this.strokeWidth = 4,
    this.burst = true,
    super.key,
  });

  final Color color;
  final double size;
  final double strokeWidth;

  /// The chalk strokes after the check; off for small "ready" marks.
  final bool burst;

  /// The check itself; the burst takes the time after it.
  static const Duration checkDuration = Duration(milliseconds: 700);
  static const Duration burstDuration = Duration(milliseconds: 950);

  @override
  Widget build(BuildContext context) {
    final total = burst ? burstDuration : checkDuration;
    final controller = useAnimationController(
      duration: AppAnimations.duration(context, total),
    );
    useEffect(() {
      controller.forward();
      return null;
    }, const []);

    // The check keeps its own pace inside the longer run.
    final checkShare = checkDuration.inMilliseconds / total.inMilliseconds;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final t = controller.value;
        final progress = AppAnimations.standard.transform(
          (t / checkShare).clamp(0.0, 1.0),
        );
        final pop = 1 + 0.08 * (1 - (2 * progress - 1).abs());
        // Starts as the check's last leg lands.
        final burstProgress = burst
            ? ((t - checkShare * 0.8) / (1 - checkShare * 0.8)).clamp(0.0, 1.0)
            : 0.0;
        return Transform.scale(
          scale: pop,
          child: SizedBox.square(
            dimension: size,
            child: CustomPaint(
              painter: AnimatedCheckPainter(
                progress: progress,
                color: color,
                strokeWidth: strokeWidth,
              ),
              foregroundPainter: burst
                  ? WhistleBurstPainter(
                      progress: burstProgress,
                      color: color,
                      strokeWidth: strokeWidth * 0.75,
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}
