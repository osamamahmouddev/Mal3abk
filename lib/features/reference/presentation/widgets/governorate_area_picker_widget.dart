import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/picker_field_widget.dart';
import '../../../../core/widgets/searchable_picker_sheet_widget.dart';
import '../../data/models/governorate_model.dart';
import 'area_picker_widget.dart';

/// Governorate and area, each picked from a searchable sheet. Governorates
/// without a curated area list take a typed area name, as the server accepts.
class GovernorateAreaPickerWidget extends StatelessWidget {
  const GovernorateAreaPickerWidget({
    required this.label,
    required this.governorates,
    required this.governorate,
    required this.area,
    this.isRequired = true,
    super.key,
  });

  final String label;
  final List<GovernorateModel> governorates;
  final ValueNotifier<GovernorateModel?> governorate;
  final ValueNotifier<String?> area;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;

    Future<void> pickGovernorate() async {
      final current = governorate.value;
      final picked = await SearchablePickerSheetWidget.show(
        context,
        title: 'reference.governorate_label'.tr(context: context),
        options: [for (final g in governorates) g.nameFor(lang)],
        selectedIndex: current == null
            ? null
            : governorates.indexWhere((g) => g.code == current.code),
        searchHint: 'reference.search_governorate'.tr(context: context),
        emptyText: 'reference.no_results'.tr(context: context),
      );
      if (picked == null || governorates[picked].code == current?.code) return;
      governorate.value = governorates[picked];
      area.value = null;
    }

    return ValueListenableBuilder<GovernorateModel?>(
      valueListenable: governorate,
      builder: (context, selected, _) {
        final areas = selected?.areas ?? const [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isRequired ? '$label *' : label,
              style: AppTextStyles.font14SemiBold,
            ),
            hSpace(10),
            PickerFieldWidget(
              hint: 'reference.governorate_hint'.tr(context: context),
              icon: Icons.map_outlined,
              value: selected?.nameFor(lang),
              onTap: pickGovernorate,
            ),
            if (selected != null) ...[
              hSpace(10),
              if (areas.isNotEmpty)
                AreaPickerWidget(
                  key: ValueKey(selected.code),
                  areas: areas,
                  area: area,
                )
              else
                CustomTextFormField(
                  key: ValueKey(selected.code),
                  initialValue: area.value,
                  hintText: 'reference.area_hint'.tr(context: context),
                  onChanged: (value) {
                    final trimmed = value.trim();
                    area.value = trimmed.isEmpty ? null : trimmed;
                  },
                ),
            ],
          ],
        );
      },
    );
  }
}
