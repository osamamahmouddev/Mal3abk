import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'animated_check_painter.dart';
import 'app_animations.dart';

/// A confirmation mark that draws itself, then settles with a small pop. Use it
/// for the moment something worked (proof sent, booking made), not for
/// decoration.
class AnimatedCheckWidget extends HookWidget {
  const AnimatedCheckWidget({
    required this.color,
    this.size = 72,
    this.strokeWidth = 4,
    super.key,
  });

  final Color color;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: AppAnimations.duration(
        context,
        const Duration(milliseconds: 700),
      ),
    );
    useEffect(() {
      controller.forward();
      return null;
    }, const []);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final progress = AppAnimations.standard.transform(controller.value);
        final pop = 1 + 0.08 * (1 - (2 * progress - 1).abs());
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
            ),
          ),
        );
      },
    );
  }
}
