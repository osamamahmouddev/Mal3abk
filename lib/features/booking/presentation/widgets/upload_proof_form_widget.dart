import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/utils/digits_only_input_formatter.dart';
import '../../../../core/widgets/fade_slide_in_widget.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_checkbox_widget.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/form_field_label_widget.dart';
import '../../../../core/widgets/icon_note_widget.dart';
import '../../data/models/player_booking_detail_model.dart';
import 'upload_proof_booking_card_widget.dart';
import 'upload_proof_dropzone_widget.dart';

class UploadProofFormWidget extends StatelessWidget {
  const UploadProofFormWidget({
    required this.booking,
    required this.fileBytes,
    required this.confirmed,
    required this.senderController,
    required this.onSenderChanged,
    this.senderError,
    required this.onPickFile,
    required this.onConfirmChanged,
    super.key,
  });

  final PlayerBookingDetailModel booking;
  final Uint8List? fileBytes;
  final bool confirmed;
  final TextEditingController senderController;
  final ValueChanged<String> onSenderChanged;
  final String? senderError;
  final VoidCallback onPickFile;
  final ValueChanged<bool> onConfirmChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(16.r),
      children: [
        FadeSlideInWidget(
          child: UploadProofBookingCardWidget(booking: booking),
        ),
        hSpace(14),
        FadeSlideInWidget(
          index: 1,
          child: UploadProofDropzoneWidget(
            fileBytes: fileBytes,
            onTap: onPickFile,
          ),
        ),
        hSpace(14),
        FadeSlideInWidget(
          index: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormFieldLabelWidget(
                label: 'booking.upload.sender_label'.tr(context: context),
              ),
              hSpace(12),
              CustomTextFormField(
                controller: senderController,
                hintText: 'booking.upload.sender_hint'.tr(context: context),
                // Only digits: a wallet number, not a name or a note.
                keyboardType: TextInputType.number,
                inputFormatters: const [
                  DigitsOnlyInputFormatter(maxLength: 11),
                ],
                errorText: senderError,
                onChanged: onSenderChanged,
                style: AppTextStyles.font15Regular,
                hintStyle: AppTextStyles.font15Regular.copyWith(
                  color: AppColors.hintText,
                ),
              ),
            ],
          ),
        ),
        hSpace(14),
        FadeSlideInWidget(
          index: 3,
          child: GestureDetector(
            onTap: () => onConfirmChanged(!confirmed),
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                AppCheckboxWidget(value: confirmed),
                vSpace(10),
                Expanded(
                  child: Text(
                    'booking.upload.confirm'.tr(context: context),
                    style: AppTextStyles.font14Regular.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        hSpace(14),
        FadeSlideInWidget(
          index: 4,
          child: IconNoteWidget(
            iconAsset: AppAssets.icInfo,
            text: 'booking.upload.note'.tr(context: context),
          ),
        ),
      ],
    );
  }
}
