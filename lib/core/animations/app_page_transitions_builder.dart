import 'package:flutter/material.dart';

import 'app_animations.dart';

/// How a pushed screen enters: it fades in while sliding a short way from the
/// reading direction's end (right in English, left in Arabic), and the screen
/// underneath drifts back and dims slightly. Short travel keeps it calm;
/// there is no full-width slide.
///
/// Used for every route on Android. iOS keeps Cupertino's slide, which is what
/// carries the edge-swipe-back gesture.
class AppPageTransitionsBuilder extends PageTransitionsBuilder {
  const AppPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (AppAnimations.isReduced(context)) {
      return FadeTransition(opacity: animation, child: child);
    }

    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final towardStart = isRtl ? 1.0 : -1.0;

    final enter = CurvedAnimation(
      parent: animation,
      curve: AppAnimations.emphasized,
      reverseCurve: AppAnimations.exit,
    );
    final cover = CurvedAnimation(
      parent: secondaryAnimation,
      curve: AppAnimations.standard,
      reverseCurve: AppAnimations.exit,
    );

    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(0, 0.6, curve: Curves.easeOut),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(-towardStart * AppAnimations.pageOffset, 0),
          end: Offset.zero,
        ).animate(enter),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: Offset(towardStart * AppAnimations.pageOffset / 2, 0),
          ).animate(cover),
          child: FadeTransition(
            opacity: Tween<double>(begin: 1, end: 0.92).animate(cover),
            child: child,
          ),
        ),
      ),
    );
  }
}
