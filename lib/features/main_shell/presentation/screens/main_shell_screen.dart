import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/routes/navigation_logger_observer.dart';
import '../../../../core/routes/tab_root_observer.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/animations/app_animations.dart';
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
    final navigatorKeys = useMemoized(
      () => List.generate(tabs.length, (_) => GlobalKey<NavigatorState>()),
    );
    final observers = useMemoized(
      () => List.generate(tabs.length, (_) => NavigationLoggerObserver()),
    );
    final rootObservers = useMemoized(
      () => List.generate(tabs.length, (_) => TabRootObserver()),
    );
    useEffect(
      () => () {
        for (final observer in rootObservers) {
          observer.dispose();
        }
      },
      const [],
    );
    // Figma shows the nav bar only on tab roots; pushed screens go full height.
    final isAtTabRoot = useValueListenable(
      rootObservers[currentIndex.value].isAtRoot,
    );
    final tabFade = useAnimationController(
      duration: AppAnimations.duration(context, AppAnimations.slow),
      initialValue: 1,
    );
    final tabCurve = useMemoized(
      () => CurvedAnimation(parent: tabFade, curve: AppAnimations.standard),
    );
    final tabRise = useMemoized(
      () => Tween<Offset>(
        begin: const Offset(0, AppAnimations.entranceOffset / 2),
        end: Offset.zero,
      ).animate(tabCurve),
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
          bottomNavigationBar: isAtTabRoot
              ? MainNavBarWidget(
                  currentIndex: currentIndex.value,
                  onTap: switchTab,
                )
              : null,
          body: FadeTransition(
            opacity: tabCurve,
            child: SlideTransition(
              position: tabRise,
              child: IndexedStack(
                index: currentIndex.value,
                children: [
                  for (var i = 0; i < tabs.length; i++)
                    if (visitedTabs.value.contains(i))
                      MainTabNavigatorWidget(
                        navigatorKey: navigatorKeys[i],
                        initialRoute: tabs[i],
                        observer: observers[i],
                        rootObserver: rootObservers[i],
                        isActive: i == currentIndex.value,
                      )
                    else
                      const Offstage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
