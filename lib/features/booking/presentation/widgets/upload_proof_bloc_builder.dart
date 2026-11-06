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
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/models/player_booking_detail_model.dart';
import '../cubit/proof_upload_cubit.dart';
import '../cubit/proof_upload_state.dart';
import 'upload_proof_form_widget.dart';
import 'upload_proof_submitted_widget.dart';

class UploadProofBlocBuilder extends HookWidget {
  const UploadProofBlocBuilder({required this.booking, super.key});

  final PlayerBookingDetailModel booking;

  @override
  Widget build(BuildContext context) {
    final fileBytes = useState<Uint8List?>(null);
    final confirmed = useState(false);
    final sender = useTextEditingController();

    Future<void> pick() async {
      final source = await showModalBottomSheet<ImageSource>(
        context: context,
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        builder: (sheetContext) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_rounded),
                title: Text('profile.avatar.gallery'.tr(context: context)),
                onTap: () =>
                    Navigator.of(sheetContext).pop(ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera_rounded),
                title: Text('profile.avatar.camera'.tr(context: context)),
                onTap: () => Navigator.of(sheetContext).pop(ImageSource.camera),
              ),
            ],
          ),
        ),
      );
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
                hasFile: fileBytes.value != null,
                confirmed: confirmed.value,
                senderController: sender,
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
