import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../styles/app_motion.dart';

/// Fades and slides [child] up once when it first appears.
/// [index] staggers siblings. Driven by transitions, so it never rebuilds.
class FadeSlideInWidget extends HookWidget {
  const FadeSlideInWidget({required this.child, this.index = 0, super.key});

  final Widget child;
  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: AppMotion.slow);
    final curved = useMemoized(
      () => CurvedAnimation(parent: controller, curve: AppMotion.standard),
    );
    final slide = useMemoized(
      () => Tween(
        begin: const Offset(0, AppMotion.entranceOffset),
        end: Offset.zero,
      ).animate(curved),
    );

    useEffect(() {
      final step = index.clamp(0, AppMotion.maxStaggerIndex);
      final timer = Timer(AppMotion.staggerStep * step, controller.forward);
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
