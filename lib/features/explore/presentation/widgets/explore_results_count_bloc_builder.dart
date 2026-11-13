import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/animations/count_up_text_widget.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../cubit/explore_list_cubit.dart';
import '../cubit/explore_list_state.dart';

class ExploreResultsCountBlocBuilder extends StatelessWidget {
  const ExploreResultsCountBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreListCubit, ExploreListState>(
      builder: (context, state) => state is ExploreListSuccess
          ? CountUpTextWidget(
              value: state.result.totalCount,
              format: (current) => 'explore.results_count'.tr(
                context: context,
                args: [current.toLocalizedDigits(context.locale.languageCode)],
              ),
              style: AppTextStyles.font13Regular,
            )
          : Text('', style: AppTextStyles.font13Regular),
    );
  }
}
