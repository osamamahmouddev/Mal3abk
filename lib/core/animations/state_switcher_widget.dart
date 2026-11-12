import 'package:flutter/widgets.dart';

import 'app_animations.dart';

/// Cross-fades between the states of a section (loading, empty, loaded,
/// error) instead of swapping them in one frame: the old state fades out while
/// the new one fades in and settles up a few pixels.
///
/// Pass [stateKey] as something that changes when the *kind* of state changes
/// (for example `state.runtimeType`), not on every new emission, so a
/// refreshed list does not re-animate.
class StateSwitcherWidget extends StatelessWidget {
  const StateSwitcherWidget({
    required this.stateKey,
    required this.child,
    super.key,
  });

  final Object stateKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppAnimations.duration(context, AppAnimations.slow),
      reverseDuration: AppAnimations.duration(context, AppAnimations.base),
      switchInCurve: AppAnimations.standard,
      switchOutCurve: AppAnimations.exit,
      // Fill the space when it is bounded (a full-screen list or a centered
      // empty state); take the content's height inside a scrolling feed.
      layoutBuilder: (current, previous) => LayoutBuilder(
        builder: (context, constraints) => Stack(
          alignment: AlignmentDirectional.topStart,
          fit: constraints.hasBoundedHeight ? StackFit.expand : StackFit.loose,
          children: [...previous, ?current],
        ),
      ),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, AppAnimations.entranceOffset / 2),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
      child: KeyedSubtree(key: ValueKey(stateKey), child: child),
    );
  }
}
