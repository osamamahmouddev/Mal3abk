import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../animations/app_animations.dart';

/// Gently shrinks [child] while a finger is down. Only this widget rebuilds.
class PressScaleWidget extends HookWidget {
  const PressScaleWidget({
    required this.child,
    this.enabled = true,
    this.scale = AppAnimations.pressedScale,
    super.key,
  });

  final Widget child;
  final bool enabled;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final isPressed = useState(false);
    if (!enabled) return child;

    return Listener(
      onPointerDown: (_) => isPressed.value = true,
      onPointerUp: (_) => isPressed.value = false,
      onPointerCancel: (_) => isPressed.value = false,
      child: AnimatedScale(
        scale: isPressed.value ? scale : 1,
        duration: AppAnimations.duration(context, AppAnimations.fast),
        curve: AppAnimations.standard,
        child: child,
      ),
    );
  }
}
