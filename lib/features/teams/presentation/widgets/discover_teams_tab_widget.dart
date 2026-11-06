import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/widgets/custom_search_field_widget.dart';
import '../cubit/discover_teams_cubit.dart';
import 'discover_teams_bloc_builder.dart';

class DiscoverTeamsTabWidget extends HookWidget {
  const DiscoverTeamsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final debounce = useRef<Timer?>(null);
    useEffect(
      () =>
          () => debounce.value?.cancel(),
      const [],
    );

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
          child: CustomSearchFieldWidget(
            hintText: 'teams.list.search_hint'.tr(context: context),
            onChanged: (value) {
              debounce.value?.cancel();
              debounce.value = Timer(
                const Duration(milliseconds: 400),
                () => context.read<DiscoverTeamsCubit>().load(query: value),
              );
            },
          ),
        ),
        const Expanded(child: DiscoverTeamsBlocBuilder()),
      ],
    );
  }
}
