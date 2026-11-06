import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/app_text_styles.dart';
import '../cubit/home_feed_cubit.dart';
import '../cubit/home_feed_state.dart';

/// The player's area and city, or "All Egypt" when they haven't set one.
class HomeLocationLabelBlocBuilder extends StatelessWidget {
  const HomeLocationLabelBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeFeedCubit, HomeFeedState>(
      builder: (context, state) {
        final label = switch (state) {
          HomeFeedSuccess(:final located) => [
            ?located.area,
            ?located.city,
          ].where((part) => part.isNotEmpty).join('، '),
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
