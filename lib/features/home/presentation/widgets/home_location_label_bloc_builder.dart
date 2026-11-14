import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/animations/app_animations.dart';
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
          HomeFeedSuccess(:final located) when located.near != null =>
            'home.near_me'.tr(context: context),
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
        final text = label.isEmpty
            ? 'home.all_egypt'.tr(context: context)
            : label;
        // The new place slides up into the header when the player changes it.
        return AnimatedSwitcher(
          duration: AppAnimations.duration(context, AppAnimations.slow),
          switchInCurve: AppAnimations.standard,
          switchOutCurve: AppAnimations.exit,
          layoutBuilder: (current, previous) => Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [...previous, ?current],
          ),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.5),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          child: Text(
            text,
            key: ValueKey(text),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font16Bold,
          ),
        );
      },
    );
  }
}
