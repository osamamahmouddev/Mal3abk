import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/widgets/custom_chip_widget.dart';
import '../../../reference/presentation/cubit/governorates_cubit.dart';
import '../../../reference/presentation/cubit/governorates_state.dart';
import '../cubit/leaderboard_cubit.dart';

class LeaderboardFilterBlocBuilder extends StatelessWidget {
  const LeaderboardFilterBlocBuilder({required this.selected, super.key});

  final String? selected;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    void select(String? governorate) {
      HapticFeedback.lightImpact();
      context.read<LeaderboardCubit>().load(governorate: governorate);
    }

    return BlocBuilder<GovernoratesCubit, GovernoratesState>(
      builder: (context, state) {
        final governorates = switch (state) {
          GovernoratesSuccess(:final governorates) => governorates,
          _ => const [],
        };
        return SizedBox(
          height: 38.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: governorates.length + 1,
            separatorBuilder: (_, _) => vSpace(8),
            itemBuilder: (_, index) {
              if (index == 0) {
                return CustomChipWidget(
                  label: 'teams.rankings.all_egypt'.tr(context: context),
                  isSelected: selected == null,
                  onTap: () => select(null),
                );
              }
              final governorate = governorates[index - 1];
              return CustomChipWidget(
                label: governorate.nameFor(lang),
                isSelected: selected == governorate.nameAr,
                onTap: () => select(governorate.nameAr),
              );
            },
          ),
        );
      },
    );
  }
}
