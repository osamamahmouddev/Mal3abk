import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/routes/navigation_logger_observer.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_motion.dart';
import '../../../../core/widgets/main_nav_bar_widget.dart';
import '../widgets/main_shell_scope_widget.dart';
import '../widgets/main_tab_navigator_widget.dart';

/// Stateful shell hosting every in-app screen: one nested [Navigator] per tab,
/// kept alive in an [IndexedStack] so each tab preserves its stack and scroll.
/// Tabs are built lazily on first visit.
class MainShellScreen extends HookWidget {
  const MainShellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const tabs = MainNavBarWidget.tabRoutes;
    final currentIndex = useState(MainShellScopeWidget.homeTab);
    final visitedTabs = useRef(<int>{MainShellScopeWidget.homeTab});
    final canPopTabs = useState(List<bool>.filled(tabs.length, false));
    final navigatorKeys = useMemoized(
      () => List.generate(tabs.length, (_) => GlobalKey<NavigatorState>()),
    );

    void updateTabCanPop(int index) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final canPop = navigatorKeys[index].currentState?.canPop() ?? false;
        if (canPopTabs.value[index] != canPop) {
          final updated = List<bool>.from(canPopTabs.value);
          updated[index] = canPop;
          canPopTabs.value = updated;
        }
      });
    }

    final observers = useMemoized(
      () => List.generate(
        tabs.length,
        (i) => NavigationLoggerObserver(
          onNavigationChanged: () => updateTabCanPop(i),
        ),
      ),
    );
    final tabFade = useAnimationController(
      duration: AppMotion.medium,
      initialValue: 1,
    );

    void switchTab(int index) {
      if (index == currentIndex.value) {
        navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
        return;
      }
      visitedTabs.value.add(index);
      currentIndex.value = index;
      tabFade.forward(from: 0);
    }

    final isInnerScreen = canPopTabs.value[currentIndex.value];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        final navigator = navigatorKeys[currentIndex.value].currentState;
        if (navigator != null && navigator.canPop()) {
          navigator.pop();
        } else if (currentIndex.value != MainShellScopeWidget.homeTab) {
          currentIndex.value = MainShellScopeWidget.homeTab;
        } else {
          SystemNavigator.pop();
        }
      },
      child: MainShellScopeWidget(
        onSwitchTab: switchTab,
        child: Scaffold(
          backgroundColor: AppColors.pageBackground,
          bottomNavigationBar: isInnerScreen
              ? null
              : MainNavBarWidget(
                  currentIndex: currentIndex.value,
                  onTap: switchTab,
                ),
          body: FadeTransition(
            opacity: tabFade,
            child: IndexedStack(
              index: currentIndex.value,
              children: [
                for (var i = 0; i < tabs.length; i++)
                  if (visitedTabs.value.contains(i))
                    MainTabNavigatorWidget(
                      navigatorKey: navigatorKeys[i],
                      initialRoute: tabs[i],
                      observer: observers[i],
                      isActive: i == currentIndex.value,
                    )
                  else
                    const Offstage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
