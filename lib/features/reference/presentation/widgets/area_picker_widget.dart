import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/animations/app_animations.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/picker_field_widget.dart';
import '../../../../core/widgets/searchable_picker_sheet_widget.dart';
import '../../data/models/localized_item_model.dart';

/// A governorate's area picked from a searchable list, plus "another area"
/// for a district the list doesn't have: picking it opens a field to type the
/// name. [area] holds the Arabic name, as the server stores it.
class AreaPickerWidget extends HookWidget {
  const AreaPickerWidget({required this.areas, required this.area, super.key});

  final List<LocalizedItemModel> areas;
  final ValueNotifier<String?> area;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final selectedArea = useValueListenable(area);
    final listedIndex = areas.indexWhere((a) => a.nameAr == selectedArea);
    final typing = useState(selectedArea != null && listedIndex < 0);

    Future<void> open() async {
      final picked = await SearchablePickerSheetWidget.show(
        context,
        title: 'reference.area_label'.tr(context: context),
        options: [for (final a in areas) a.nameFor(lang)],
        selectedIndex: typing.value ? areas.length : listedIndex,
        searchHint: 'reference.search_area'.tr(context: context),
        emptyText: 'reference.no_results'.tr(context: context),
        extraOption: 'reference.other_area'.tr(context: context),
      );
      if (picked == null) return;
      if (picked == areas.length) {
        typing.value = true;
        if (listedIndex >= 0) area.value = null;
      } else {
        typing.value = false;
        area.value = areas[picked].nameAr;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PickerFieldWidget(
          hint: 'reference.area_pick_hint'.tr(context: context),
          icon: Icons.place_outlined,
          value: typing.value
              ? 'reference.other_area'.tr(context: context)
              : listedIndex >= 0
              ? areas[listedIndex].nameFor(lang)
              : null,
          onTap: open,
        ),
        AnimatedSize(
          duration: AppAnimations.duration(context, AppAnimations.base),
          curve: AppAnimations.standard,
          child: typing.value
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    hSpace(10),
                    CustomTextFormField(
                      initialValue: listedIndex >= 0 ? null : selectedArea,
                      hintText: 'reference.area_hint'.tr(context: context),
                      onChanged: (value) {
                        final trimmed = value.trim();
                        area.value = trimmed.isEmpty ? null : trimmed;
                      },
                    ),
                  ],
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}
