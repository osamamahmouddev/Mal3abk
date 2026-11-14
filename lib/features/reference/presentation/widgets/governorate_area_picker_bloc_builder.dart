import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/widgets/custom_skeleton_widget.dart';
import '../../data/models/governorate_model.dart';
import '../cubit/governorates_cubit.dart';
import '../cubit/governorates_state.dart';
import 'governorate_area_picker_widget.dart';

/// Loads governorates and shows the player's current choice: [initialCity]
/// (code or name) and [initialArea] are selected whether the governorates
/// were already loaded or arrive later. Nothing already picked is replaced.
class GovernorateAreaPickerBlocBuilder extends HookWidget {
  const GovernorateAreaPickerBlocBuilder({
    required this.label,
    required this.governorate,
    required this.area,
    this.isRequired = true,
    super.key,
    this.initialCity,
    this.initialArea,
  });

  final String label;
  final ValueNotifier<GovernorateModel?> governorate;
  final ValueNotifier<String?> area;
  final bool isRequired;
  final String? initialCity;
  final String? initialArea;

  @override
  Widget build(BuildContext context) {
    void preselect(GovernoratesState state) {
      final city = initialCity;
      if (state is! GovernoratesSuccess || city == null) return;
      if (governorate.value != null) return;
      final match = state.governorates
          .where((g) => g.matches(city))
          .firstOrNull;
      if (match == null) return;
      governorate.value = match;

      final wanted = initialArea?.trim();
      if (area.value != null || wanted == null || wanted.isEmpty) return;
      // Areas are kept by their Arabic name; one saved in English is mapped
      // back, and one not in the list stays as typed ("another area").
      final listed = match.areas
          .where(
            (a) =>
                a.nameAr == wanted ||
                a.nameEn.toLowerCase() == wanted.toLowerCase(),
          )
          .firstOrNull;
      area.value = listed?.nameAr ?? wanted;
    }

    // Already loaded when the picker opens (the usual case for a sheet).
    useEffect(() {
      preselect(context.read<GovernoratesCubit>().state);
      return null;
    }, const []);

    return BlocConsumer<GovernoratesCubit, GovernoratesState>(
      // Loaded after the picker opened.
      listenWhen: (_, current) =>
          current is GovernoratesSuccess &&
          initialCity != null &&
          governorate.value == null,
      listener: (context, state) => preselect(state),
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
