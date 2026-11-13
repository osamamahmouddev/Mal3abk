import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/image_source_sheet_widget.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/models/player_booking_detail_model.dart';
import '../cubit/proof_upload_cubit.dart';
import '../cubit/proof_upload_state.dart';
import 'upload_proof_form_widget.dart';
import 'upload_proof_submitted_widget.dart';

/// The shortest sender number accepted: the last digits of the wallet that sent the transfer.
const int _minSenderDigits = 4;

class UploadProofBlocBuilder extends HookWidget {
  const UploadProofBlocBuilder({required this.booking, super.key});

  final PlayerBookingDetailModel booking;

  @override
  Widget build(BuildContext context) {
    final fileBytes = useState<Uint8List?>(null);
    final confirmed = useState(false);
    final sender = useTextEditingController();
    final senderError = useState<String?>(null);

    Future<void> pick() async {
      final choice = await ImageSourceSheetWidget.show(
        context,
        title: 'common.image_source.proof_title'.tr(context: context),
        subtitle: 'common.image_source.proof_subtitle'.tr(context: context),
      );
      final source = switch (choice) {
        ImageSourceChoice.camera => ImageSource.camera,
        ImageSourceChoice.gallery => ImageSource.gallery,
        _ => null,
      };
      if (source == null) return;
      final file = await ImagePicker().pickImage(
        source: source,
        requestFullMetadata: false,
      );
      if (file == null) return;
      fileBytes.value = await file.readAsBytes();
      HapticFeedback.selectionClick();
    }

    return BlocConsumer<ProofUploadCubit, ProofUploadState>(
      listener: (context, state) {
        if (state is ProofUploadError) {
          HapticFeedback.heavyImpact();
          AppTopSnackBar.showError(context, state.message.tr(context: context));
        } else if (state is ProofUploadSuccess) {
          HapticFeedback.mediumImpact();
          AppTopSnackBar.showSuccess(
            context,
            state.message.tr(context: context),
          );
        }
      },
      builder: (context, state) {
        if (state is ProofUploadSuccess) {
          return const UploadProofSubmittedWidget();
        }
        final isLoading = state is ProofUploadLoading;
        final ready = fileBytes.value != null && confirmed.value;

        return Column(
          children: [
            Expanded(
              child: UploadProofFormWidget(
                booking: booking,
                fileBytes: fileBytes.value,
                confirmed: confirmed.value,
                senderController: sender,
                senderError: senderError.value,
                onSenderChanged: (_) => senderError.value = null,
                onPickFile: pick,
                onConfirmChanged: (value) => confirmed.value = value,
              ),
            ),
            BottomActionBarWidget(
              child: CustomButton(
                text: 'booking.upload.submit'.tr(context: context),
                height: 52.h,
                borderRadius: 16,
                isLoading: isLoading,
                enabled: ready,
                backgroundColor: ready ? AppColors.brandRed : AppColors.border,
                boxShadow: ready ? AppShadows.redGlow : null,
                textStyle: AppTextStyles.font16Bold.copyWith(
                  color: ready ? AppColors.white : AppColors.mapLabel,
                ),
                onTap: () {
                  final bytes = fileBytes.value;
                  if (bytes == null) return;
                  FocusScope.of(context).unfocus();
                  final notes = sender.text.trim();
                  // Optional, but when given it must be at least the last four digits of the wallet or account.
                  if (notes.isNotEmpty && notes.length < _minSenderDigits) {
                    senderError.value = 'booking.upload.sender_invalid'.tr(
                      context: context,
                    );
                    HapticFeedback.heavyImpact();
                    return;
                  }
                  context.read<ProofUploadCubit>().uploadProof(
                    bookingId: booking.id,
                    imageBytes: bytes,
                    notes: notes.isEmpty ? null : notes,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
