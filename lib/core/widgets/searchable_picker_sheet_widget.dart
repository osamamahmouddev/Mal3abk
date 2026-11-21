import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import '../utils/search_text.dart';
import 'custom_search_field_widget.dart';
import 'picker_option_tile_widget.dart';
import 'sheet_drag_handle_widget.dart';

/// A bottom sheet to pick one of [options], with a search box that matches
/// loosely (Arabic spelling variants, case). [extraOption] is an always-shown
/// last choice such as "another area"; picking it returns `options.length`.
class SearchablePickerSheetWidget extends HookWidget {
  const SearchablePickerSheetWidget({
    required this.title,
    required this.options,
    required this.searchHint,
    required this.emptyText,
    this.selectedIndex,
    this.extraOption,
    super.key,
  });

  final String title;
  final List<String> options;
  final int? selectedIndex;
  final String searchHint;
  final String emptyText;
  final String? extraOption;

  /// The picked index, or null when dismissed.
  static Future<int?> show(
    BuildContext context, {
    required String title,
    required List<String> options,
    required String searchHint,
    required String emptyText,
    int? selectedIndex,
    String? extraOption,
  }) => showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => SearchablePickerSheetWidget(
      title: title,
      options: options,
      selectedIndex: selectedIndex,
      searchHint: searchHint,
      emptyText: emptyText,
      extraOption: extraOption,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final query = useState('');
    final visible = useMemoized(
      () => [
        for (var i = 0; i < options.length; i++)
          if (SearchText.matches(options[i], query.value)) i,
      ],
      [query.value, options],
    );
    void pick(int index) {
      HapticFeedback.selectionClick();
      Navigator.of(context).pop(index);
    }

    final media = MediaQuery.of(context);
    return Container(
      constraints: BoxConstraints(maxHeight: media.size.height * 0.78),
      padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          hSpace(12),
          const SheetDragHandleWidget(),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
            child: Text(title, style: AppTextStyles.font18Bold),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomSearchFieldWidget(
              hintText: searchHint,
              onChanged: (value) => query.value = value,
            ),
          ),
          hSpace(8),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 16.h),
              children: [
                for (final i in visible)
                  PickerOptionTileWidget(
                    label: options[i],
                    isSelected: i == selectedIndex,
                    onTap: () => pick(i),
                  ),
                if (visible.isEmpty)
                  Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Text(
                      emptyText,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font13Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                if (extraOption != null)
                  PickerOptionTileWidget(
                    label: extraOption!,
                    icon: Icons.edit_location_alt_outlined,
                    isSelected: selectedIndex == options.length,
                    onTap: () => pick(options.length),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
