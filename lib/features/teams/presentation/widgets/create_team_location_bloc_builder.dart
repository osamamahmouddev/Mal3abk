import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_skeleton_widget.dart';
import '../../../reference/data/models/governorate_model.dart';
import '../../../reference/presentation/cubit/governorates_cubit.dart';
import '../../../reference/presentation/cubit/governorates_state.dart';
import 'create_team_location_widget.dart';

class CreateTeamLocationBlocBuilder extends StatelessWidget {
  const CreateTeamLocationBlocBuilder({
    required this.governorate,
    required this.area,
    super.key,
  });

  final ValueNotifier<GovernorateModel?> governorate;
  final ValueNotifier<String?> area;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GovernoratesCubit, GovernoratesState>(
      builder: (context, state) => switch (state) {
        GovernoratesSuccess(:final governorates) => CreateTeamLocationWidget(
          governorates: governorates,
          governorate: governorate,
          area: area,
        ),
        GovernoratesError() => TextButton(
          onPressed: () => context.read<GovernoratesCubit>().load(),
          child: const Icon(Icons.refresh),
        ),
        _ => const CustomSkeletonWidget(height: 52, borderRadius: 12),
      },
    );
  }
}
