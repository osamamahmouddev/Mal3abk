import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/sheet_drag_handle_widget.dart';
import '../../../venue_shell/presentation/venue_format.dart';

/// What to do with a free hour: book it manually or block it.
class EmptySlotChoice {
  const EmptySlotChoice.book() : book = true, reason = '', hours = 1;
  const EmptySlotChoice.block({required this.reason, required this.hours})
    : book = false;

  final bool book;
  final String reason;
  final int hours;
}

class CalendarEmptySlotSheetWidget extends HookWidget {
  const CalendarEmptySlotSheetWidget({
    required this.start,
    required this.canBook,
    required this.canBlock,
    super.key,
  });

  final DateTime start;
  final bool canBook;
  final bool canBlock;

  static Future<EmptySlotChoice?> show(
    BuildContext context, {
    required DateTime start,
    required bool canBook,
    required bool canBlock,
  }) => showModalBottomSheet<EmptySlotChoice>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => CalendarEmptySlotSheetWidget(
      start: start,
      canBook: canBook,
      canBlock: canBlock,
    ),
  );

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue.calendar.empty.$key'.tr(context: context);
    final blockMode = useState(!canBook);
    final reason = useTextEditingController();
    final reasonText = useValueListenable(reason).text.trim();
    final hours = useState(1);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(child: SheetDragHandleWidget()),
            hSpace(12),
            Text(
              'venue.calendar.empty.title'.tr(
                context: context,
                args: [VenueFormat.time(context, start.toIso8601String())],
              ),
              style: AppTextStyles.font18Bold,
            ),
            hSpace(14),
            if (!canBook && !canBlock)
              Text(t('no_permission'), style: AppTextStyles.font14Regular)
            else ...[
              if (canBook && canBlock) ...[
                SegmentedButton<bool>(
                  segments: [
                    ButtonSegment(value: false, label: Text(t('book'))),
                    ButtonSegment(value: true, label: Text(t('block'))),
                  ],
                  selected: {blockMode.value},
                  showSelectedIcon: false,
                  onSelectionChanged: (s) => blockMode.value = s.first,
                  style: SegmentedButton.styleFrom(
                    selectedBackgroundColor: AppColors.brandNavy,
                    selectedForegroundColor: AppColors.white,
                  ),
                ),
                hSpace(16),
              ],
              if (!blockMode.value)
                CustomButton(
                  text: t('open_manual'),
                  height: 50.h,
                  borderRadius: 14,
                  textStyle: AppTextStyles.font15Bold.copyWith(
                    color: AppColors.white,
                  ),
                  onTap: () =>
                      Navigator.of(context).pop(const EmptySlotChoice.book()),
                )
              else ...[
                CustomTextFormField(
                  controller: reason,
                  labelText: t('reason_label'),
                  hintText: t('reason_hint'),
                  inputFormatters: const [],
                ),
                hSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        t('hours_label'),
                        style: AppTextStyles.font14SemiBold,
                      ),
                    ),
                    IconButton.outlined(
                      onPressed: hours.value > 1 ? () => hours.value-- : null,
                      icon: const Icon(Icons.remove_rounded),
                    ),
                    SizedBox(
                      width: 44.w,
                      child: Text(
                        VenueFormat.number(context, hours.value),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.font16Bold,
                      ),
                    ),
                    IconButton.outlined(
                      onPressed: hours.value < 24 ? () => hours.value++ : null,
                      icon: const Icon(Icons.add_rounded),
                    ),
                  ],
                ),
                hSpace(16),
                CustomButton(
                  text: t('block_action'),
                  height: 50.h,
                  borderRadius: 14,
                  enabled: reasonText.isNotEmpty && reasonText.length <= 200,
                  textStyle: AppTextStyles.font15Bold.copyWith(
                    color: AppColors.white,
                  ),
                  onTap: () => Navigator.of(context).pop(
                    EmptySlotChoice.block(
                      reason: reasonText,
                      hours: hours.value,
                    ),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
