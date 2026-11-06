import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/pill_choice_wrap_widget.dart';
import '../../data/models/governorate_model.dart';

/// Governorate dropdown plus its areas; governorates without a curated list
/// take a typed area name, as the server accepts.
class GovernorateAreaPickerWidget extends StatelessWidget {
  const GovernorateAreaPickerWidget({
    required this.label,
    required this.governorates,
    required this.governorate,
    required this.area,
    super.key,
  });

  final String label;
  final List<GovernorateModel> governorates;
  final ValueNotifier<GovernorateModel?> governorate;
  final ValueNotifier<String?> area;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;

    return ValueListenableBuilder<GovernorateModel?>(
      valueListenable: governorate,
      builder: (context, selected, _) {
        final areas = selected?.areas ?? const [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('$label *', style: AppTextStyles.font14SemiBold),
            hSpace(10),
            DropdownButtonFormField<GovernorateModel>(
              initialValue: selected,
              isExpanded: true,
              hint: Text('reference.governorate_hint'.tr(context: context)),
              borderRadius: BorderRadius.circular(14.r),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 14.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppColors.borderInput),
                ),
              ),
              items: [
                for (final item in governorates)
                  DropdownMenuItem(
                    value: item,
                    child: Text(item.nameFor(lang)),
                  ),
              ],
              onChanged: (value) {
                governorate.value = value;
                area.value = null;
              },
            ),
            if (selected != null) ...[
              hSpace(12),
              if (areas.isNotEmpty)
                ValueListenableBuilder<String?>(
                  valueListenable: area,
                  builder: (context, selectedArea, _) => PillChoiceWrapWidget(
                    labels: [for (final a in areas) a.nameFor(lang)],
                    selectedIndex: areas.indexWhere(
                      (a) => a.nameAr == selectedArea,
                    ),
                    onSelect: (index) => area.value = areas[index].nameAr,
                  ),
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
