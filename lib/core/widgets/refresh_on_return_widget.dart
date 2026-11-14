import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Calls [onReturn] each time the page comes back into view: a screen pushed
/// on top of it was popped, or its tab in the main shell was selected again.
/// Not called on the first build.
///
/// Use it on list pages whose data other screens change (leaving or closing
/// a team, joining one), so they never show what is no longer true.
class RefreshOnReturnWidget extends HookWidget {
  const RefreshOnReturnWidget({
    required this.onReturn,
    required this.child,
    super.key,
  });

  final VoidCallback onReturn;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Both rebuild this widget when they change: the route becoming the top
    // of its navigator, and the shell muting tickers of hidden tabs.
    final visible =
        (ModalRoute.of(context)?.isCurrent ?? true) &&
        // `of` works on every Flutter we build with: the TestFlight workflow
        // pins 3.38, which has no `valuesOf`, and newer SDKs only deprecate it.
        // ignore: deprecated_member_use
        TickerMode.of(context);
    final wasVisible = useRef(visible);

    useEffect(() {
      if (visible && !wasVisible.value) {
        // After the frame: reloading may emit states other widgets rebuild on.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) onReturn();
        });
      }
      wasVisible.value = visible;
      return null;
    }, [visible]);

    return child;
  }
}
