import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'flying_heart_widget.dart';

/// Double tap anywhere on [child] to like it: a big heart pops where the
/// finger was and floats away (TikTok-style), and [onDoubleTap] runs. Single
/// taps still reach [child].
class DoubleTapHeartWidget extends HookWidget {
  const DoubleTapHeartWidget({
    required this.child,
    required this.onDoubleTap,
    this.heartSize = 90,
    super.key,
  });

  final Widget child;
  final VoidCallback onDoubleTap;
  final double heartSize;

  @override
  Widget build(BuildContext context) {
    final hearts = useState(<(int, Offset, double)>[]);
    final nextId = useRef(0);
    final lastDown = useRef(Offset.zero);
    final random = useMemoized(math.Random.new);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onDoubleTapDown: (details) => lastDown.value = details.localPosition,
      onDoubleTap: () {
        HapticFeedback.mediumImpact();
        final tilt = (random.nextDouble() - 0.5) * 0.6;
        hearts.value = [
          ...hearts.value,
          (nextId.value++, lastDown.value, tilt),
        ];
        onDoubleTap();
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(child: child),
          for (final (id, position, tilt) in hearts.value)
            Positioned(
              key: ValueKey(id),
              left: position.dx - heartSize / 2,
              top: position.dy - heartSize / 2,
              child: FlyingHeartWidget(
                size: heartSize,
                tilt: tilt,
                onDone: () => hearts.value = [
                  for (final heart in hearts.value)
                    if (heart.$1 != id) heart,
                ],
              ),
            ),
        ],
      ),
    );
  }
}
