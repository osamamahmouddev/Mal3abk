import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/location_names.dart';
import '../../../reference/presentation/cubit/governorates_cubit.dart';
import '../../../reference/presentation/cubit/governorates_state.dart';
import '../cubit/home_feed_cubit.dart';
import '../cubit/home_feed_state.dart';

/// The area the home feed is for, as readable names ("مدينة نصر، القاهرة"),
/// or "All Egypt" when none is set.
class HomeLocationLabelBlocBuilder extends StatelessWidget {
  const HomeLocationLabelBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final governorates = context.select<GovernoratesCubit, GovernoratesState>(
      (cubit) => cubit.state,
    );
    return BlocBuilder<HomeFeedCubit, HomeFeedState>(
      builder: (context, state) {
        final label = switch (state) {
          HomeFeedSuccess(:final located) => LocationNames.display(
            languageCode: lang,
            governorates: switch (governorates) {
              GovernoratesSuccess(:final governorates) => governorates,
              _ => const [],
            },
            city: located.city,
            area: located.area,
          ),
          _ => '',
        };
        return Text(
          label.isEmpty ? 'home.all_egypt'.tr(context: context) : label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.font16Bold,
        );
      },
    );
  }
}
