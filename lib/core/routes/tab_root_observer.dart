import 'package:flutter/widgets.dart';

/// Tracks whether a tab navigator is showing its root page, so the main shell
/// can hide the nav bar on pushed screens. Dialogs and sheets are ignored.
class TabRootObserver extends NavigatorObserver {
  final ValueNotifier<bool> isAtRoot = ValueNotifier(true);
  int pageDepth = 0;

  void updateDepth(Route<dynamic> route, int delta) {
    if (route is! PageRoute) return;
    pageDepth += delta;
    isAtRoot.value = pageDepth <= 1;
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      updateDepth(route, 1);

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      updateDepth(route, -1);

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      updateDepth(route, -1);

  void dispose() => isAtRoot.dispose();
}
