import 'package:flutter/material.dart';

import '../../../explore/data/models/explore_filter_model.dart';

/// Exposes tab switching to every screen nested inside the main shell.
class MainShellScopeWidget extends InheritedWidget {
  const MainShellScopeWidget({
    required this.onSwitchTab,
    required this.exploreRequest,
    required super.child,
    super.key,
  });

  final ValueChanged<int> onSwitchTab;

  /// A search another tab asked Explore to run (the home "when do you want
  /// to play?" card). Explore applies it and clears it.
  final ValueNotifier<ExploreFilterModel?> exploreRequest;

  static const int homeTab = 0;
  static const int exploreTab = 1;
  static const int bookingsTab = 2;
  static const int teamsTab = 3;
  static const int profileTab = 4;

  static MainShellScopeWidget? _of(BuildContext context) =>
      context.getInheritedWidgetOfExactType<MainShellScopeWidget>();

  /// Switches to [index] without registering a rebuild dependency.
  static void switchTab(BuildContext context, int index) =>
      _of(context)?.onSwitchTab(index);

  /// Opens Explore searching with [filter]'s day and kick-off hour.
  static void openExplore(BuildContext context, ExploreFilterModel filter) {
    final scope = _of(context);
    if (scope == null) return;
    scope.exploreRequest.value = filter;
    scope.onSwitchTab(exploreTab);
  }

  /// The pending Explore search, for the Explore screen to apply.
  static ValueNotifier<ExploreFilterModel?>? exploreRequestOf(
    BuildContext context,
  ) => _of(context)?.exploreRequest;

  @override
  bool updateShouldNotify(MainShellScopeWidget oldWidget) => false;
}
