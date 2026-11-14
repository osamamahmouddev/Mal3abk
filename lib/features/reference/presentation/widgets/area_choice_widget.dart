import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/animations/app_animations.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/pill_choice_wrap_widget.dart';
import '../../data/models/localized_item_model.dart';

/// A governorate's areas as pills, plus "another area" for a district the
/// list doesn't have: picking it opens a field to type the name.
class AreaChoiceWidget extends HookWidget {
  const AreaChoiceWidget({required this.areas, required this.area, super.key});

  final List<LocalizedItemModel> areas;
  final ValueNotifier<String?> area;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    bool listed(String? name) => areas.any((a) => a.nameAr == name);
    final typing = useState(area.value != null && !listed(area.value));
    final selectedArea = useValueListenable(area);
    final otherIndex = areas.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PillChoiceWrapWidget(
          labels: [
            for (final a in areas) a.nameFor(lang),
            'reference.other_area'.tr(context: context),
          ],
          selectedIndex: typing.value
              ? otherIndex
              : areas.indexWhere((a) => a.nameAr == selectedArea),
          onSelect: (index) {
            if (index == otherIndex) {
              typing.value = true;
              area.value = null;
            } else {
              typing.value = false;
              area.value = areas[index].nameAr;
            }
          },
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
                      initialValue: listed(area.value) ? null : area.value,
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
