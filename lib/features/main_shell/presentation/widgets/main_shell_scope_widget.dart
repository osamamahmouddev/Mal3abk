import 'package:flutter/material.dart';

/// Exposes tab switching to every screen nested inside the main shell.
class MainShellScopeWidget extends InheritedWidget {
  const MainShellScopeWidget({
    required this.onSwitchTab,
    required super.child,
    super.key,
  });

  final ValueChanged<int> onSwitchTab;

  static const int homeTab = 0;
  static const int exploreTab = 1;
  static const int bookingsTab = 2;
  static const int teamsTab = 3;
  static const int profileTab = 4;

  /// Switches to [index] without registering a rebuild dependency.
  static void switchTab(BuildContext context, int index) => context
      .getInheritedWidgetOfExactType<MainShellScopeWidget>()
      ?.onSwitchTab(index);

  @override
  bool updateShouldNotify(MainShellScopeWidget oldWidget) => false;
}
