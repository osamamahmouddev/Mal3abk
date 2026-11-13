import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_skeleton_widget.dart';
import '../../data/models/governorate_model.dart';
import '../cubit/governorates_cubit.dart';
import '../cubit/governorates_state.dart';
import 'governorate_area_picker_widget.dart';

/// Loads governorates; when [initialCity] is given (code or name) it is
/// selected once they arrive.
class GovernorateAreaPickerBlocBuilder extends StatelessWidget {
  const GovernorateAreaPickerBlocBuilder({
    required this.label,
    required this.governorate,
    required this.area,
    this.isRequired = true,
    super.key,
    this.initialCity,
  });

  final String label;
  final ValueNotifier<GovernorateModel?> governorate;
  final ValueNotifier<String?> area;
  final bool isRequired;
  final String? initialCity;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GovernoratesCubit, GovernoratesState>(
      listenWhen: (_, current) =>
          current is GovernoratesSuccess &&
          initialCity != null &&
          governorate.value == null,
      listener: (context, state) {
        if (state is! GovernoratesSuccess) return;
        governorate.value = state.governorates
            .where((g) => g.matches(initialCity!))
            .firstOrNull;
      },
      builder: (context, state) => switch (state) {
        GovernoratesSuccess(:final governorates) => GovernorateAreaPickerWidget(
          label: label,
          governorates: governorates,
          governorate: governorate,
          area: area,
          isRequired: isRequired,
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
