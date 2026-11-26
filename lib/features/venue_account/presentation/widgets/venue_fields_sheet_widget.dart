import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/sheet_drag_handle_widget.dart';

/// One field of a [VenueFieldsSheetWidget].
class VenueSheetField {
  const VenueSheetField({
    required this.label,
    this.initial = '',
    this.obscure = false,
    this.ltr = false,
    this.keyboardType,
  });

  final String label;
  final String initial;
  final bool obscure;
  final bool ltr;
  final TextInputType? keyboardType;
}

/// A bottom sheet with a few fields and a submit button. [onSubmit] gets the
/// values and returns the failure key (shown under the fields) or null to
/// close the sheet with `true`.
class VenueFieldsSheetWidget extends StatefulWidget {
  const VenueFieldsSheetWidget({
    required this.title,
    required this.fields,
    required this.submitText,
    required this.onSubmit,
    this.note,
    super.key,
  });

  final String title;
  final String? note;
  final List<VenueSheetField> fields;
  final String submitText;
  final Future<String?> Function(List<String> values) onSubmit;

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required List<VenueSheetField> fields,
    required String submitText,
    required Future<String?> Function(List<String> values) onSubmit,
    String? note,
  }) => showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => VenueFieldsSheetWidget(
      title: title,
      note: note,
      fields: fields,
      submitText: submitText,
      onSubmit: onSubmit,
    ),
  );

  @override
  State<VenueFieldsSheetWidget> createState() => _VenueFieldsSheetWidgetState();
}

class _VenueFieldsSheetWidgetState extends State<VenueFieldsSheetWidget> {
  late final List<TextEditingController> _controllers = [
    for (final f in widget.fields) TextEditingController(text: f.initial),
  ];
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await widget.onSubmit([for (final c in _controllers) c.text]);
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      _busy = false;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              Text(widget.title, style: AppTextStyles.font18Bold),
              if (widget.note != null) ...[
                hSpace(6),
                Text(
                  widget.note!,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
              hSpace(12),
              for (final (i, f) in widget.fields.indexed) ...[
                CustomTextFormField(
                  controller: _controllers[i],
                  labelText: f.label,
                  hintText: f.label,
                  obscureText: f.obscure,
                  keyboardType: f.keyboardType,
                  textDirection: f.ltr ? TextDirection.ltr : null,
                  autofocus: i == 0,
                ),
                hSpace(10),
              ],
              if (_error != null) ...[
                Text(
                  _error!.tr(context: context),
                  style: AppTextStyles.font12SemiBold.copyWith(
                    color: AppColors.redText,
                  ),
                ),
                hSpace(8),
              ],
              CustomButton(
                text: widget.submitText,
                height: 50.h,
                borderRadius: 14,
                isLoading: _busy,
                textStyle: AppTextStyles.font15Bold.copyWith(
                  color: AppColors.white,
                ),
                onTap: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
