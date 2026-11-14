import 'package:flutter/widgets.dart';

import 'app_animations.dart';

/// Swaps a tab's content with a short fade and a slide in the direction the
/// player moved (towards a later tab slides in from the end side).
class TabContentSwitcherWidget extends StatelessWidget {
  const TabContentSwitcherWidget({
    required this.index,
    required this.child,
    super.key,
  });

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return AnimatedSwitcher(
      duration: AppAnimations.duration(context, AppAnimations.slow),
      switchInCurve: AppAnimations.standard,
      switchOutCurve: AppAnimations.exit,
      layoutBuilder: (current, previous) => Stack(
        alignment: Alignment.topCenter,
        children: [...previous, ?current],
      ),
      transitionBuilder: (child, animation) {
        final incoming = child.key == ValueKey(index);
        final dx = (incoming ? 0.08 : -0.08) * (rtl ? -1 : 1);
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(dx, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: KeyedSubtree(key: ValueKey(index), child: child),
    );
  }
}
