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

/// Asks for a required reason (a preset or typed) before a destructive
/// action; the reason reaches the player. Returns it, or null if dismissed.
class VenueReasonSheetWidget extends HookWidget {
  const VenueReasonSheetWidget({
    required this.title,
    required this.presets,
    required this.note,
    required this.confirmText,
    super.key,
  });

  final String title;
  final List<String> presets;
  final String note;
  final String confirmText;

  static Future<String?> show(
    BuildContext context, {
    required String title,
    required List<String> presets,
    required String note,
    required String confirmText,
  }) => showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => VenueReasonSheetWidget(
      title: title,
      presets: presets,
      note: note,
      confirmText: confirmText,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final reason = useValueListenable(controller).text.trim();

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: SheetDragHandleWidget()),
              hSpace(12),
              Text(title, style: AppTextStyles.font18Bold),
              hSpace(12),
              Text(
                'venue.reason.label'.tr(context: context),
                style: AppTextStyles.font13SemiBold,
              ),
              hSpace(8),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (final p in presets)
                    ChoiceChip(
                      label: Text(p),
                      selected: reason == p,
                      onSelected: (_) => controller.text = p,
                      selectedColor: AppColors.brandNavy,
                      labelStyle: AppTextStyles.font13SemiBold.copyWith(
                        color: reason == p
                            ? AppColors.white
                            : AppColors.textBody,
                      ),
                      showCheckmark: false,
                    ),
                ],
              ),
              hSpace(12),
              CustomTextFormField(
                controller: controller,
                hintText: 'venue.reason.hint'.tr(context: context),
                minLines: 2,
                maxLines: 4,
                textInputAction: TextInputAction.done,
              ),
              hSpace(12),
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.goldLight,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  note,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.goldText,
                  ),
                ),
              ),
              hSpace(16),
              CustomButton(
                text: confirmText,
                height: 50.h,
                borderRadius: 14,
                enabled: reason.isNotEmpty && reason.length <= 500,
                backgroundColor: AppColors.brandRed,
                textStyle: AppTextStyles.font15Bold.copyWith(
                  color: AppColors.white,
                ),
                onTap: () => Navigator.of(context).pop(reason),
              ),
              hSpace(8),
              CustomButton(
                text: 'common.cancel'.tr(context: context),
                type: CustomButtonType.ghost,
                height: 44.h,
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
