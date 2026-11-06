import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes.dart';
import '../../data/models/explore_filter_model.dart';
import '../cubit/explore_list_cubit.dart';
import '../cubit/explore_list_state.dart';
import 'explore_search_summary_widget.dart';

/// Opens the filters with the current ones and applies what comes back.
class ExploreSearchSummaryBlocBuilder extends StatelessWidget {
  const ExploreSearchSummaryBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreListCubit, ExploreListState>(
      builder: (context, _) {
        final cubit = context.read<ExploreListCubit>();
        return ExploreSearchSummaryWidget(
          activeFilters: cubit.filter.activeCount,
          onOpenFilters: () async {
            final next = await Navigator.of(context).pushNamed(
              AppRoutes.filtersAndSort,
              arguments: (cubit.filter, cubit.near != null),
            );
            if (next is ExploreFilterModel) await cubit.applyFilter(next);
          },
        );
      },
    );
  }
}
