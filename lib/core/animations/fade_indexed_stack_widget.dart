import 'package:flutter/widgets.dart';

import 'app_animations.dart';

/// Like [IndexedStack] (every child keeps its state and scroll), but the
/// shown child fades and slides in instead of snapping.
class FadeIndexedStackWidget extends StatelessWidget {
  const FadeIndexedStackWidget({
    required this.index,
    required this.children,
    super.key,
  });

  final int index;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final duration = AppAnimations.duration(context, AppAnimations.slow);
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return Stack(
      fit: StackFit.expand,
      children: [
        for (final (i, child) in children.indexed)
          IgnorePointer(
            ignoring: i != index,
            child: AnimatedOpacity(
              duration: duration,
              curve: AppAnimations.standard,
              opacity: i == index ? 1 : 0,
              child: AnimatedSlide(
                duration: duration,
                curve: AppAnimations.standard,
                offset: i == index
                    ? Offset.zero
                    : Offset((i < index ? -0.06 : 0.06) * (rtl ? -1 : 1), 0),
                // Only the hidden child's own animations pause. Wrapping the
                // fade too would freeze it at full opacity, and the old tab
                // would keep showing through the new one.
                child: TickerMode(
                  enabled: i == index,
                  child: ExcludeSemantics(excluding: i != index, child: child),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
