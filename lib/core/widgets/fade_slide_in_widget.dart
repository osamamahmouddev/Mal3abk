import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../animations/app_animations.dart';

/// Fades and slides [child] up once when it first appears.
/// [index] staggers siblings. Driven by transitions, so it never rebuilds.
/// With animations turned off in the system settings it shows [child] at once.
class FadeSlideInWidget extends HookWidget {
  const FadeSlideInWidget({required this.child, this.index = 0, super.key});

  final Widget child;
  final int index;

  @override
  Widget build(BuildContext context) {
    final reduced = AppAnimations.isReduced(context);
    final controller = useAnimationController(duration: AppAnimations.slow);
    final curved = useMemoized(
      () => CurvedAnimation(parent: controller, curve: AppAnimations.standard),
    );
    final slide = useMemoized(
      () => Tween(
        begin: const Offset(0, AppAnimations.entranceOffset),
        end: Offset.zero,
      ).animate(curved),
    );

    useEffect(() {
      if (reduced) {
        controller.value = 1;
        return curved.dispose;
      }
      final timer = Timer(
        AppAnimations.staggerDelay(index),
        controller.forward,
      );
      return () {
        timer.cancel();
        curved.dispose();
      };
    }, const []);

    return FadeTransition(
      opacity: curved,
      child: SlideTransition(position: slide, child: child),
    );
  }
}
