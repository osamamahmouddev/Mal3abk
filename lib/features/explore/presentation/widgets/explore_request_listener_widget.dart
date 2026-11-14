import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../main_shell/presentation/widgets/main_shell_scope_widget.dart';
import '../cubit/explore_list_cubit.dart';

/// Runs the search another tab asked Explore for (the home "when do you want
/// to play?" card), whether Explore is already open or opens for it.
class ExploreRequestListenerWidget extends HookWidget {
  const ExploreRequestListenerWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final request = MainShellScopeWidget.exploreRequestOf(context);

    useEffect(() {
      if (request == null) return null;
      void apply() {
        final filter = request.value;
        if (filter == null) return;
        request.value = null;
        context.read<ExploreListCubit>().applyRequest(filter);
      }

      // After the frame: applying emits states other widgets rebuild on.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) apply();
      });
      request.addListener(apply);
      return () => request.removeListener(apply);
    }, [request]);

    return child;
  }
}
